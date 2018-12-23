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

/*
 * 添加一个view在黑色遮罩内显示
 */
- (void)addContentView:(UIView *)view;

- (void)dismiss;
- (void)dismissWithAnimated:(BOOL)animated;

//! 中间内容区宽度。默认为0，内部通过contentView的约束计算宽度，如果手动指定宽度将忽略约束计算。
@property (nonatomic, assign) CGFloat contentWidth;

//! actionSheet整体内容距离屏幕底部距离，默认为0
@property (nonatomic, assign) CGFloat sheetContentMarginBottom;

//! maskView是否可以响应dismiss手势
@property (nonatomic, assign) BOOL shouldRespondsMaskViewTouch;

@end

NS_ASSUME_NONNULL_END
