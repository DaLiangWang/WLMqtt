//
//  MQTTStatus.h
//  mqtt
//
//  Created by 王亮 on 2018/4/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    WLMQTTStatusCodeConnected,                   //链接成功
    WLMQTTStatusCodeConnectedRefused,            //拒绝连接
    WLMQTTStatusCodeConnectedClosed,             //链接关闭
    WLMQTTStatusCodeConnectedError,              //链接错误
    WLMQTTStatusCodeProtocolError,               //protocoll 错误
    WLMQTTStatusCodeConnectedClosedByBroker,     //连接代理关闭
    WLMQTTStatusCodeReconnect,                   //断线重连中
    WLMQTTStatusCodeReconnectFailure,            //断线重连失败
//    WLMQTTStatusCodeReconnectSure,               //断线重连成功
    WLMQTTStatusCodeConnectedReconnect,          //连接失败重连中
    WLMQTTStatusCodeConnectedReconnectFailure,   //连接失败重连失败
//    WLMQTTStatusCodeConnectedReconnectSure,      //连接失败重连成功
} WLMQTTStatusCode;

@interface WLMQTTStatus : NSObject
//状态
@property(nonatomic,assign) WLMQTTStatusCode WLMQTTStatusCode;
//状态信息
@property(nonatomic,copy)  NSString *statusInfo;
@end
