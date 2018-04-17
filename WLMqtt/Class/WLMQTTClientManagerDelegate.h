#import "WLMQTTStatus.h"

/**
 服务器回掉
 
 @param topic 回掉表示
 @param dic 回掉内容1 字典格式
 @param jsonStr 回掉内容2 字符串
 */
typedef void(^WLMessageTopicBlock)(NSString *topic,NSDictionary *dic,NSString *jsonStr);

/**
 链接状态回掉
 
 @param status 链接状态
 */
typedef void(^WLMQTTReceiveServerStatus)(WLMQTTStatus *status);

/**
 用于监视传输和接收的消息的完成情况
 
 @param flowingIn 传入
 @param flowingOut 穿出
 */
typedef void(^WLMonitorFlowing)(NSInteger flowingIn,NSInteger flowingOut);

/**
 用于监视传输和接收的消息的完成情况

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
 @param dic 消息内容，JSON转字典
 */
-(void)WLMessageTopic:(NSString *)topic
                 data:(NSDictionary *)dic
              jsonStr:(NSString *)jsonStr;

/**
 用于监视传输和接收的消息的完成情况
 
 @param flowingIn 传入
 @param flowingOut 穿出
 */
- (void)WLMonitorFlowingIn:(NSUInteger)flowingIn
                flowingOut:(NSUInteger)flowingOut;



/**
 当发布的消息实际传递时被调用

 @param msgID <#msgID description#>
 @param topic <#topic description#>
 @param data <#data description#>
 @param retainFlag <#retainFlag description#>
 */
- (void)WLMessageDeliveredMsgID:(UInt16)msgID
                          topic:(NSString *)topic
                           data:(NSData *)data
                     retainFlag:(BOOL)retainFlag;
@end

