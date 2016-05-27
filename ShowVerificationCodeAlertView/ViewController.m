//
//  ViewController.m
//  ShowVerificationCodeAlertView
//
//  Created by Xu Qing Di on 16/5/27.
//  Copyright © 2016年 Xu Qing Di. All rights reserved.
//

#import "ViewController.h"
#import "showVerificationCodeAlertView.h"

@interface ViewController ()<ShowVerificationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    showVerificationCodeAlertView* showView =[[showVerificationCodeAlertView alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 100)];
    showView.delegate = self;
    [self.view addSubview:showView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)GetVerificationCode{//重新请求验证码
    NSLog(@"发送重新请求验证码的请求！");
    [self.view endEditing:YES];

}
-(void)sendVerificationCode{//发送验证码到后台

    NSLog(@"进行验证码验证！");
    [self.view endEditing:YES];
}

@end
