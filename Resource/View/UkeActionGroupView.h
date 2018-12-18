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

@end

NS_ASSUME_NONNULL_END
