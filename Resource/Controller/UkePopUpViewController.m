//
//  UkePopUpViewController.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkePopUpViewController.h"
#import "UkeAlertStyleAnimation.h"
#import "UkeActionSheetAnimation.h"
#import "Masonry.h"

@interface UkePopUpViewController () <UIViewControllerTransitioningDelegate> {
    CGFloat contentMaximumHeight;
}
@property (nonatomic, strong) UIView *contentView;
@end

@implementation UkePopUpViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.transitioningDelegate = self;
        contentMaximumHeight = [UIScreen mainScreen].bounds.size.height-24-24;
    }
    return self;
}

+ (instancetype)alertControllerWithContentView:(UIView *)view
                             preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UkePopUpViewController *popUpController = [[UkePopUpViewController alloc] init];
    popUpController.preferredStyle = preferredStyle;
    [popUpController addContentView:view];
    return popUpController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Public.
- (void)setPreferredStyle:(UIAlertControllerStyle)preferredStyle {
    _preferredStyle = preferredStyle;
    if (preferredStyle == UIAlertControllerStyleActionSheet) {
        contentMaximumHeight = contentMaximumHeight-_sheetContentMarginBottom;
    }
}

- (void)setContentWidth:(CGFloat)contentWidth {
    _contentWidth = contentWidth;
    if (!_contentView || !_contentView.superview) {
        return;
    }
    
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (contentWidth != 0) {
            make.width.mas_equalTo(contentWidth);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_lessThanOrEqualTo(self->contentMaximumHeight);
    }];
    [self.view layoutIfNeeded];
    self.view.bounds = _contentView.bounds;
}

- (void)addContentView:(UIView *)view {
    if (_contentView) {
        [_contentView removeFromSuperview];
        _contentView = nil;
    }
    
    _contentView = view;
    
    [self.view addSubview:_contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.contentWidth != 0) {
            make.width.mas_equalTo(self.contentWidth);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_lessThanOrEqualTo(self->contentMaximumHeight);
    }];
    [self.view layoutIfNeeded];
    self.view.bounds = _contentView.bounds;
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
    if (self.preferredStyle == UIAlertControllerStyleAlert) {
        UkeAlertStyleAnimation *animation = [[UkeAlertStyleAnimation alloc] init];
        animation.isPresented = YES;
        return animation;
    }else if (self.preferredStyle == UIAlertControllerStyleActionSheet) {
        UkeActionSheetAnimation *animation = [[UkeActionSheetAnimation alloc] init];
        animation.isPresented = YES;
        return animation;
    }
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (self.preferredStyle == UIAlertControllerStyleAlert) {
        UkeAlertStyleAnimation *animation = [[UkeAlertStyleAnimation alloc] init];
        return animation;
    }else if (self.preferredStyle == UIAlertControllerStyleActionSheet) {
        UkeActionSheetAnimation *animation = [[UkeActionSheetAnimation alloc] init];
        return animation;
    }
    return nil;
}

- (void)dealloc {
    NSLog(@"UkePopUpViewController 销毁");
}

@end
