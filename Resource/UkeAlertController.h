//
//  UkeAlertController.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkePopUpViewController.h"
#import "NSParagraphStyle+Shortcut.h"
#import "UkeAlertAction.h"

NS_ASSUME_NONNULL_BEGIN

NS_CLASS_AVAILABLE_IOS(6_0)
@interface UkeAlertController : UkePopUpViewController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;


+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                     message:(nullable NSString *)message
                              preferredStyle:(UIAlertControllerStyle)preferredStyle;

- (void)addAction:(UkeAlertAction *)action;
@property (nonatomic, readonly) NSArray<UkeAlertAction *> *actions;



/**
 添加一个自定义内容头视图
 
 @warning 对于UkeAlertController来说，这个view将作为headerView取代由title和message生成的UkeAlertHeaderView
 @warning 对于UkePopUpViewController来说，这个view即为整个contentView
 */
+ (instancetype)alertControllerWithContentView:(nullable UIView *)view
                                preferredStyle:(UIAlertControllerStyle)preferredStyle;
- (void)addContentView:(UIView *)view;


//! 中间内容区宽度。如果是alertView，默认270；如果是actionSheet，默认为屏幕宽度-8-8，跟系统保持一致
//! 注意：如果是通过alertControllerWithContentView或者addContentView来添加内容，则contentWidth无默认值，除非手动指定
@property (nonatomic, assign) CGFloat contentWidth;


//   -----------------------
//  |        ---------      |
//  |       |  title  |     |
//  |       |         |     |
//  |       | message|      |
//  |        ---------      |
//   -----------------------

//! title所在文本区域离四周的距离
//! alert默认为 (20, 16, 20, 16)，与系统一致
//! sheet默认为 (14.5, 16, 25, 16)，与系统一致
@property (nonatomic, assign) UIEdgeInsets titleMessageAreaContentInsets;

//! title和message竖直方向的间距
//! alert默认为 2，与系统一致
//! sheet默认为 12，与系统一致
@property (nonatomic, assign) CGFloat titleMessageVerticalSpacing;


//! actionSheet的cancelButton距离上边内容的间距，默认为8，跟系统保持一致
@property (nonatomic, assign) CGFloat sheetCancelButtonMarginTop;

//! actionSheet整体内容距离屏幕底部距离，默认为8，跟系统保持一致。注意：刘海屏会自动再加上底部安全区域高度
@property (nonatomic, assign) CGFloat sheetContentMarginBottom;

//! 标题相关属性
@property(nonatomic, strong) NSDictionary<NSString *, id> *titleAttributes;
//! message相关属性
@property(nonatomic, strong) NSDictionary<NSString *, id> *messageAttributes;
//! 按钮相关属性
// 按钮高度。alert默认44.0，sheet默认57.0，跟系统保持一致
@property (nonatomic, assign) CGFloat actionButtonHeight;
@property(nonatomic, strong) NSDictionary<NSString *, id> *defaultButtonAttributes;
@property(nonatomic, strong) NSDictionary<NSString *, id> *cancelButtonAttributes;
@property(nonatomic, strong) NSDictionary<NSString *, id> *destructiveButtonAttributes;

//! 圆角值、默认12.0，与系统一致
@property (nonatomic, assign) CGFloat cornerRadius;

//! 线的宽度，默认1px
@property (nonatomic, assign) CGFloat lineHeight;
//! 线的颜色，
@property (nonatomic, strong) UIColor *lineColor;

@end

NS_ASSUME_NONNULL_END

