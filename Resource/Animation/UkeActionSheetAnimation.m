//
//  UkeActionSheetAnimation.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeActionSheetAnimation.h"

@implementation UkeActionSheetAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.isPresented ? 0.18 : 0.16;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresented) {
        [self animateForPresentTransition:transitionContext];
    }else {
        [self animateForDismissTransition:transitionContext];
    }
}

- (void)animateForPresentTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = nil;
    UIView *toView = nil;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else {
        fromView = fromVc.view;
        toView = toVc.view;
    }
    
    UIView *containerView = [transitionContext containerView];
    // 添加黑色遮罩
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    maskView.tag = 1000;
    maskView.frame = containerView.bounds;
    maskView.alpha = 0;
    [containerView addSubview:maskView];
    
    // 添加toView
    CGRect startFrame = CGRectMake((CGRectGetWidth(containerView.frame)-CGRectGetWidth(toView.frame))*0.5, CGRectGetHeight(containerView.frame), CGRectGetWidth(toView.frame), CGRectGetHeight(toView.frame));
    toView.frame = startFrame;
    [containerView addSubview:toView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect endFrame = CGRectMake((CGRectGetWidth(containerView.frame)-CGRectGetWidth(toView.frame))*0.5, CGRectGetHeight(containerView.frame)-CGRectGetHeight(toView.frame)-8.0, CGRectGetWidth(toView.frame), CGRectGetHeight(toView.frame));
    [UIView animateWithDuration:duration+0.2 delay:0.1 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        toView.frame = endFrame;
        maskView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)animateForDismissTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *fromView = nil;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    }else {
        fromView = fromVc.view;
    }
    
    UIView *containerView = [transitionContext containerView];
    UIView *maskView = [containerView viewWithTag:1000];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    NSTimeInterval delay = 0.0;
    
    CGRect endFrame = CGRectMake((CGRectGetWidth(containerView.frame)-CGRectGetWidth(fromView.frame))*0.5, CGRectGetHeight(containerView.frame), CGRectGetWidth(fromView.frame), CGRectGetHeight(fromView.frame));
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
        fromView.frame = endFrame;
        maskView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [maskView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
