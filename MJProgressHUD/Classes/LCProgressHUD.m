//
//  LCProgressHUD.m
//  MBProgressHUDTest
//
//  Created by Zgmanhui on 2017/7/2.
//  Copyright © 2017年 Zgmanhui. All rights reserved.
//

#import "LCProgressHUD.h"

#define HUD_BACKVIEW_CORNERRADIUS 5

#define HUD_TITLE_FONT [UIFont systemFontOfSize:16]

#define HUD_TIME_INTERVAL 2

#define LCHUD_BACKGROUND_COLOR	[UIColor colorWithRed:0.37 green:0.37 blue:0.37 alpha:0.7]

#define HUD_TITLE_COLOR [UIColor whiteColor]

@interface LCProgressHUD ()

@property (nonatomic, strong) UIView *superView;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, weak) NSTimer *minShowTimer;

@end

@implementation LCProgressHUD

+ (LCProgressHUD *)shared {
    static dispatch_once_t once = 0;
    static LCProgressHUD *progressHUD;
    dispatch_once(&once, ^{
        progressHUD = [[LCProgressHUD alloc] init];
    });
    return progressHUD;
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

#pragma mark -- 活动展示器加文本
+ (void)showLoading:(NSString *)content {
    [[LCProgressHUD shared] showLoading:content];
}

+ (void)showLoadingWithView:(UIView *)view content:(NSString *)content {
    [[LCProgressHUD shared] showLoadingWithView:view content:content];
}

- (void)showLoading:(NSString *)content {
    [self showLoadingWithView:[[UIApplication sharedApplication] keyWindow] content:content];
}

- (void)showLoadingWithView:(UIView *)view content:(NSString *)content {
    _superView = view;
    if (![content isKindOfClass:[NSString class]] || content.length == 0) {
        [self showLoadingWithView:view];
        return;
    }
    [self.backView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGRect rect = [self getRectWithContent:content];
    CGFloat width = rect.size.width > 57 ? rect.size.width + 20 : 77;
    CGFloat height = rect.size.height + 20 + 47;
    self.backView.bounds = CGRectMake(0, 0, width, height);
    [_backView setBackgroundColor:LCHUD_BACKGROUND_COLOR];
    self.backView.center = CGPointMake(CGRectGetWidth(view.bounds) / 2, CGRectGetHeight(view.bounds) / 2);
    self.spinner.center = CGPointMake(width / 2, 28.5);
    self.titleLabel.bounds = CGRectMake(0, 0, width, 20);
    self.titleLabel.center = CGPointMake(width / 2, height - 22);
    _titleLabel.numberOfLines = 1;
    _titleLabel.text = content;
    [_backView addSubview:self.spinner];
    [_backView addSubview:self.titleLabel];
    [self.spinner startAnimating];
    [self show];
}


#pragma mark -- 活动展示器
+ (void)showLoading {
    [[LCProgressHUD shared] showLoading];
}

+ (void)showLoadingWithView:(UIView *)view {
    [LCProgressHUD showLoadingWithView:view];
}

- (void)showLoading {
    [self showLoadingWithView:[[UIApplication sharedApplication] keyWindow]];
}

- (void)showLoadingWithView:(UIView *)view {
    _superView = view;
    [self.backView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGSize size = CGSizeMake(77, 77);
    self.backView.bounds = CGRectMake(0, 0, size.width, size.height);
    [_backView setBackgroundColor:LCHUD_BACKGROUND_COLOR];
    self.backView.center = CGPointMake(CGRectGetWidth(view.bounds) / 2, CGRectGetHeight(view.bounds) / 2);
    self.spinner.center = CGPointMake(size.width / 2, size.height / 2);
    [_backView addSubview:self.spinner];
    [self.spinner startAnimating];
    [self show];
}



#pragma mark -- 文本展示
+ (void)show:(NSString *)content {
    [[LCProgressHUD shared] show:content];
}

+ (void)showWithView:(UIView *)view content:(NSString *)content {
    [[LCProgressHUD shared] showWithView:view content:content];
}

- (void)show:(NSString *)content {
    [self showWithView:[[UIApplication sharedApplication] keyWindow] content:content];
}

- (void)showWithView:(UIView *)view content:(NSString *)content {
    if (![content isKindOfClass:[NSString class]] || content.length == 0) {
        return;
    }
    _superView = view;
    [self.backView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.backView addSubview:self.titleLabel];
    _titleLabel.numberOfLines = 0;
    CGRect rect = [self getRectWithContent:content];
    CGSize size = CGSizeMake(rect.size.width + 20, rect.size.height + 20);
    self.backView.bounds = CGRectMake(0, 0, size.width, size.height);
    [_backView setBackgroundColor:LCHUD_BACKGROUND_COLOR];
    self.backView.center = CGPointMake(CGRectGetWidth(view.bounds) / 2, CGRectGetHeight(view.bounds) / 2);
    self.titleLabel.frame = CGRectMake(10, 10, rect.size.width, rect.size.height);
    self.titleLabel.text = content;
    [_spinner removeFromSuperview];
    _spinner = nil;
    [self initializeTime];
    [self show];
}

- (CGRect)getRectWithContent:(NSString *)content {
    UIFont *font = HUD_TITLE_FONT;
    NSDictionary * dict = [NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect = [content boundingRectWithSize:CGSizeMake(250 ,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect;
}


#pragma mark -- 公共方法
- (void)show {
    if (_isShow) {
        return;
    }
    [_superView addSubview:self];
    _isShow = YES;
    _backView.alpha = 0;
    _backView.transform = CGAffineTransformScale(_backView.transform, 1.4, 1.4);
    __weak typeof(self) wself = self;
    NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;
    [UIView animateWithDuration:0.15 delay:0 options:options animations:^{
        wself.backView.transform = CGAffineTransformScale(wself.backView.transform, 1/1.4, 1/1.4);
        wself.backView.alpha = 1;
    } completion:nil];
}

+ (void)hide {
    [[LCProgressHUD shared] hide];
}

- (void)hide {
    [_minShowTimer invalidate];
    _minShowTimer = nil;
    _isShow = NO;
    if (_spinner) {
        [_spinner stopAnimating];
    }
    __weak typeof(self) wself = self;
    NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;
    [UIView animateWithDuration:0.15 delay:0 options:options animations:^{
        wself.backView.alpha = 0;
    } completion:^(BOOL finished) {
        wself.spinner = nil;
        [wself removeFromSuperview];
    }];
}

- (void)initializeTime {
    if (!_minShowTimer) {
        _minShowTimer = [NSTimer scheduledTimerWithTimeInterval:HUD_TIME_INTERVAL target:self selector:@selector(hide) userInfo:nil repeats:YES];
    }else {
        [_minShowTimer setFireDate:[NSDate distantFuture]];
        _minShowTimer = nil;
        _minShowTimer = [NSTimer scheduledTimerWithTimeInterval:HUD_TIME_INTERVAL target:self selector:@selector(hide) userInfo:nil repeats:YES];
    }
}

#pragma mark -- getter
- (UIActivityIndicatorView *)spinner {
    if (!_spinner) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _spinner.color = [UIColor whiteColor];
    }
    return _spinner;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = HUD_TITLE_FONT;
        _titleLabel.textColor = HUD_TITLE_COLOR;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.cornerRadius = HUD_BACKVIEW_CORNERRADIUS;
        [self addSubview:_backView];
    }
    return _backView;
}


@end
