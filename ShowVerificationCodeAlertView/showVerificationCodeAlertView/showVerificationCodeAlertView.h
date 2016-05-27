//
//  showVerificationCodeAlertView.h
//  BIPortableHD_BJ
//
//  Created by Xu Qing Di on 16/5/26.
//  Copyright © 2016年 Xu Qing Di. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowVerificationDelegate <NSObject>

-(void)GetVerificationCode;//重新请求验证码
-(void)sendVerificationCode;//发送验证码到后台

@end


@interface showVerificationCodeAlertView : UIView
@property(nonatomic,strong)UITextField* showVerificationCodeTF;
@property(nonatomic,weak)id<ShowVerificationDelegate> delegate;
@end
