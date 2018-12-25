//
//  UkeAlertStyleAnimation.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertStyleAnimation.h"
#import "UkePopUpViewController.h"

@interface UkeAlertStyleAnimation ()
@property (nonatomic, weak) UkePopUpViewController *popUpVc;
@end

@implementation UkeAlertStyleAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.isPresented ? self.presentTimeInterval : self.dismissTimeInterval;
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
    UkePopUpViewController *popUpVc = (UkePopUpViewController *)toVc;

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
    if (popUpVc.shouldRespondsMaskViewTouch) {
        _popUpVc = popUpVc;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMaskViewTapAction)];
        [maskView addGestureRecognizer:tap];
    }
    
    // 添加toView
    toView.center = containerView.center;
    toView.alpha = 0;
    [containerView addSubview:toView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:self.presentDelayTimeInterval options:0 animations:^{
        toView.alpha = 1.0;
        maskView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    [self showAlertAnimationForView:toView duration:duration];
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
    NSTimeInterval delay = self.dismissDelayTimeInterval;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        fromView.hidden = YES;
    });
    
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
        maskView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [maskView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (void)showAlertAnimationForView:(UIView *)view duration:(NSTimeInterval)duration {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = duration;
    
    [view.layer addAnimation:animation forKey:@"showAlert"];
}

- (void)handleMaskViewTapAction {
    [_popUpVc dismiss];
}

- (void)dealloc {
    NSLog(@"animation 销毁");
}

@end
