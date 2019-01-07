//
//  UkeActionSheetAnimation.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeActionSheetAnimation.h"
#import "UkePopUpViewController.h"
#import "Masonry.h"

@interface UkeActionSheetAnimation ()
@property (nonatomic, weak) UkePopUpViewController *popUpVc;
@end

@implementation UkeActionSheetAnimation

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
    maskView.alpha = 0;
    [containerView addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    if (popUpVc.shouldRespondsMaskViewTouch) {
        _popUpVc = popUpVc;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMaskViewTapAction)];
        [maskView addGestureRecognizer:tap];
    }
    
    // 添加toView
    CGRect startFrame = CGRectMake((CGRectGetWidth(containerView.frame)-CGRectGetWidth(toView.frame))*0.5, CGRectGetHeight(containerView.frame), CGRectGetWidth(toView.frame), CGRectGetHeight(toView.frame));
    toView.frame = startFrame;
    [containerView addSubview:toView];
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(containerView.mas_centerX);
        make.bottom.offset(CGRectGetHeight(toView.frame));
        make.size.mas_equalTo(toView.bounds.size);
    }];
    [containerView layoutIfNeeded];

    
    CGFloat marginBottom = popUpVc.sheetContentMarginBottom;
    [toView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-marginBottom);
    }];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration+0.2 delay:self.presentDelayTimeInterval usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
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
    
    [fromView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(CGRectGetHeight(fromView.frame));
    }];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    NSTimeInterval delay = self.dismissDelayTimeInterval;
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
        [containerView layoutIfNeeded];
        maskView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [maskView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (void)handleMaskViewTapAction {
    [_popUpVc dismiss];
}

- (void)dealloc {
    NSLog(@"animation 销毁");
}

@end
