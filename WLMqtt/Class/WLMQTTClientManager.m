//
//  MQTTClientManager.m
//  mqtt
//
//  Created by 王亮 on 2018/4/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "WLMQTTClientManager.h"
#import "MQTTClient.h"
#import "MQTTLog.h"


//#define mqttIp @"172.16.3.225"
//#define mqttPort 3563

@interface WLMQTTClientManager ()<MQTTSessionDelegate>{
    //标示ID
    NSString *_clientID;
    //独立基数
    NSInteger _pushNum;
    //推送中的消息Topic
    NSMutableArray *_pushInTopicList;
    //连接状态 只有连接上后为YES
    BOOL _isConnection;
    //重连次数
    NSInteger _recNum;
    //创建一个定时器模式的事件源
    dispatch_source_t _timer;
}
@property(nonatomic, weak)      id<WLMQTTClientManagerDelegate> delegate;//代理
@property(nonatomic, strong)    MQTTSession *mqttSession;//链接
@property(nonatomic, strong)    MQTTCFSocketTransport *transport;//连接服务器属性
@property(nonatomic, strong)    NSString *ip;//服务器ip地址
@property(nonatomic)            UInt16 port;//服务器ip地址
@property(nonatomic, strong)    NSString *userName;//用户名
@property(nonatomic, strong)    NSString *password;//密码
@property(nonatomic, strong)    WLMQTTStatus *mqttStatus;//连接服务器状态

@end

@implementation WLMQTTClientManager
#pragma mark 对外方法
/**
 单例
 */
+(WLMQTTClientManager *)shareInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.ip = mqttIp;
//        self.port = mqttPort;
#ifdef DEBUG
        [MQTTLog setLogLevel:DDLogLevelAll];
#else
        [MQTTLog setLogLevel:DDLogLevelOff];
#endif
        self.reconnectTime = @"5";
        self.reconnectNum = 2;
        _recNum = self.reconnectNum;
        
        _pushNum = 1;
        _pushInTopicList = [NSMutableArray array];
    }
    return self;
}

-(void)setIp:(NSString *)Ip Port:(UInt16)port{
    self.ip = Ip;
    self.port = port;
}
-(void)setUserName:(NSString *)userName Password:(NSString *)password{
    self.userName = userName;
    self.password = password;
}

/**
 mqtt链接方法
 
 @param clientID 唯一标示
 */
-(void)loginWithClientID:(NSString *)clientID delegate:(id)delegate{
    [self loginWithClientID:clientID
                         Ip:self.ip
                       port:self.port
                   userName:self.userName
                   password:self.password
                   delegate:delegate];
}

/**
 mqtt链接方法

 @param clientID 唯一标示
 @param ip ip地址
 @param port 端口
 @param userName 登录用户名
 @param password 密码
 @param delegate 代理
 */
-(void)loginWithClientID:(NSString *)clientID
                      Ip:(NSString *)ip
                    port:(UInt16)port
                userName:(NSString *)userName
                password:(NSString *)password
                delegate:(id)delegate{
    //(6)取消定时器dispatch源，【必须】
    if (_timer){
        dispatch_cancel(_timer);
    }
    [_mqttSession close];

    if(!ip) {DDLogInfo(@"!!!!!!!!!!!!%@!!!!!!!!!!!!",@"未设置IP地址"); return;}
    if(!port) {DDLogInfo(@"!!!!!!!!!!!!%@!!!!!!!!!!!!",@"未设置port端口号"); return;}
    if(!clientID) {DDLogInfo(@"!!!!!!!!!!!!%@!!!!!!!!!!!!",@"未设置clientID地址"); return;}
    
    if(!userName) {DDLogInfo(@"---------%@---------",@"未设置账号");}
    if(!password) {DDLogInfo(@"---------%@---------",@"未设置密码");}

    DDLogInfo(@"重置重新连接次数：%ld次",_recNum);
    _recNum = self.reconnectNum;
    

    self.delegate = delegate;
    _clientID = clientID;
    [self loginMQTTHost:ip port:port userName:userName password:password];
}

/*实际登陆处理*/
-(void)loginMQTTHost:(NSString *)host port:(UInt16)port userName:(NSString *)userName password:(NSString *)password{
    /*设置ip和端口号*/
    self.transport.host=host;
    self.transport.port=port;
    
    /*设置MQTT账号和密码*/
    self.mqttSession.transport = self.transport;//给MQTTSession对象设置基本信息
    self.mqttSession.delegate = self;//设置代理
    

    [self.mqttSession setUserName:userName];
    [self.mqttSession setPassword:password];
    
    //会话链接并设置超时时间
    [self.mqttSession connectAndWaitTimeout:[self.reconnectTime intValue]];
}
/** 重新连接 */
-(void)rewiring{
    [self loginMQTTHost:self.ip port:self.port userName:self.userName password:self.password];
}
/** 断开连接，清空数据 */
-(void)close{
    [_mqttSession close];
    _delegate=nil;//代理
    _mqttSession=nil;
    _transport=nil;//连接服务器属性
    _ip=nil;//服务器ip地址
    _port=0;//服务器ip地址
    _userName=nil;//用户名
    _password=nil;//密码
    _pushInTopicList = nil;
}

/** 绑定代理 */
-(void)bindingDelegate:(id)obj{
    self.delegate = nil;
    self.delegate = obj;
}

/** 解除代理 */
-(void)unRegisterDelegate;{
    self.delegate = nil;
}


/** 发送消息 自己管理 分发机制 */
-(NSString *)push:(NSData *)data topic:(NSString *)topic{
    [self push:data topic:topic isBack:NO];
    return topic;
}
/*发送数据*/
-(NSString *)push:(NSData *)data topic:(NSString *)topic isBack:(BOOL)isBack{
    if (isBack) {
        topic = [NSString stringWithFormat:@"%@/%ld",topic,(long)_pushNum];
        [_pushInTopicList addObject:topic];
        _pushNum ++;
    }
    [self.mqttSession publishData:data onTopic:topic];
    return topic;
}

#pragma mark MQTTClientManagerDelegate
/*连接成功回调*/
-(void)connected:(MQTTSession *)session{
    DDLogInfo(@"-----------------MQTT成功建立连接-----------------");
    _isConnection = YES;
    _recNum = self.reconnectNum;
    
    [self didBlockMQTTReceiveServerStatus:WLMQTTStatusCodeConnected];
}
/*连接状态回调*/
-(void)handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error{
/*
 @(MQTTSessionEventConnected): @"链接成功",
 @(MQTTSessionEventConnectionRefused): @"拒绝连接",
 @(MQTTSessionEventConnectionClosed): @"链接关闭",
 @(MQTTSessionEventConnectionError): @"链接错误",
 @(MQTTSessionEventProtocolError): @"protocoll 错误",
 @(MQTTSessionEventConnectionClosedByBroker): @"连接代理关闭"
 */
    switch (eventCode) {
            case MQTTSessionEventConnected:
            [self didBlockMQTTReceiveServerStatus:WLMQTTStatusCodeConnected];
            break;
            case MQTTSessionEventConnectionRefused:
            [self didBlockMQTTReceiveServerStatus:WLMQTTStatusCodeConnectedRefused];
            break;
            case MQTTSessionEventConnectionClosed:
            [self didBlockMQTTReceiveServerStatus:WLMQTTStatusCodeConnectedClosed];
            break;
            case MQTTSessionEventConnectionError:
            [self didBlockMQTTReceiveServerStatus:WLMQTTStatusCodeConnectedError];
            break;
            case MQTTSessionEventProtocolError:
            [self didBlockMQTTReceiveServerStatus:WLMQTTStatusCodeProtocolError];
            break;
            case MQTTSessionEventConnectionClosedByBroker:
            [self didBlockMQTTReceiveServerStatus:WLMQTTStatusCodeConnectedClosedByBroker];
            break;
        default:
            break;
    }
    DDLogInfo(@"-----------------MQTT连接状态-----%@-----------------",self.mqttStatus.statusInfo);
    if (eventCode == MQTTSessionEventConnectionClosed){//如果连接关闭
        if (_isConnection){//是连接成功后的断线
            if (_recNum > 0){
                [self didBlockMQTTReceiveServerStatus:WLMQTTStatusCodeReconnect];
                [self reconnectTime:self.reconnectTime];
            }
            else{
                [self didBlockMQTTReceiveServerStatus:WLMQTTStatusCodeReconnectFailure];
                DDLogInfo(@"-----------------断线重连超时，失败-----------------");
                //(6)取消定时器dispatch源，【必须】
                if (_timer){
                    dispatch_cancel(_timer);
                }
//                [_mqttSession close];
            }
        }
        else{//不是断线重连
            if (_recNum > 0){
                [self didBlockMQTTReceiveServerStatus:WLMQTTStatusCodeConnectedReconnect];
                [self reconnectTime:self.reconnectTime];
            }
            else{
                [self didBlockMQTTReceiveServerStatus:WLMQTTStatusCodeConnectedReconnectFailure];
                DDLogInfo(@"-----------------连接超时，失败-----------------");
                //(6)取消定时器dispatch源，【必须】
                if (_timer){
                    dispatch_cancel(_timer);
                }
//                [_mqttSession close];
            }
        }
    }
}
-(void)reconnectTime:(NSString *)time{
    __block NSInteger second = [time integerValue];
    //(1)获取或者创建一个队列，一般情况下获取一个全局的队列
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //(2)创建一个定时器模式的事件源
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //(3)设置定时器的响应间隔
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //(4)设置定时器事件源的响应回调，当定时事件发生时，执行此回调
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                [self performSelector:@selector(todoSomething) withObject:nil afterDelay:1.2f];
                //(6)取消定时器dispatch源，【必须】
                dispatch_cancel(_timer);
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    DDLogInfo(@"-----------------%ld秒后重连-----------------",(long)second);
                });
                second--;
            }
        });
    });
    //(5)启动定时器事件
    dispatch_resume(_timer);
}
-(void)todoSomething{
    DDLogInfo(@"-----------------重连中-----------------");
    if (_recNum > 0){
        [self loginMQTTHost:self.ip port:self.port userName:self.userName password:self.password];
    }
    _recNum --;
    DDLogInfo(@"-----------------重连(剩余%ld次)-----------------",(long)_recNum);
}
/*收到消息*/
-(void)newMessage:(MQTTSession *)session
             data:(NSData *)data
          onTopic:(NSString *)topic
              qos:(MQTTQosLevel)qos
         retained:(BOOL)retained
              mid:(unsigned int)mid{
//    NSString *jsonStr=[NSString stringWithUTF8String:data.bytes];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//
    DDLogInfo(@"-----------------MQTT收到消息主题：%@",topic);
    if ([_pushInTopicList containsObject:topic]){//服务器回馈自己的回掉
        [self messageSelfBlockTopic:topic data:data];
        [_pushInTopicList removeObject:topic];
    }
    else{//服务器的广播回掉
        [self messageBlockTopic:topic data:data];
    }
}


/** 向服务器推送消息通知 */
- (void)messageDelivered:(MQTTSession *)session
                   msgID:(UInt16)msgID
                   topic:(NSString *)topic
                    data:(NSData *)data
                     qos:(MQTTQosLevel)qos
              retainFlag:(BOOL)retainFlag{
    DDLogInfo(@"\n发布数据:\n---msgId：%d\n---topic：%@\n---data：%@\n---qos：%hhu\n---retainFlag:%@\n",msgID,topic,data,qos,retainFlag?@"YES":@"NO");
    [self WLMessageDelivered:session msgID:msgID topic:topic data:data qos:qos retainFlag:retainFlag];
}

/**  用于监视传输和接收的消息的完成情况
 @param flowingIn MQTTClient 尚未确认的传入消息数
 @param flowingOut the number MQTT 代理尚未确认的传出消息数
 */
- (void)buffered:(MQTTSession *)session
       flowingIn:(NSUInteger)flowingIn
      flowingOut:(NSUInteger)flowingOut{
    DDLogInfo(@"尚未确认的传入消息数:%lu----尚未确认的传出消息数:%lu",(unsigned long)flowingIn,(unsigned long)flowingOut);
    [self WLMonitorFlowingIn:flowingIn flowingOut:flowingOut];
}




#pragma make --回掉--
/** 服务器推送回掉信息获取回掉 */
-(void)messageBlockTopic:(NSString *)topic data:(NSData *)data{
    if (self.delegate && [self.delegate respondsToSelector:@selector(WLMessageTopic:data:)]) {
        [self.delegate WLMessageTopic:topic data:data];
    }
    if (self.messageTopicBlock) {
        self.messageTopicBlock(topic, data);
    }
}
/** 向服务器推送消息回馈 区别于（WLMessageTopicBlock）属于自己消息的回馈 */
-(void)messageSelfBlockTopic:(NSString *)topic data:(NSData *)data{
    if (self.delegate && [self.delegate respondsToSelector:@selector(WLMessageSelfTopic:data:)]) {
        [self.delegate WLMessageSelfTopic:topic data:data];
    }
    if (self.messageSelfTopicBlock) {
        self.messageSelfTopicBlock(topic, data);
    }
}
/** 连接状态回掉 */
-(void)didBlockMQTTReceiveServerStatus:(WLMQTTStatusCode)MQTTStatusCode{
    self.mqttStatus.WLMQTTStatusCode = MQTTStatusCode;
//    [self.mqttStatus setWLMQTTStatusCode:MQTTStatusCode];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(WLDidMQTTReceiveServerStatus:)]) {
        [self.delegate WLDidMQTTReceiveServerStatus:self.mqttStatus];
    }
    if (self.MQTTReceiveServerStatus) {
        self.MQTTReceiveServerStatus(self.mqttStatus);
    }
}
/** 本机push传输情况回掉 */
-(void)WLMonitorFlowingIn:(NSInteger)in flowingOut:(NSInteger)Out{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(WLMonitorFlowingIn:flowingOut:)]) {
        [self.delegate WLMonitorFlowingIn:in flowingOut:Out];
    }
    if (self.monitorFlowing) {
        self.monitorFlowing(in,Out);
    }
}
/** 向服务器推送消息通知 */
- (void)WLMessageDelivered:(MQTTSession *)session
                   msgID:(UInt16)msgID
                   topic:(NSString *)topic
                    data:(NSData *)data
                     qos:(MQTTQosLevel)qos
              retainFlag:(BOOL)retainFlag{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(WLMessageDeliveredMsgID:topic:data:retainFlag:)]) {
        [self.delegate WLMessageDeliveredMsgID:msgID topic:topic data:data retainFlag:retainFlag];
    }
    if (self.messageDeliveredMsgID) {
        self.messageDeliveredMsgID(msgID,topic,data,retainFlag);
    }
}



#pragma mark 懒加载
-(MQTTSession *)mqttSession{
    if (!_mqttSession) {
        _mqttSession = [[MQTTSession alloc] initWithClientId:_clientID];
        
        
    }
    return _mqttSession;
}

-(MQTTCFSocketTransport *)transport{
    if (!_transport) {
        _transport=[[MQTTCFSocketTransport alloc] init];
    }
    return _transport;
}
-(WLMQTTStatus *)mqttStatus{
    if (!_mqttStatus) {
        _mqttStatus=[[WLMQTTStatus alloc] init];
    }
    return _mqttStatus;
}
@end
