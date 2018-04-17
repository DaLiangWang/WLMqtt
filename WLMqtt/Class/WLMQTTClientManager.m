//
//  MQTTClientManager.m
//  mqtt
//
//  Created by 王亮 on 2018/4/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "WLMQTTClientManager.h"
#import "MQTTClient.h"


#define mqttIp @"172.16.3.225"
#define mqttPort 3563

@interface WLMQTTClientManager ()<MQTTSessionDelegate>{
    //标示ID
    NSString *_clientID;
    //独立基数
    NSInteger _pushNum;
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
        self.ip = mqttIp;
        self.port = mqttPort;
        _pushNum = 1;
    }
    return self;
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

-(void)setIp:(NSString *)Ip Port:(UInt16)port{
    self.ip = Ip;
    self.port = port;
}

/**
 mqtt链接方法
 
 @param clientID 唯一标示
 @param messageTopicBlock 收到消息回掉
 @param MQTTReceiveServerStatus 链接状态回掉
 */
-(void)loginWithClientID:(NSString *)clientID
       messageTopicBlock:(messageTopicBlock)messageTopicBlock
 MQTTReceiveServerStatus:(MQTTReceiveServerStatus)MQTTReceiveServerStatus{
    [self loginWithClientID:clientID
                         Ip:self.ip
                       port:self.port
                   userName:@""
                   password:@""
          messageTopicBlock:messageTopicBlock
    MQTTReceiveServerStatus:MQTTReceiveServerStatus
                   delegate:nil];
}
/**
 mqtt链接方法
 
 @param clientID 唯一标示
 @param delegate 代理
 */
-(void)loginWithClientID:(NSString *)clientID
                delegate:(id)delegate{
    [self loginWithClientID:clientID
                         Ip:self.ip
                       port:self.port
                   userName:@""
                   password:@""
          messageTopicBlock:nil
    MQTTReceiveServerStatus:nil
                   delegate:delegate];
}
/**
 mqtt链接方法

 @param clientID 唯一标示
 @param ip ip地址
 @param port 端口
 @param userName 登录用户名
 @param password 密码
 @param messageTopicBlock 收到消息回掉
 @param MQTTReceiveServerStatus 链接状态回掉
 @param delegate 代理
 */
-(void)loginWithClientID:(NSString *)clientID
                      Ip:(NSString *)ip
                    port:(UInt16)port
                userName:(NSString *)userName
                password:(NSString *)password
       messageTopicBlock:(messageTopicBlock)messageTopicBlock
MQTTReceiveServerStatus:(MQTTReceiveServerStatus)MQTTReceiveServerStatus
                delegate:(id)delegate{
    _clientID = clientID;
    self.messageTopicBlock = messageTopicBlock;
    self.MQTTReceiveServerStatus = MQTTReceiveServerStatus;

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
//    _topic=nil;//单个主题订阅
//    _topics=nil;//多个主题订阅
}

/**
 解除代理
 
 @param obj 需要接触代理的对象
 */
-(void)unRegisterDelegate:(id)obj{
    self.delegate=nil;
}

/*发送数据*/
-(void)push:(NSData *)data
      topic:(NSString *)topic
     isBack:(BOOL)isBack{
//    GPBMessage *dataPGB = data;
    if (isBack) {
        topic = [NSString stringWithFormat:@"%@/%ld",topic,_pushNum];
        [self.mqttSession publishData:data onTopic:topic];
        _pushNum ++;
    }
    else{
        [self.mqttSession publishData:data onTopic:topic];
    }
    //    [self.mqttSession subscribeTopic:topic];
}
#pragma mark MQTTClientManagerDelegate
/*连接成功回调*/
-(void)connected:(MQTTSession *)session{
    NSLog(@"-----------------MQTT成功建立连接-----------------");
//    if (_topic) {
//        NSLog(@"-----------------MQTT链接-----------------");
//        [self.mqttSession subscribeTopic:_topic];
//    }else if(_topics){
//        NSLog(@"-----------------MQTT订阅多个个主题-----------------");
//        [self.mqttSession subscribeToTopics:_topics];
//    }
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
    [self messageBlockTopic:topic data:dic jsonStr:jsonStr];
}
/** 当连接成功建立时被调用 */
- (void)connected:(MQTTSession *)session sessionPresent:(BOOL)sessionPresent{
    NSLog(@"-----------------连接成功建立-----------------");
}

/** 当发布的消息实际传递时被调用 */
- (void)messageDelivered:(MQTTSession *)session
                   msgID:(UInt16)msgID
                   topic:(NSString *)topic
                    data:(NSData *)data
                     qos:(MQTTQosLevel)qos
              retainFlag:(BOOL)retainFlag{
    NSLog(@"\n发布数据:\n---msgId：%d\n---topic：%@\n---data：%@\n---qos：%hhu\n---retainFlag:%@\n",msgID,topic,data,qos,retainFlag?@"YES":@"NO");
}

/** 当 MQTTClients 内部缓冲区的内容更改时调用
 用于监视传输和接收的消息的完成情况
 @param flowingIn MQTTClient 尚未确认的传入消息数
 @param flowingOut the number MQTT 代理尚未确认的传出消息数
 */
- (void)buffered:(MQTTSession *)session
       flowingIn:(NSUInteger)flowingIn
      flowingOut:(NSUInteger)flowingOut{
    NSLog(@"尚未确认的传入消息数:%ld----尚未确认的传出消息数:%ld",flowingIn,flowingOut);
}


#pragma make --回掉--
//收到信息
-(void)messageBlockTopic:(NSString *)topic data:(NSDictionary *)dic jsonStr:(NSString *)jsonStr{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageTopic:data:jsonStr:)]) {
        [self.delegate messageTopic:topic data:dic jsonStr:jsonStr];
    }
    if (self.messageTopicBlock) {
        self.messageTopicBlock(topic, dic, jsonStr);
    }
}
//连接状态
-(void)didBlockMQTTReceiveServerStatus:(WLMQTTStatus *)mqttStatus{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didMQTTReceiveServerStatus:)]) {
        [self.delegate didMQTTReceiveServerStatus:mqttStatus];
    }
    if (self.MQTTReceiveServerStatus) {
        self.MQTTReceiveServerStatus(mqttStatus);
    }
}
@end
