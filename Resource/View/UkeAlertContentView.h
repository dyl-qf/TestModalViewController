//
//  UkeAlertContentView.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UkeAlertContentView : UIView

- (void)insertHeaderView:(UIView *)headerView;
- (void)insertActionGroupView:(UIView *)actionGroupView;

@end

NS_ASSUME_NONNULL_END
