//
//  showVerificationCodeAlertView.m
//  BIPortableHD_BJ
//
//  Created by Xu Qing Di on 16/5/26.
//  Copyright © 2016年 Xu Qing Di. All rights reserved.
//


#import "showVerificationCodeAlertView.h"
@interface showVerificationCodeAlertView ()

@property(nonatomic,strong)UIButton* confimBtn;
@property(nonatomic,strong)UIButton* getVerificationCodeAgainBtn;

@end
@implementation showVerificationCodeAlertView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 6.0f;
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"请输入短信验证码";
    titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:titleLabel];
//    验证码输入框
    if (!self.showVerificationCodeTF) {
        self.showVerificationCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(titleLabel.frame) + 4, self.frame.size.width-96, 30)];
    }
    
    
    self.showVerificationCodeTF.borderStyle = UITextBorderStyleRoundedRect;
    self.showVerificationCodeTF.layer.borderWidth = 1;
    self.showVerificationCodeTF.layer.borderColor = [UIColor orangeColor].CGColor;
    self.showVerificationCodeTF.layer.cornerRadius = 5;
    self.showVerificationCodeTF.placeholder = @"请输入验证码";
//    self.showVerificationCodeTF.secureTextEntry = YES;
    [self addSubview:self.showVerificationCodeTF];
    
//    重新发送验证码的按钮
    if(!self.getVerificationCodeAgainBtn){
        self.getVerificationCodeAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.showVerificationCodeTF.frame.origin.x+self.showVerificationCodeTF.frame.size.width+2, self.showVerificationCodeTF.frame.origin.y, 80-4, 30)];
    }
    [self.getVerificationCodeAgainBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    [self.getVerificationCodeAgainBtn.layer setBorderWidth:1.0f];
    [self.getVerificationCodeAgainBtn.layer setCornerRadius:5.0f];
     self.getVerificationCodeAgainBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.getVerificationCodeAgainBtn addTarget:self action:@selector(getVerificationCodeAgainBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.getVerificationCodeAgainBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.getVerificationCodeAgainBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.getVerificationCodeAgainBtn];
    
//    取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(16, CGRectGetMaxY(self.showVerificationCodeTF.frame) + 4, self.frame.size.width/2, 30);
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
//    确定按钮
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(self.showVerificationCodeTF.frame) + 4, self.frame.size.width/2, 30);
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:confirmBtn];

}
#pragma mark 按钮点击事件
-(void)getVerificationCodeAgainBtnClicked:(UIButton*)btn{
    [self startTimeWithBtn:btn];
    [self.delegate GetVerificationCode];
}
-(void)cancelBtnClick:(UIButton*)btn{
    exit(0);
}
-(void)confirmBtnClick:(UIButton*)btn{
    [self.delegate sendVerificationCode];
}
#pragma mark - 开始计时器
-(void)startTimeWithBtn:(UIButton*)_getCodeBtn{
    
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [_getCodeBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
                _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                _getCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60 ;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_getCodeBtn setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                [_getCodeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [_getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
                [UIView commitAnimations];
                _getCodeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
@end
