//
//  UkeAlertActionGroupView.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/18.
//  Copyright © 2018 liqian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UkeAlertAction;
@interface UkeAlertActionGroupView : UIView

- (void)addAction:(UkeAlertAction *)action;

- (void)layoutActions;

@property (nonatomic, readonly) NSArray<UkeAlertAction *> *actions;
@property (nonatomic, strong) void(^dismissHandler)(void);

//! 按钮相关属性
@property (nonatomic, assign) CGFloat actionButtonHeight; // alert默认44.0，sheet默认57.0，跟系统保持一致
@property(nonatomic, strong) NSDictionary<NSString *, id> *defaultButtonAttributes;
@property(nonatomic, strong) NSDictionary<NSString *, id> *cancelButtonAttributes;
@property(nonatomic, strong) NSDictionary<NSString *, id> *destructiveButtonAttributes;

@end

NS_ASSUME_NONNULL_END