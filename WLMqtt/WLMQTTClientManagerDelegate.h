//
//  MQTTClientManagerDelegate.h
//  mqtt
//
//  Created by 王亮 on 2018/4/13.
//  Copyright © 2018年 王亮. All rights reserved.
//



/**
 MQTTClientManager委托事件
 */
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
