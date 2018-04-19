//
//  MQTTStatus.m
//  mqtt
//
//  Created by 王亮 on 2018/4/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "WLMQTTStatus.h"

@implementation WLMQTTStatus
/*
 WLMQTTStatusCodeConnected,                   //链接成功
 WLMQTTStatusCodeConnectedRefused,            //拒绝连接
 WLMQTTStatusCodeConnectedClosed,             //链接关闭
 WLMQTTStatusCodeConnectedError,              //链接错误
 WLMQTTStatusCodeProtocolError,               //protocoll 错误
 WLMQTTStatusCodeConnectedClosedByBroker,     //连接代理关闭
 WLMQTTStatusCodeReconnect,                   //断线重连中
 WLMQTTStatusCodeReconnectSure,               //断线重连成功
 WLMQTTStatusCodeConnectedReconnect,          //连接失败重连中
 WLMQTTStatusCodeConnectedReconnectSure,      //连接失败重连成功
 */
-(NSString *)statusInfo{
    switch (self.WLMQTTStatusCode) {
            case WLMQTTStatusCodeConnected:
            return @"链接成功";
            break;
            case WLMQTTStatusCodeConnectedRefused:
            return @"拒绝连接";
            break;
            case WLMQTTStatusCodeConnectedClosed:
            return @"链接关闭";
            break;
            case WLMQTTStatusCodeConnectedError:
            return @"链接错误";
            break;
            case WLMQTTStatusCodeProtocolError:
            return @"protocoll 错误";
            break;
            case WLMQTTStatusCodeConnectedClosedByBroker:
            return @"连接代理关闭";
            break;
            case WLMQTTStatusCodeReconnect:
            return @"断线重连中";
            break;
//            case WLMQTTStatusCodeReconnectSure:
//            return @"断线重连成功";
//            break;
            case WLMQTTStatusCodeConnectedReconnect:
            return @"连接失败重连中";
            break;
//            case WLMQTTStatusCodeConnectedReconnectSure:
//            return @"连接失败重连成功";
//            break;
            case WLMQTTStatusCodeConnectedReconnectFailure:
            return @"连接失败重连失败";
            break;
            case WLMQTTStatusCodeReconnectFailure:
            return @"断线重连失败";
            break;
        default:
            return @"未知错误";
            break;
    }
}
@end
