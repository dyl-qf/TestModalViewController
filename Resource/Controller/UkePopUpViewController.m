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

@interface UkePopUpViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, assign) CGFloat contentMaximumHeightInset;
@property (nonatomic, strong) UkeAlertBaseAnimation *animation;
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
    popUpController.preferredStyle = preferredStyle;
    [popUpController addContentView:view];
    return popUpController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:_contentView];
    
    CGFloat contentMaximumHeight = self.contentMaximumHeight;
    if (_preferredStyle == UIAlertControllerStyleActionSheet) {
        contentMaximumHeight = self.contentMaximumHeight-self.sheetContentMarginBottom;
    }
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.contentWidth != 0) {
            make.width.mas_equalTo(self.contentWidth);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_lessThanOrEqualTo(contentMaximumHeight);
    }];
    [self.view layoutIfNeeded];
    self.view.bounds = _contentView.bounds;
}

#pragma mark - 监听屏幕方向变化
#ifdef __IPHONE_8_0
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        CGFloat newContentMaximumHeight = size.height-self.contentMaximumHeightInset;
        if (self.preferredStyle == UIAlertControllerStyleActionSheet) {
            UIDevice *device = [UIDevice currentDevice];
            // 如果是横屏
            if (device.orientation == UIDeviceOrientationLandscapeLeft ||
                device.orientation == UIDeviceOrientationLandscapeRight) {
                newContentMaximumHeight += 20; // 横屏时状态栏是隐藏的，所以多出20pt
            }
        }
        
        [self deviceOrientationWillChangeWithContentMaximumHeight:newContentMaximumHeight duration:context.transitionDuration];
    } completion:nil];
}
#else
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    [self deviceOrientationWillChangeWithContentMaximumHeight:CGRectGetHeight([UIScreen mainScreen].bounds)-self.contentMaximumHeightInset duration:duration];
}
#endif

- (void)deviceOrientationWillChangeWithContentMaximumHeight:(CGFloat)contentMaximumHeight
                                                  duration:(NSTimeInterval)duration {
    if (_preferredStyle == UIAlertControllerStyleActionSheet) {
        contentMaximumHeight = contentMaximumHeight-self.sheetContentMarginBottom;
    }
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_lessThanOrEqualTo(contentMaximumHeight);
    }];
    [self.view layoutIfNeeded];
    self.view.bounds = _contentView.bounds;
    
    [self.animation deviceOrientationDidChangeDuration:duration];
}

#pragma mark - Public.
- (void)setPreferredStyle:(UIAlertControllerStyle)preferredStyle {
    _preferredStyle = preferredStyle;
    if (preferredStyle == UIAlertControllerStyleAlert) {
        self.presentDelayTimeInterval = 0;
        self.presentTimeInterval = 0.25;
        self.dismissDelayTimeInterval = 0.1;
        self.dismissTimeInterval = 0.22;
        self.shouldRespondsMaskViewTouch = NO;
        self.contentMaximumHeight = [UIScreen mainScreen].bounds.size.height-24-24;
    }else if (preferredStyle == UIAlertControllerStyleActionSheet) {
        self.presentDelayTimeInterval = 0.1;
        self.presentTimeInterval = 0.18;
        self.dismissDelayTimeInterval = 0.1;
        self.dismissTimeInterval = 0.16;
        self.shouldRespondsMaskViewTouch = YES;
        self.contentMaximumHeight = [UIScreen mainScreen].bounds.size.height-40;
    }
}

- (void)addContentView:(UIView *)view {
    _contentView = view;
}

- (void)dismiss {
    [self dismissWithAnimated:YES];
}

- (void)dismissWithAnimated:(BOOL)animated {
    [self dismissViewControllerAnimated:animated completion:nil];
}

- (void)dismissWithAnimated:(BOOL)animated completion:(void (^)(void))completionHandler {
    [self dismissPopControllerAnimated:animated completion:completionHandler];
}

#pragma mark - Private.
- (void)dismissPopControllerAnimated:(BOOL)animated completion:(void (^)(void))completionHandler {
    [self dismissViewControllerAnimated:animated completion:completionHandler];
}

#pragma mark - UIViewControllerTransitioningDelegate.
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    UkeAlertBaseAnimation *animation = self.animation;
    animation.isPresented = YES;
    return animation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    UkeAlertBaseAnimation *animation = self.animation;
    animation.isPresented = NO;
    return animation;
}

#pragma mark - Setter.
- (void)setContentMaximumHeight:(CGFloat)contentMaximumHeight {
    _contentMaximumHeight = contentMaximumHeight;
    _contentMaximumHeightInset = CGRectGetHeight([UIScreen mainScreen].bounds)-contentMaximumHeight;
}

- (void)setPresentDelayTimeInterval:(CGFloat)presentDelayTimeInterval {
    _presentDelayTimeInterval = presentDelayTimeInterval;
    self.animation.presentDelayTimeInterval = presentDelayTimeInterval;
}

- (void)setPresentTimeInterval:(CGFloat)presentTimeInterval {
    _presentTimeInterval = presentTimeInterval;
    self.animation.presentTimeInterval = presentTimeInterval;
}

- (void)setDismissDelayTimeInterval:(CGFloat)dismissDelayTimeInterval {
    _dismissDelayTimeInterval = dismissDelayTimeInterval;
    self.animation.dismissDelayTimeInterval = dismissDelayTimeInterval;
}

- (void)setDismissTimeInterval:(CGFloat)dismissTimeInterval {
    _dismissTimeInterval = dismissTimeInterval;
    self.animation.dismissTimeInterval = dismissTimeInterval;
}

#pragma mark - Getter.
- (UkeAlertBaseAnimation *)animation {
    if (!_animation) {
        if (self.preferredStyle == UIAlertControllerStyleAlert) {
            _animation = [[UkeAlertStyleAnimation alloc] init];
        }else if (self.preferredStyle == UIAlertControllerStyleActionSheet) {
            _animation = [[UkeActionSheetAnimation alloc] init];
        }
    }
    return _animation;
}

- (void)dealloc {
    NSLog(@"UkePopUpViewController 销毁");
}

@end
