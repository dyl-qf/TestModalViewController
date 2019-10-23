//
//  UkeAlertAction.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/18.
//  Copyright © 2018 liqian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UkeAlertActionButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface UkeAlertAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title
                              style:(UIAlertActionStyle)style
                            handler:(void (^ __nullable)(UkeAlertAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, assign, readonly) UIAlertActionStyle style;
@property (nullable, nonatomic, strong, readonly) void(^actionHandler)(UkeAlertAction *action);

// 按钮的enable属性。Default YES
@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, assign) BOOL shouldAutoDismissAlertController; //!< 点击按钮之后是否自动隐藏整个alertController。默认YES

// UkeAlertAction所对应的按钮，可能为空。
// 注：actionButton只有在controller调用了uke_show后才能获取到。
@property (nonatomic, strong, nullable) UkeAlertActionButton *actionButton;

@end

NS_ASSUME_NONNULL_END
