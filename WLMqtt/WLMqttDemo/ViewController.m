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
#import <YYModel.h>
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
    [[WLMQTTClientManager shareInstance] loginWithClientID:@"123" delegate:self];
}

- (IBAction)click_push_button:(id)sender {
//    GamemsgRoot    
    MsgCommon *person = [[MsgCommon alloc] init];
//    person.userInfo.id_p = @"1";
//    person.userInfo.nickname = @"2";
//    person.userInfo.headimgurl = @"3";
////    person.userInfo.sex = @"4";
//    Login *login = [[Login alloc]init];
    
    person.login.token = @"123";
    person.login.loginType = 1;
    person.login.roomId = @"29";
//    [person data]
    
    MsgCommon *persons = [[MsgCommon alloc]initWithData:[person data] error:nil];
    NSLog(@"%@",persons.login.token);
    [[WLMQTTClientManager shareInstance] push:[person data] topic:@"User/HD_Login" isBack:YES];
}
/**
 连接状态返回
 
 @param status 错误码和错误info
 */
-(void)WLDidMQTTReceiveServerStatus:(WLMQTTStatus *)status{
    
}

/**
 服务器推送消息返回
 
 @param topic 消息主题
 */
-(void)WLMessageTopic:(NSString *)topic
                 data:(NSData *)data{
    MsgCommon *person = [[MsgCommon alloc]initWithData:data error:nil];

    
}

/**
 向服务器推送消息回馈 区别于（WLMessageTopicBlock）属于自己消息的回馈
 
 @param topic 回掉表示
 */
-(void)WLMessageSelfTopic:(NSString *)topic
                     data:(NSData *)data{
    
//    GPBMessage *message = [GPBMessage parseFromData:data error:nil];
    
    MsgCommon *person = [[MsgCommon alloc]initWithData:data error:nil];
    NSLog(@"%@",person.msg);
    NSLog(@"%d",person.code);

//    person = data.yy_modelToJSONObject;

}

/**
 用于监视传输和接收的消息的完成情况
 
 @param flowingIn 传入
 @param flowingOut 穿出
 */
- (void)WLMonitorFlowingIn:(NSUInteger)flowingIn
                flowingOut:(NSUInteger)flowingOut{
    
}



/** 向服务器推送消息通知 */
- (void)WLMessageDeliveredMsgID:(UInt16)msgID
                          topic:(NSString *)topic
                           data:(NSData *)data
                     retainFlag:(BOOL)retainFlag{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
