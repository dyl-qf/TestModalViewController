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


//! 中间内容区宽度。默认为0，内部通过contentView的约束计算，如果手动指定将忽略约束计算。
@property (nonatomic, assign) CGFloat contentWidth;

//! maskView是否可以响应dismiss手势
@property (nonatomic, assign) BOOL shouldRespondsMaskViewTouch;

@end

NS_ASSUME_NONNULL_END
