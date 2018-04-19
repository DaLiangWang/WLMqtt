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

/** 服务器推送回掉信息获取回掉 */
@property(nonatomic,copy) WLMessageTopicBlock messageTopicBlock;
/** 向服务器推送消息回馈 区别于（WLMessageTopicBlock）属于自己消息的回馈 */
@property(nonatomic,copy) WLMessageSelfTopicBlock messageSelfTopicBlock;
/** 连接状态回掉 */
@property(nonatomic,copy) WLMQTTReceiveServerStatus MQTTReceiveServerStatus;
/** 本机push传输情况回掉 */
@property(nonatomic,copy) WLMonitorFlowing monitorFlowing;
/** 向服务器推送消息通知 */
@property(nonatomic,copy) WLMessageDeliveredMsgID messageDeliveredMsgID;

/** 重连间隔 */
@property(nonatomic,strong) NSString *reconnectTime;
/** 重连次数 */
@property(nonatomic,assign) NSInteger reconnectNum;

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
-(void)loginWithClientID:(NSString *)clientID delegate:(id)delegate;


/**
 MQTT链接
 
 @param ip 服务器ip
 @param port 服务器端口
 @param userName 用户名
 @param password 密码
 @param delegate 代理
 */
-(void)loginWithClientID:(NSString *)clientID
                      Ip:(NSString *)ip
                    port:(UInt16)port
                userName:(NSString *)userName
                password:(NSString *)password
                delegate:(id)delegate;




/** 发送数据 定制需求 内部管理分发机制 对影代理回掉 */
-(void)push:(NSData *)data
      topic:(NSString *)topic
     isBack:(BOOL)isBack;
/** 发送消息 自己管理 分发机制 */
-(void)push:(NSData *)data
      topic:(NSString *)topic;

/**
 断开连接，清空数据
 */
-(void)close;

/** 解除代理 */
-(void)unRegisterDelegate;
/** 绑定代理 */
-(void)bindingDelegate:(id)obj;
@end
