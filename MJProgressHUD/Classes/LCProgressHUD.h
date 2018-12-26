//
//  LCProgressHUD.h
//  MBProgressHUDTest
//
//  Created by Zgmanhui on 2017/7/2.
//  Copyright © 2017年 Zgmanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCProgressHUD : UIView

+ (LCProgressHUD *)shared;

#pragma mark -- 活动展示器加文本
+ (void)showLoading:(NSString *)content;

+ (void)showLoadingWithView:(UIView *)view content:(NSString *)content;

- (void)showLoading:(NSString *)content;

- (void)showLoadingWithView:(UIView *)view content:(NSString *)content;


+ (void)showLoading;

+ (void)showLoadingWithView:(UIView *)view;

- (void)showLoadingWithView:(UIView *)view;

- (void)showLoading;


+ (void)show:(NSString *)content;

+ (void)showWithView:(UIView *)view content:(NSString *)content;

- (void)show:(NSString *)content;

- (void)showWithView:(UIView *)view content:(NSString *)content;


+ (void)hide;

- (void)hide;


/** 背景视图 */
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, retain) UIActivityIndicatorView *spinner;

@end
