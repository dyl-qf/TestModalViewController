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

@interface UkeAlertController : UkePopUpViewController

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                     message:(nullable NSString *)message
                              preferredStyle:(UIAlertControllerStyle)preferredStyle;

- (void)addAction:(UkeAlertAction *)action;
@property (nonatomic, readonly) NSArray<UkeAlertAction *> *actions;

//! 如果是alertView中间内容区宽度，默认270，跟系统保持一致
@property (nonatomic, assign) CGFloat contentWidth;

//! 标题相关属性
@property(nonatomic, strong) NSDictionary<NSString *, id> *titleAttributes;
//! message相关属性
@property(nonatomic, strong) NSDictionary<NSString *, id> *messageAttributes;

//! 按钮相关属性
@property(nonatomic, strong) NSDictionary<NSString *, id> *defaultButtonAttributes;
@property(nonatomic, strong) NSDictionary<NSString *, id> *cancelButtonAttributes;
@property(nonatomic, strong) NSDictionary<NSString *, id> *destructiveButtonAttributes;

@end

NS_ASSUME_NONNULL_END
