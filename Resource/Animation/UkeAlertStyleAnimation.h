//
//  UkeAlertStyleAnimation.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UkeAlertStyleAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPresented;
@end

NS_ASSUME_NONNULL_END
