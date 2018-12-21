//
//  UkeAlertHeaderView.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UkeAlertHeaderView : UIView

- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
               preferredStyle:(UIAlertControllerStyle)preferredStyle;

//! 标题相关属性
@property(nonatomic, strong) NSDictionary<NSString *, id> *titleAttributes;
//! message相关属性
@property(nonatomic, strong) NSDictionary<NSString *, id> *messageAttributes;

@end

NS_ASSUME_NONNULL_END
