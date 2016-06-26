//
//  LHBStatusBarHUD.h
//  LHBStatusBarHUD
//
//  Created by LHB on 16/6/26.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LHBStatusBarHUD : NSObject

+ (void)LHB_showMessage:(NSString *)msg image:(UIImage *)image;

+ (void)LHB_showSuccess:(NSString *)msg;

+ (void)LHB_showError:(NSString *)msg;

+ (void)LHB_showLoading:(NSString *)msg;

+ (void)LHB_showNormal:(NSString *)msg;

+ (void)LHB_hidden;

@end
