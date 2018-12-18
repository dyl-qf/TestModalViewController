//
//  UkeActionGroupView.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/18.
//  Copyright © 2018 liqian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UkeAlertAction;
@interface UkeActionGroupView : UIView

- (void)addAction:(UkeAlertAction *)action;
@property (nonatomic, readonly) NSArray<UkeAlertAction *> *actions;
@property (nonatomic, strong) void(^dismissHandler)(void);

//! 按钮相关属性
@property(nonatomic, strong) NSDictionary<NSString *, id> *defaultButtonAttributes;
@property(nonatomic, strong) NSDictionary<NSString *, id> *cancelButtonAttributes;
@property(nonatomic, strong) NSDictionary<NSString *, id> *destructiveButtonAttributes;

@end

NS_ASSUME_NONNULL_END
