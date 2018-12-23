//
//  UkeSheetContentView.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/22.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertContentView.h"

NS_ASSUME_NONNULL_BEGIN

@class UkeAlertAction;
@interface UkeSheetContentView : UkeAlertContentView
@property (nonatomic, assign) CGFloat sheetCancelButtonMarginTop;

@property (nonatomic, strong) void(^dismissHandler)(void);

//MARK: 取消按钮相关属性
// 取消按钮高度默认57.0，跟系统保持一致
@property (nonatomic, assign) CGFloat cancelActionButtonHeight;
@property(nonatomic, strong) NSDictionary<NSString *, id> *cancelButtonAttributes;

- (void)addCancelAction:(UkeAlertAction *)action;

@end

NS_ASSUME_NONNULL_END
