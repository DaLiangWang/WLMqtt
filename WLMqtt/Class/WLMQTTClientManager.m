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
    if(!ip) {NSLog(@"!!!!!!!!!!!!%@!!!!!!!!!!!!",@"未设置IP地址"); return;}
    if(!port) {NSLog(@"!!!!!!!!!!!!%@!!!!!!!!!!!!",@"未设置port端口号"); return;}
    if(!clientID) {NSLog(@"!!!!!!!!!!!!%@!!!!!!!!!!!!",@"未设置clientID地址"); return;}
    
    if(!userName) {NSLog(@"---------%@---------",@"未设置账号");}
    if(!password) {NSLog(@"---------%@---------",@"未设置密码");}

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
    [self.mqttSession connectAndWaitTimeout:20];
}
/**
 断开连接，清空数据
 */
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

/*发送数据*/
-(void)push:(NSData *)data
      topic:(NSString *)topic
     isBack:(BOOL)isBack{
    if (isBack) {
        topic = [NSString stringWithFormat:@"%@/%ld",topic,(long)_pushNum];
        [_pushInTopicList addObject:topic];
        _pushNum ++;
    }
    
    [self.mqttSession publishData:data onTopic:topic];
}
#pragma mark MQTTClientManagerDelegate
/*连接成功回调*/
-(void)connected:(MQTTSession *)session{
    NSLog(@"-----------------MQTT成功建立连接-----------------");
    [self didBlockMQTTReceiveServerStatus:self.mqttStatus];
}
/*连接状态回调*/
-(void)handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error{
    NSDictionary *events = @{
                             @(MQTTSessionEventConnected): @"链接成功",
                             @(MQTTSessionEventConnectionRefused): @"拒绝连接",
                             @(MQTTSessionEventConnectionClosed): @"链接关闭",
                             @(MQTTSessionEventConnectionError): @"链接错误",
                             @(MQTTSessionEventProtocolError): @"protocoll 错误",
                             @(MQTTSessionEventConnectionClosedByBroker): @"连接代理关闭"
                             };
    [self.mqttStatus setStatusCode:eventCode];
    [self.mqttStatus setStatusInfo:[events objectForKey:@(eventCode)]];
    [self didBlockMQTTReceiveServerStatus:self.mqttStatus];
    NSLog(@"-----------------MQTT连接状态%@-----------------",[events objectForKey:@(eventCode)]);
}

/*收到消息*/
-(void)newMessage:(MQTTSession *)session
             data:(NSData *)data
          onTopic:(NSString *)topic
              qos:(MQTTQosLevel)qos
         retained:(BOOL)retained
              mid:(unsigned int)mid{
    NSString *jsonStr=[NSString stringWithUTF8String:data.bytes];
//    NSLog(@"-----------------MQTT收到消息主题：%@内容：%@",topic,jsonStr);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    if ([_pushInTopicList containsObject:topic]){//服务器回馈自己的回掉
        [self messageSelfBlockTopic:topic data:dic jsonStr:jsonStr];
        [_pushInTopicList removeObject:topic];
    }
    else{//服务器的广播回掉
        [self messageBlockTopic:topic data:dic jsonStr:jsonStr];
    }
}
///** 当连接成功建立时被调用 */
//- (void)connected:(MQTTSession *)session sessionPresent:(BOOL)sessionPresent{
//    NSLog(@"-----------------连接成功建立-----------------");
//}

/** 向服务器推送消息通知 */
- (void)messageDelivered:(MQTTSession *)session
                   msgID:(UInt16)msgID
                   topic:(NSString *)topic
                    data:(NSData *)data
                     qos:(MQTTQosLevel)qos
              retainFlag:(BOOL)retainFlag{
//    NSLog(@"\n发布数据:\n---msgId：%d\n---topic：%@\n---data：%@\n---qos：%hhu\n---retainFlag:%@\n",msgID,topic,data,qos,retainFlag?@"YES":@"NO");
    [self WLMessageDelivered:session msgID:msgID topic:topic data:data qos:qos retainFlag:retainFlag];
}

/**  用于监视传输和接收的消息的完成情况
 @param flowingIn MQTTClient 尚未确认的传入消息数
 @param flowingOut the number MQTT 代理尚未确认的传出消息数
 */
- (void)buffered:(MQTTSession *)session
       flowingIn:(NSUInteger)flowingIn
      flowingOut:(NSUInteger)flowingOut{
    NSLog(@"尚未确认的传入消息数:%lu----尚未确认的传出消息数:%lu",(unsigned long)flowingIn,(unsigned long)flowingOut);
    [self WLMonitorFlowingIn:flowingIn flowingOut:flowingOut];
}




#pragma make --回掉--
/** 服务器推送回掉信息获取回掉 */
-(void)messageBlockTopic:(NSString *)topic data:(NSDictionary *)dic jsonStr:(NSString *)jsonStr{
    if (self.delegate && [self.delegate respondsToSelector:@selector(WLMessageTopic:data:jsonStr:)]) {
        [self.delegate WLMessageTopic:topic data:dic jsonStr:jsonStr];
    }
    if (self.messageTopicBlock) {
        self.messageTopicBlock(topic, dic, jsonStr);
    }
}
/** 向服务器推送消息回馈 区别于（WLMessageTopicBlock）属于自己消息的回馈 */
-(void)messageSelfBlockTopic:(NSString *)topic data:(NSDictionary *)dic jsonStr:(NSString *)jsonStr{
    if (self.delegate && [self.delegate respondsToSelector:@selector(WLMessageSelfTopic:data:jsonStr:)]) {
        [self.delegate WLMessageSelfTopic:topic data:dic jsonStr:jsonStr];
    }
    if (self.messageSelfTopicBlock) {
        self.messageSelfTopicBlock(topic, dic, jsonStr);
    }
}
/** 连接状态回掉 */
-(void)didBlockMQTTReceiveServerStatus:(WLMQTTStatus *)mqttStatus{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(WLDidMQTTReceiveServerStatus:)]) {
        [self.delegate WLDidMQTTReceiveServerStatus:mqttStatus];
    }
    if (self.MQTTReceiveServerStatus) {
        self.MQTTReceiveServerStatus(mqttStatus);
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
