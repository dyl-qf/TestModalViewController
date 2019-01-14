//
//  UkeAlertSingleton.h
//  TestModalViewController
//
//  Created by liqian on 2019/1/14.
//  Copyright © 2019 liqian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UkeAlertPresentingViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UkeAlertSingleton : NSObject

+ (UkeAlertSingleton *)sharedInstance;

- (UkeAlertPresentingViewController *)ukeAlertPresentViewController;

//! 销毁单例
- (void)destoryUkeAlertSingleton;

@end

NS_ASSUME_NONNULL_END
