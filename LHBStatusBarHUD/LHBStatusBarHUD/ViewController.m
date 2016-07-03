//
//  ViewController.m
//  LHBStatusBarHUD
//
//  Created by LHB on 16/6/26.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "ViewController.h"
#import "LHBStatusBarHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)testShowXXX
{
    NSLog(@"测试提交代码到开源库");
};


- (IBAction)success:(id)sender
{
    [LHBStatusBarHUD LHB_showSuccess:@"加载成功"];
}
- (IBAction)error:(id)sender
{
    [LHBStatusBarHUD LHB_showError:@"加载失败"];
}
- (IBAction)loading:(id)sender
{
    [LHBStatusBarHUD LHB_showLoading:@"正在加载"];
}
- (IBAction)hidden:(id)sender
{
    [LHBStatusBarHUD LHB_hidden];
}
- (IBAction)normal:(id)sender {
    [LHBStatusBarHUD LHB_showNormal:@"普通信息"];
}
@end
