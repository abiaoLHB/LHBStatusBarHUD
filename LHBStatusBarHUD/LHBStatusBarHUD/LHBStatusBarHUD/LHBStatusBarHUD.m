//
//  LHBStatusBarHUD.m
//  LHBStatusBarHUD
//
//  Created by LHB on 16/6/26.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBStatusBarHUD.h"

static CGFloat const LHBMessageDuration = 2.0;
static CGFloat const LHBAnimationDuration = 0.25;
/**
 *  iOS版本分法
    例如 1.1.1
        大版本号.功能版本号.bug版本号
    增加规则：比如只改了bug，bug版本号一直加
            比如新增了功能，功能版本号增加，bug版本号清零。发现bug，bug在增加
            版本大更新后，大版本号增加，功能版本和bug版本清零
 
 框架中使用的资源不要放倒Assets里面，要起一个名字和框架名字一样的文件夹，来放和框架相关的资源。为了防止框架资源，例如图片名字和项目本身的图片文字冲突，要把框架中的资源打成包，就是在给资源文件夹价格.bundle后缀，框架中访问资源的时候，加上包全名/资源名.以确保框架内访问的资源绝对是框架内的
 
 随着框架文件的增多，最好又个主头文件
 
 
 让框架支持cocoapods
 1、框架必须在github上面
    a、把框架传到github：新建一个项目（仓库），仓库名字最好和框架名字一样。写一下描述：例如一个比较好用的状态栏指示器
    b、公开，oc、阿帕奇（或者mit，就是别人可以拿到你的代码乱改）
    c、clone下来github的空仓库，把框架拖到仓库中，commit、push
 
 2、编辑README.md信息
    a、可以在本地编辑。保存＋提交＋push
    b、也可以在线编辑
 
 3、将框架传到cocoaPods服务器
 */

@implementation LHBStatusBarHUD
/**
 *  全局的window
 *  @param msg 保命
 *  不会叠加，就这一个变量，重新赋值后，上一个就销毁了
 */
static UIWindow *window_;
static NSTimer *timer_;

+ (void)LHB_showWindow
{
    CGFloat windowH = 20;
    CGRect frame = CGRectMake(0, -windowH, [[UIScreen mainScreen] bounds].size.width, windowH);
    
    //显示窗口
    window_.hidden = YES;//消除window残留阴影
    window_ = [[UIWindow alloc] init];
    window_.frame = frame;
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    
    //执行动画
    frame.origin.y = 0;
    [UIView animateWithDuration:LHBAnimationDuration animations:^{
        window_.frame = frame;
    }];
}

/**
 *  保证通用性，传image。比如画的图，下载的图，传图片名是没法用的
 */
+ (void)LHB_showMessage:(NSString *)msg image:(UIImage *)image
{
    //先停止定时器
    [timer_ invalidate];
    timer_ = nil;
    
    [self LHB_showWindow];
    //添加按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:msg forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    if (image) {
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [btn setTitle:msg forState:UIControlStateNormal];
    }
    btn.frame = window_.bounds;
    [window_ addSubview:btn];
    
    //定时器(重新给这个定时器，上一个定时器也会销毁，所以timer_ = nil 不写也行)
    timer_ = [NSTimer scheduledTimerWithTimeInterval:LHBMessageDuration target:self selector:@selector(LHB_hidden) userInfo:nil repeats:nil];
}

+ (void)LHB_showSuccess:(NSString *)msg
{
    [self LHB_showMessage:msg image:[UIImage imageNamed:@"LHBStatusBarHUD.bundle/yesx32px"]];
}

+ (void)LHB_showError:(NSString *)msg
{
    [self LHB_showMessage:msg image:[UIImage imageNamed:@"LHBStatusBarHUD.bundle/errorx32px"]];
}

+ (void)LHB_showNormal:(NSString *)msg
{
    [self LHB_showMessage:msg image:nil];
    
}

+ (void)LHB_showLoading:(NSString *)msg
{
//    [self showMessage:msg image:[UIImage imageNamed:@"loading"]];
    //停止定时器
    [timer_ invalidate];
    timer_ = nil;
    
    //显示窗口
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 20);
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.frame = window_.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    [window_ addSubview:label];
    
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    //文字宽度
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}].width;
    CGFloat centerX = (window_.frame.size.width - msgW)*0.5-20;
    CGFloat centerY = window_.frame.size.height *0.5;
    loadingView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadingView];
}

+ (void)LHB_hidden
{
    [UIView animateWithDuration:LHBAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = -frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
    }];
}





















@end
