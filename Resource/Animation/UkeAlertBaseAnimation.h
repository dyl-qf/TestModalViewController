//
//  UkeAlertBaseAnimation.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/25.
//  Copyright © 2018 liqian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UkeAlertBaseAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPresented;

@property (nonatomic, assign) CGFloat presentDelayTimeInterval;
@property (nonatomic, assign) CGFloat presentTimeInterval;

@property (nonatomic, assign) CGFloat dismissDelayTimeInterval;
@property (nonatomic, assign) CGFloat dismissTimeInterval;

@end

NS_ASSUME_NONNULL_END
