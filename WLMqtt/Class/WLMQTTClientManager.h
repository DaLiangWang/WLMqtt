//
//  MQTTClientManager.m
//  mqtt
//
//  Created by 王亮 on 2018/4/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLMQTTClientManagerDelegate.h"

@interface WLMQTTClientManager : NSObject

/**
 单例
 
 @return self
 */
+(WLMQTTClientManager *)shareInstance;

/** 信息获取回掉 */
@property(nonatomic,copy) WLMessageTopicBlock messageTopicBlock;
/** 连接状态回掉 */
@property(nonatomic,copy) WLMQTTReceiveServerStatus MQTTReceiveServerStatus;
/** 传输情况回掉 */
@property(nonatomic,copy) WLMonitorFlowing monitorFlowing;
/** 当发布的消息实际传递时被调用 */
@property(nonatomic,copy) WLMessageDeliveredMsgID messageDeliveredMsgID;


/**
 设置地址

 @param Ip 连接地址
 @param port 端口
 */
-(void)setIp:(NSString *)Ip Port:(UInt16)port;

/**
 设置账号密码

 @param userName 账号
 @param password 密码
 */
-(void)setUserName:(NSString *)userName Password:(NSString *)password;



/**
 mqtt链接方法
 
 @param clientID 唯一标示
 */
-(void)loginWithClientID:(NSString *)clientID;

/**
 mqtt链接方法
 
 @param clientID 唯一标示
 @param messageTopicBlock 收到消息回掉
 @param MQTTReceiveServerStatus 链接状态回掉
 */
-(void)loginWithClientID:(NSString *)clientID
       messageTopicBlock:(WLMessageTopicBlock)messageTopicBlock
 WLMessageDeliveredMsgID:(WLMessageDeliveredMsgID)messageDeliveredMsgID
 MQTTReceiveServerStatus:(WLMQTTReceiveServerStatus)MQTTReceiveServerStatus
          monitorFlowing:(WLMonitorFlowing)monitorFlowing;

/**
 MQTT链接
 
 @param ip 服务器ip
 @param port 服务器端口
 @param userName 用户名
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
       messageTopicBlock:(WLMessageTopicBlock)messageTopicBlock
 WLMessageDeliveredMsgID:(WLMessageDeliveredMsgID)messageDeliveredMsgID
 MQTTReceiveServerStatus:(WLMQTTReceiveServerStatus)MQTTReceiveServerStatus
          monitorFlowing:(WLMonitorFlowing)monitorFlowing
                delegate:(id)delegate;




/**
 发送数据

 @param data protocol 转化的模型
 @param topic 发送地址
 @param isBack 是否需要返回地址
 */
-(void)push:(NSData *)data
      topic:(NSString *)topic
     isBack:(BOOL)isBack;


/**
 断开连接，清空数据
 */
-(void)close;

/** 解除代理 */
-(void)unRegisterDelegate;
/** 绑定代理 */
-(void)bindingDelegate:(id)obj;
@end
