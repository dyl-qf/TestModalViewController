//
//  UkePopUpViewController.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkePopUpViewController.h"
#import "UkeAlertStyleAnimation.h"
#import "Masonry.h"

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

+ (instancetype)alertControllerWithContentView:(UIView *)view
                             preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UkePopUpViewController *popUpController = [[UkePopUpViewController alloc] init];
    [popUpController addContentView:view];
    return popUpController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Public.
- (void)setContentWidth:(CGFloat)contentWidth {
    _contentWidth = contentWidth;
    if (!self.contentView) {
        return;
    }
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (contentWidth != 0) {
            make.width.mas_equalTo(contentWidth);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    [self.view layoutIfNeeded];
    self.view.bounds = self.contentView.bounds;
}

- (void)addContentView:(UIView *)view {
    if (self.contentView) {
        [self.contentView removeFromSuperview];
    }
    
    self.contentView = view;
    
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.contentWidth != 0) {
            make.width.mas_equalTo(self.contentWidth);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    [self.view layoutIfNeeded];
    self.view.bounds = self.contentView.bounds;
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
