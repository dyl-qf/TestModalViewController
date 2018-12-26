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

//! 中间内容区宽度。默认为0，内部通过contentView的约束计算宽度，如果手动指定宽度将忽略约束计算。
@property (nonatomic, assign) CGFloat contentWidth;

//! 中间内容区最大高度。默认为ScreenHeight-24-24,（跟系统一致）。
//! 注意：内部实际计算时，如果是sheet还会多减去sheetContentMarginBottom的高度。比如如果指定contentMaximumHeight为屏幕的高度，则弹出sheet时还要减去sheetContentMarginBottom才能使内容完全显示,（跟系统一致）。所以外部指定时，不用考虑sheetContentMarginBottom的高度。
@property (nonatomic, assign) CGFloat contentMaximumHeight;

//! actionSheet整体内容距离屏幕底部距离，默认为0
@property (nonatomic, assign) CGFloat sheetContentMarginBottom;

//! maskView是否可以响应dismiss手势。默认alert不响应，sheet响应
@property (nonatomic, assign) BOOL shouldRespondsMaskViewTouch;


#pragma mark - 动画时间
// 弹出时间
@property (nonatomic, assign) CGFloat presentDelayTimeInterval;
@property (nonatomic, assign) CGFloat presentTimeInterval;
// 消失时间
@property (nonatomic, assign) CGFloat dismissDelayTimeInterval;
@property (nonatomic, assign) CGFloat dismissTimeInterval;

@end

NS_ASSUME_NONNULL_END
