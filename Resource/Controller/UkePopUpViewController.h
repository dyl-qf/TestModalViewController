//
//  UkePopUpViewController.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_CLASS_AVAILABLE_IOS(6_0)
@interface UkePopUpViewController : UIViewController

+ (instancetype)alertControllerWithContentView:(UIView *)view
                             preferredStyle:(UIAlertControllerStyle)preferredStyle;
- (void)addContentView:(UIView *)view;

@property (nonatomic, assign) UIAlertControllerStyle preferredStyle;
@property (nonatomic, strong, readonly) UIView *contentView;

#pragma mark - Show。不建议用presentViewController:animated:completion:的方式弹出，否则无法支持多个弹框同时弹出的效果。建议后期适配。
- (void)show;
- (void)showWithAnimated:(BOOL)animated;
- (void)showWithAnimated:(BOOL)animated
                 completion:(nullable void(^)(void))completionHandler;

#pragma mark - Dismiss
- (void)dismiss;
- (void)dismissWithAnimated:(BOOL)animated;
- (void)dismissWithAnimated:(BOOL)animated
                 completion:(nullable void(^)(void))completionHandler;

@property (nonatomic, strong) void (^dismissCompletion)(void);

//! 弹出视图的唯一id，默认是一个UUID String。
//! 默认情况下，同时弹出多个弹框时，弹框之间是互斥的，后面的弹框显示时会暂时移除前一个弹框。当后面的弹框消失后，前面被移除的弹框会再次显示出来。
//! 如果弹出多个弹框时，指定他们的identifier一样，则前面的弹框会被永久性移除，不会再显示。
@property (nonatomic, strong) NSString *identifier;

//! 中间内容区宽度。默认为0，内部通过contentView的约束计算宽度，如果手动指定宽度将忽略约束计算。
@property (nonatomic, assign) CGFloat contentWidth;

//! 中间内容区最大高度。默认alert为ScreenHeight-24-24，sheet竖屏为ScreenHeight-40，横屏为ScreenHeight-8，（跟系统一致），实际高度由内部视图高度决定，当实际高度超过最大高度时，内容可以上下滚动。
//! 注意：内部实际计算时，如果是sheet还会多减去sheetContentMarginBottom的高度。比如如果指定contentMaximumHeight为屏幕的高度，则弹出sheet时还要减去sheetContentMarginBottom才能使内容完全显示,（这个计算方式跟系统一致）。所以外部指定时，不用考虑sheetContentMarginBottom的高度。
@property (nonatomic, assign) CGFloat contentMaximumHeight;

//! actionSheet整体内容距离屏幕底部距离，默认为0。注意：刘海屏会自动再加上底部安全区域高度
@property (nonatomic, assign) CGFloat sheetContentMarginBottom;

//! maskView是否可以响应dismiss手势。默认alert不响应，sheet响应
@property (nonatomic, assign) BOOL shouldRespondsMaskViewTouch;

//! 圆角值
@property (nonatomic, assign) CGFloat cornerRadius;

#pragma mark - 动画时间
//! 弹出时间
@property (nonatomic, assign) CGFloat presentDelayTimeInterval;
@property (nonatomic, assign) CGFloat presentTimeInterval;
//! 消失时间
@property (nonatomic, assign) CGFloat dismissDelayTimeInterval;
@property (nonatomic, assign) CGFloat dismissTimeInterval;

#pragma mark - Override
//! 屏幕方向发生变化时，子类可以重载
- (void)deviceOrientationWillChangeWithContentMaximumHeight:(CGFloat)contentMaximumHeight
                                                   duration:(NSTimeInterval)duration;
@end



@interface UIViewController (UkeAlertController)

//! 通过identifier移除指定alertController
- (void)removeUkeAlertControllerWithIdentifier:(NSString *)identifier
                                      animated:(BOOL)animated
                                    completion:(nullable void(^)(void))completion;

//! 移除当前显示的和暂时隐藏在栈区的所有alertController
- (void)removeAllUkeAlertConrollerAnimated:(BOOL)animated
                                completion:(nullable void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
