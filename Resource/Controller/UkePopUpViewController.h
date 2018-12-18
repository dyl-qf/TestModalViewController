//
//  UkePopUpViewController.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UkePopUpViewController : UIViewController

@property (nonatomic, assign) UIAlertControllerStyle preferredStyle;

+ (instancetype)alertControllerWithContentView:(UIView *)view
                             preferredStyle:(UIAlertControllerStyle)preferredStyle;

- (void)addContentView:(UIView *)view;

- (void)dismiss;
- (void)dismissWithAnimated:(BOOL)animated;


//! 中间内容区宽度，默认270，跟系统保持一致
@property (nonatomic, assign) CGFloat contentWidth;

@end

NS_ASSUME_NONNULL_END
