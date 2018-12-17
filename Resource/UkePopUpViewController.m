//
//  UkePopUpViewController.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkePopUpViewController.h"
#import "UkeAlertStyleAnimation.h"

@interface UkePopUpViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIView *contentView;
@end

@implementation UkePopUpViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.transitioningDelegate = self;
    }
    return self;
}

+ (instancetype)uke_alertControllerWithContentView:(UIView *)view
                             preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UkePopUpViewController *popUpController = [[UkePopUpViewController alloc] init];
    [popUpController addContentView:view];
    return popUpController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 12.0;
    self.view.layer.masksToBounds = YES;
}

#pragma mark - Public.
- (void)addContentView:(UIView *)view {
    self.contentView = view;
    self.view.bounds = view.bounds;
    [self.view addSubview:self.contentView];
}

- (void)dismiss {
    [self dismissPopControllerAnimated:YES];
}

- (void)dismissWithAnimated:(BOOL)animated {
    [self dismissPopControllerAnimated:animated];
}

#pragma mark - Private.
- (void)dismissPopControllerAnimated:(BOOL)animated {
    [self dismissViewControllerAnimated:animated completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate.
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    UkeAlertStyleAnimation *animation = [[UkeAlertStyleAnimation alloc] init];
    animation.isPresented = YES;
    return animation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    UkeAlertStyleAnimation *animation = [[UkeAlertStyleAnimation alloc] init];
    return animation;
}

@end
