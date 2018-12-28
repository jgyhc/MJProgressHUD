//
//  MJViewController.m
//  MJProgressHUD
//
//  Created by jgyhc on 12/26/2018.
//  Copyright (c) 2018 jgyhc. All rights reserved.
//

#import "MJViewController.h"
#import <MJProgressHUD/LCProgressHUD.h>

@interface MJViewController ()

@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showText:(id)sender {
    [LCProgressHUD show:@"天青色等烟雨，而我在等你，天青色等烟雨，而我在等你，天青色等烟雨，而我在等你"];
}

- (IBAction)viewShowText:(id)sender {
    LCProgressHUD * hud = [[LCProgressHUD alloc] init];
    [hud showWithView:self.view content:@"天青色等烟雨"];
}

- (IBAction)ShowActivity:(id)sender {
    [LCProgressHUD showLoading];
}

- (IBAction)viewShowActivity:(id)sender {
    LCProgressHUD * hud = [[LCProgressHUD alloc] init];
    [hud showLoadingWithView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide];
    });
}


- (IBAction)hide:(id)sender {
    [LCProgressHUD hide];
}

- (IBAction)showContentAndActivity:(id)sender {
    [LCProgressHUD showLoading:@"loading...loading...loading..."];
}

- (IBAction)viewShowContentAndActivity:(id)sender {
    LCProgressHUD * hud = [[LCProgressHUD alloc] init];
    [hud showLoadingWithView:self.view content:@"loading..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide];
    });
}


@end
