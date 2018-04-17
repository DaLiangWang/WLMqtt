//
//  MQTTStatus.h
//  mqtt
//
//  Created by 王亮 on 2018/4/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQTTClient.h"
@interface WLMQTTStatus : NSObject
//状态
@property(nonatomic,assign) MQTTSessionEvent statusCode;
//状态信息
@property(nonatomic,copy)  NSString *statusInfo;
@end
