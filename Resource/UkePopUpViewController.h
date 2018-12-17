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

+ (instancetype)uke_alertControllerWithContentView:(UIView *)view
                             preferredStyle:(UIAlertControllerStyle)preferredStyle;

- (void)addContentView:(UIView *)view;

- (void)dismiss;
- (void)dismissWithAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
