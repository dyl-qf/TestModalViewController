//
//  UIView+CornerRadius.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/22.
//  Copyright © 2018 liqian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CornerRadius)

- (void)roundedRectWithRectCorner:(UIRectCorner)rectCorner
                     cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
