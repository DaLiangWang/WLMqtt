#import "WLMQTTStatus.h"

/**
 链接状态回掉
 
 @param status 链接状态
 */
typedef void(^WLMQTTReceiveServerStatus)(WLMQTTStatus *status);

/**
 服务器推送消息
 
 @param topic 回掉表示
 @param dic 回掉内容1 字典格式
 */
typedef void(^WLMessageTopicBlock)(NSString *topic,NSData *data);

/**
 向服务器推送消息回馈 区别于（WLMessageTopicBlock）属于自己消息的回馈
 
 @param topic 回掉表示
 @param dic 回掉内容1 字典格式
 */
typedef void(^WLMessageSelfTopicBlock)(NSString *topic,NSData *data);


/**
 用于监视传输和接收的消息的完成情况
 
 @param flowingIn 传入
 @param flowingOut 穿出
 */
typedef void(^WLMonitorFlowing)(NSInteger flowingIn,NSInteger flowingOut);

/**
 向服务器推送消息通知
 */
typedef void(^WLMessageDeliveredMsgID)(UInt16 msgID,NSString *topic,NSData *data,BOOL retainFlag);




@protocol WLMQTTClientManagerDelegate <NSObject>

@optional

/**
 连接状态返回
 
 @param status 错误码和错误info
 */
-(void)WLDidMQTTReceiveServerStatus:(WLMQTTStatus *)status;

/**
 服务器推送消息返回
 
 @param topic 消息主题
 */
-(void)WLMessageTopic:(NSString *)topic
                 data:(NSData *)data;

/**
 向服务器推送消息回馈 区别于（WLMessageTopicBlock）属于自己消息的回馈
 
 @param topic 回掉表示
 */
-(void)WLMessageSelfTopic:(NSString *)topic
                         data:(NSData *)data;

/**
 用于监视传输和接收的消息的完成情况
 
 @param flowingIn 传入
 @param flowingOut 穿出
 */
- (void)WLMonitorFlowingIn:(NSUInteger)flowingIn
                flowingOut:(NSUInteger)flowingOut;



/** 向服务器推送消息通知 */
- (void)WLMessageDeliveredMsgID:(UInt16)msgID
                          topic:(NSString *)topic
                           data:(NSData *)data
                     retainFlag:(BOOL)retainFlag;
@end

