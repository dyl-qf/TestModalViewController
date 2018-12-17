//
//  UkeAlertController.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkePopUpViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UkeAlertController : UkePopUpViewController

+ (instancetype)uke_alertControllerWithTitle:(nullable NSString *)title
                                     message:(nullable NSString *)message
                              preferredStyle:(UIAlertControllerStyle)preferredStyle;

//! 默认270
@property (nonatomic, assign) CGFloat contentWidth;

@end

NS_ASSUME_NONNULL_END
