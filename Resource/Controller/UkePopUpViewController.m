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
#import "UkeAlertSingleton.h"
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
        self.identifier = [NSUUID UUID].UUIDString;
        self.maskBackgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.showPriority = UkePopUpControllerPriorityDefault;
        self.maskType = UkePopUpControllerMaskTypeDefault;
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    !self.viewDidLayoutSubviewsBlock ?: self.viewDidLayoutSubviewsBlock();
}

#pragma mark - 监听屏幕方向变化
#ifdef __IPHONE_8_0
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        CGFloat safePadding = 0;
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets safeInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
            safePadding = MAX(safeInsets.top, safeInsets.bottom);
        }else {
            UkeAlertPresentingViewController *presentingVc = [[UkeAlertSingleton sharedInstance] ukeAlertPresentViewController];
            safePadding = MAX(presentingVc.topLayoutGuide.length, presentingVc.bottomLayoutGuide.length);
        }
        if (safePadding == 0) {
            safePadding = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)?:20;
        }
        
        CGFloat newContentMaximumHeight = 0;
        if (self.contentMaximumHeightInset > 2*safePadding) {
            newContentMaximumHeight = size.height - self.contentMaximumHeightInset;
        }else {
            newContentMaximumHeight = size.height - 2*safePadding;
        }
        
        [self deviceOrientationWillChangeWithContentMaximumHeight:newContentMaximumHeight duration:context.transitionDuration];
    } completion:nil];
}
#else
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    UkeAlertPresentingViewController *presentingVc = [[UkeAlertSingleton sharedInstance] ukeAlertPresentViewController];
    
    CGFloat safePadding = MAX(presentingVc.topLayoutGuide.length, presentingVc.bottomLayoutGuide.length);
    if (safePadding == 0) {
        safePadding = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)?:20;
    }
    
    CGFloat newContentMaximumHeight = 0;
    if (self.contentMaximumHeightInset > 2*safePadding) {
        newContentMaximumHeight = CGRectGetHeight([UIScreen mainScreen].bounds) - self.contentMaximumHeightInset;
    }else {
        newContentMaximumHeight = CGRectGetHeight([UIScreen mainScreen].bounds) - 2*safePadding;
    }
    
    [self deviceOrientationWillChangeWithContentMaximumHeight:newContentMaximumHeight duration:duration];
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
    
    CGFloat safePadding = 0;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
        safePadding = MAX(safeInsets.top, safeInsets.bottom);
    }else {
        UkeAlertPresentingViewController *presentingVc = [[UkeAlertSingleton sharedInstance] ukeAlertPresentViewController];
        safePadding = MAX(presentingVc.topLayoutGuide.length, presentingVc.bottomLayoutGuide.length);
    }
    
    if (safePadding == 0) {
        safePadding = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)?:20;
    }
    
    if (preferredStyle == UIAlertControllerStyleAlert) {
        self.presentDelayTimeInterval = 0;
        self.presentTimeInterval = 0.25;
        self.dismissDelayTimeInterval = 0.1;
        self.dismissTimeInterval = 0.22;
        self.shouldRespondsMaskViewTouch = NO;
    }else if (preferredStyle == UIAlertControllerStyleActionSheet) {
        self.presentDelayTimeInterval = 0.1;
        self.presentTimeInterval = 0.18;
        self.dismissDelayTimeInterval = 0.1;
        self.dismissTimeInterval = 0.16;
        self.shouldRespondsMaskViewTouch = YES;
    }
    
    self.contentMaximumHeight = CGRectGetHeight([UIScreen mainScreen].bounds)-2*safePadding;
}

- (void)addContentView:(UIView *)view {
    _contentView = view;
}

#pragma mark - Show
- (void)uke_show {
    [self uke_showWithAnimated:YES];
}

- (void)uke_showWithAnimated:(BOOL)animated {
    [self uke_showWithAnimated:animated completion:nil];
}

- (void)uke_showWithAnimated:(BOOL)animated
              completion:(nullable void(^)(void))completionHandler {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:YES];
    
    UkeAlertPresentingViewController *presentingVc = [[UkeAlertSingleton sharedInstance] ukeAlertPresentViewController];
    [presentingVc uke_presentPopUpViewController:self animated:animated completion:completionHandler];
}

#pragma mark - Dismiss
- (void)uke_dismiss {
    [self uke_dismissWithAnimated:YES];
}

- (void)uke_dismissWithAnimated:(BOOL)animated {
    [self uke_dismissWithAnimated:animated completion:nil];
}

- (void)uke_dismissWithAnimated:(BOOL)animated
                 completion:(nullable void (^)(void))completionHandler {
    UkeAlertPresentingViewController *presentingVc = [[UkeAlertSingleton sharedInstance] ukeAlertPresentViewController];
    [presentingVc ukePopUpViewControllerWillDismiss:self];
    
    [self dismissViewControllerAnimated:animated completion:^{
        if (self.dismissCompletion) {
            self.dismissCompletion();
        }
        [presentingVc ukePopUpViewControllerDidDismiss];
        
        if (completionHandler) {
            completionHandler();
        }
    }];
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
    _contentMaximumHeightInset =(CGRectGetHeight([UIScreen mainScreen].bounds)-contentMaximumHeight>=0)?:0;
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

- (CGFloat)sheetContentMarginBottom {
    CGFloat safePaddingBottom = 0;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
        safePaddingBottom = safeInsets.bottom;
    }
    return _sheetContentMarginBottom+safePaddingBottom;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        UkePopUpViewController *popUpViewController = (UkePopUpViewController *)object;
        return [self.identifier isEqualToString:popUpViewController.identifier];
    }
    return NO;
}

- (NSUInteger)hash {
    return self.identifier.hash;
}

- (void)dealloc {
    NSLog(@"UkePopUpViewController 销毁");
}

@end


@implementation UIViewController (UkeAlertController)

- (BOOL)isUkeAlertControllerCurrentShowed {
    UkeAlertPresentingViewController *presentingVc = [[UkeAlertSingleton sharedInstance] ukeAlertPresentViewController];
    return [presentingVc ukeIsUkeAlertControllerCurrentShowed];
}

- (void)removeUkeAlertControllerWithIdentifier:(NSString *)identifier
                                      animated:(BOOL)animated
                                    completion:(nullable void (^)(void))completion {
    UkeAlertPresentingViewController *presentingVc = [[UkeAlertSingleton sharedInstance] ukeAlertPresentViewController];
    [presentingVc ukeRemoveAlertConrollerWithIdentifier:identifier animated:animated completion:completion];
}

- (void)removeAllUkeAlertConrollerAnimated:(BOOL)animated
                                completion:(nullable void (^)(void))completion {
    UkeAlertPresentingViewController *presentingVc = [[UkeAlertSingleton sharedInstance] ukeAlertPresentViewController];
    [presentingVc ukeRemoveAllAlertConrollerAnimated:animated completion:completion];
}

@end
