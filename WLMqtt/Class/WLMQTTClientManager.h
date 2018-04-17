//
//  MQTTClientManager.m
//  mqtt
//
//  Created by 王亮 on 2018/4/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLMQTTStatus.h"

/**
 服务器回掉
 
 @param topic 回掉表示
 @param dic 回掉内容1 字典格式
 @param jsonStr 回掉内容2 字符串
 */
typedef void(^messageTopicBlock)(NSString *topic,NSDictionary *dic,NSString *jsonStr);

/**
 链接状态回掉
 
 @param status 链接状态
 */
typedef void(^MQTTReceiveServerStatus)(WLMQTTStatus *status);



@protocol WLMQTTClientManagerDelegate <NSObject>

@optional

/**
 连接状态返回
 
 @param status 错误码和错误info
 */
-(void)didMQTTReceiveServerStatus:(WLMQTTStatus *)status;

/**
 服务器推送消息返回
 
 @param topic 消息主题
 @param dic 消息内容，JSON转字典
 */
-(void)messageTopic:(NSString *)topic data:(NSDictionary *)dic jsonStr:(NSString *)jsonStr;


@end



@interface WLMQTTClientManager : NSObject

/**
 单例
 
 @return self
 */
+(WLMQTTClientManager *)shareInstance;

/**
 mqtt链接方法
 
 @param clientID 唯一标示
 @param delegate 代理
 */
-(void)loginWithClientID:(NSString *)clientID
                delegate:(id)delegate;

/**
 mqtt链接方法
 
 @param clientID 唯一标示
 @param messageTopicBlock 收到消息回掉
 @param MQTTReceiveServerStatus 链接状态回掉
 */
-(void)loginWithClientID:(NSString *)clientID
       messageTopicBlock:(messageTopicBlock)messageTopicBlock
 MQTTReceiveServerStatus:(MQTTReceiveServerStatus)MQTTReceiveServerStatus;

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
       messageTopicBlock:(messageTopicBlock)messageTopicBlock
 MQTTReceiveServerStatus:(MQTTReceiveServerStatus)MQTTReceiveServerStatus
                delegate:(id)delegate;


/**
 信息获取回掉
 */
@property(nonatomic,copy) messageTopicBlock messageTopicBlock;

/**
 连接状态回掉
 */
@property(nonatomic,copy) MQTTReceiveServerStatus MQTTReceiveServerStatus;


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

/**
 解除代理
 
 @param obj 需要接触代理的对象
 */
-(void)unRegisterDelegate:(id)obj;
@end
