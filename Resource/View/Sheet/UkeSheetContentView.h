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

- (void)addCancelAction:(UkeAlertAction *)action;

@end

NS_ASSUME_NONNULL_END
