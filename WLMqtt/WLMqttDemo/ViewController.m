//
//  ViewController.m
//  mqtt
//
//  Created by 王亮 on 2018/4/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "ViewController.h"

#import "WLMQTTClientManager.h"
#import "Gamemsg.pbobjc.h"
#import <GPBMessage.h>
@interface ViewController ()<WLMQTTClientManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *click;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)click_button:(id)sender {
    [[WLMQTTClientManager shareInstance] setIp:@"172.16.3.225" Port:3563];
    [[WLMQTTClientManager shareInstance] loginWithClientID:@"123" messageTopicBlock:^(NSString *topic, NSDictionary *dic, NSString *jsonStr) {
        NSLog(@"dic:%@------json:%@",dic,jsonStr);
    } WLMessageDeliveredMsgID:^(UInt16 msgID, NSString *topic, NSData *data, BOOL retainFlag) {
        
    } MQTTReceiveServerStatus:^(WLMQTTStatus *status) {
        NSLog(@"%@",status.statusInfo);
    } monitorFlowing:^(NSInteger flowingIn, NSInteger flowingOut) {
        
    }];
}

- (IBAction)click_push_button:(id)sender {
//    GamemsgRoot    
    MsgCommon *person = [[MsgCommon alloc] init];
    person.userInfo.id_p = @"1";
    person.userInfo.nickname = @"2";
    person.userInfo.headimgurl = @"3";
    person.userInfo.sex = @"4";

    person.login.token = @"123";
    person.login.name = @"1";
    
    [[WLMQTTClientManager shareInstance] push:[person data] topic:@"Login/HD_Login" isBack:YES];
}



/**
 连接状态返回
 
 @param status 错误码和错误info
 */
-(void)didMQTTReceiveServerStatus:(WLMQTTStatus *)status{
    NSLog(@"连接状态返回: %ld------%@",(long)status.statusCode,status.statusInfo);
}

/**
 服务器推送消息返回
 
 @param topic 消息主题
 @param dic 消息内容，JSON转字典
 */
-(void)messageTopic:(NSString *)topic data:(NSDictionary *)dic jsonStr:(NSString *)jsonStr{
    NSLog(@"服务器推送消息返回:%@----%@----%@",topic,dic,jsonStr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
