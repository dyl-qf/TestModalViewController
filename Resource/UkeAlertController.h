//
//  UkeAlertController.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkePopUpViewController.h"
#import "UkeAlertAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface UkeAlertController : UkePopUpViewController

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                     message:(nullable NSString *)message
                              preferredStyle:(UIAlertControllerStyle)preferredStyle;

- (void)addAction:(UkeAlertAction *)action;
@property (nonatomic, readonly) NSArray<UkeAlertAction *> *actions;

//! 默认270
@property (nonatomic, assign) CGFloat contentWidth;

@end

NS_ASSUME_NONNULL_END
