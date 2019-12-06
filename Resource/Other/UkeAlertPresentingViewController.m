//
//  UkeAlertPresentingViewController.m
//  TestModalViewController
//
//  Created by liqian on 2019/1/14.
//  Copyright © 2019 liqian. All rights reserved.
//

#import "UkeAlertPresentingViewController.h"
#import "UkePopUpViewController.h"
#import "UkeAlertSingleton.h"

@interface UkeAlertPresentingViewController ()
@property (nonatomic, strong) UIWindow *window;

@property (atomic, assign) BOOL isAnimating;
@property (nonatomic, strong) UkePopUpViewController *currentPrentedVc;
// 已经弹出过的UkePopUpViewController的栈
@property (nonatomic, strong) NSMutableArray<UkePopUpViewController *> *alertHierarchStack;
// 将要弹出的UkePopUpViewController，来不及弹出的UkePopUpViewController都会被放在这个数组里
@property (nonatomic, strong) NSMutableArray<UkePendingPopUpModel *> *pendingAlertControllers;
@end

@implementation UkeAlertPresentingViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                
        UIWindow *window = nil;
#ifdef __IPHONE_13_0
        if (@available(iOS 13, *)) {
            window = [[UIWindow alloc] initWithWindowScene:UIApplication.sharedApplication.keyWindow.windowScene];
        } else {
            window = [[UIWindow alloc] init];
        }
#else
        window = [[UIWindow alloc] init];
#endif
        window.backgroundColor = [UIColor clearColor];
        window.frame = [UIScreen mainScreen].bounds;
        window.windowLevel = UIWindowLevelAlert;
        self.window = window;
        
        self.isAnimating = NO;
        self.alertHierarchStack = [NSMutableArray array];
        self.pendingAlertControllers = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Public
- (void)uke_presentPopUpViewController:(UkePopUpViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                        completion:(void (^)(void))completion {
    if (self.window.isHidden == YES) {
        self.window.rootViewController = self;
        self.window.hidden = NO;
    }
    
    if (self.isAnimating == YES) { // 如果正在进行跳转动画
        UkePendingPopUpModel *model = [[UkePendingPopUpModel alloc] init];
        model.popController = viewControllerToPresent;
        model.animated = flag;
        model.completion = completion;
        if (viewControllerToPresent.showPriority == UkePopUpControllerPriorityDefault) {
            [self.pendingAlertControllers insertObject:model atIndex:0];
        } else {
            [self.pendingAlertControllers addObject:model];
        }
        return;
    }
    
    if (self.currentPrentedVc) { // 当前屏幕上有正在显示的alert
        if (viewControllerToPresent.showPriority == UkePopUpControllerPriorityDefault) { // 暂时隐藏旧的，弹出新的
            self.isAnimating = YES;
            // 注意：这里不能调用UkePopUpViewController的dismiss方法，因为这会触发下面"pop消失回调"的那两个方法。
            [self.currentPrentedVc dismissViewControllerAnimated:NO completion:^{
                // 这里不能调用uke_presentPopUpViewController方法，否则会进入死循环。
                [self presentViewController:viewControllerToPresent animated:flag completion:^{
                    [self removeEqualVcFromStackWithIdentifier:viewControllerToPresent.identifier];
                    [self.alertHierarchStack addObject:viewControllerToPresent];
                    [self log];

                    self.currentPrentedVc = viewControllerToPresent;
                    
                    self.isAnimating = NO;
                    if (completion) completion();
                    // 弹出完毕之后，检查pendingAlertControllers里有没有等待弹出的alertController，如果有的话继续弹出
                    [self checkToPresentPendingPopUpController];
                }];
            }];
        } else if (viewControllerToPresent.showPriority == UkePopUpControllerPriorityLow) { // 旧的不隐藏，新的暂存
            [self removeEqualVcFromStackWithIdentifier:viewControllerToPresent.identifier];
            [self.alertHierarchStack insertObject:viewControllerToPresent atIndex:0];
            
            [self log];
        }
    }else { // 当前没有正在显示的alert
        self.isAnimating = YES;
        // 注意：这里不能调用uke_presentPopUpViewController方法，否则会进入死循环。
        [self presentViewController:viewControllerToPresent animated:flag completion:^{
            [self removeEqualVcFromStackWithIdentifier:viewControllerToPresent.identifier];
            [self.alertHierarchStack addObject:viewControllerToPresent];
            [self log];
            
            self.currentPrentedVc = viewControllerToPresent;

            self.isAnimating = NO;
            if (completion) completion();
            [self checkToPresentPendingPopUpController];
        }];
    }
}

- (BOOL)ukeIsUkeAlertControllerCurrentShowed {
    return (_currentPrentedVc != nil);
}

- (void)ukeRemoveAllAlertConrollerAnimated:(BOOL)animated
                                completion:(nullable void (^)(void))completion {
    if (_currentPrentedVc) {
        [self.alertHierarchStack removeAllObjects];
        [_currentPrentedVc uke_dismissWithAnimated:animated completion:^{
            if (completion) completion();
        }];
    }else {
        self.currentPrentedVc = nil;
        self.window.rootViewController = nil;
        self.window.hidden = YES;
        [[UkeAlertSingleton sharedInstance] destoryUkeAlertSingleton];
        if (completion) completion();
    }
}

- (void)ukeRemoveAlertConrollerWithIdentifier:(NSString *)identifier
                                     animated:(BOOL)animated
                                   completion:(nullable void (^)(void))completion {
    if (_currentPrentedVc && [_currentPrentedVc.identifier isEqualToString:identifier]) {
        [_currentPrentedVc uke_dismissWithAnimated:animated completion:completion];
    }else {
        [self removeEqualVcFromStackWithIdentifier:identifier];
    }
}

#pragma mark - pop消失回调
//! 注意：只有调用uke_dismissWithAnimated:方法才会有下面两个回调，
//! 而调用系统的dismissViewControllerAnimated:不会有下面的回调
- (void)ukePopUpViewControllerWillDismiss:(UkePopUpViewController *)popUpViewController {
    self.isAnimating = YES;
    
    [self.alertHierarchStack removeObject:popUpViewController];
    [self removeEqualVcFromStackWithIdentifier:popUpViewController.identifier];
}

- (void)ukePopUpViewControllerDidDismiss {
    self.currentPrentedVc = nil;
    self.isAnimating = NO;
    
    if (self.alertHierarchStack.count == 0) {
        [self log];

        self.window.rootViewController = nil;
        self.window.hidden = YES;
        [[UkeAlertSingleton sharedInstance] destoryUkeAlertSingleton];
    }else {
        UkePopUpViewController *previousVc = _alertHierarchStack.lastObject;
        [self uke_presentPopUpViewController:previousVc animated:YES completion:^{}];
    }
}

#pragma mark - Private.
// 继续跳转到之前将要跳转的alertController
- (void)checkToPresentPendingPopUpController {
    if (_pendingAlertControllers.count == 0) {
        return;
    }
    
    UkePendingPopUpModel *pendingPopUpModel = _pendingAlertControllers.firstObject;
    [self uke_presentPopUpViewController:pendingPopUpModel.popController animated:pendingPopUpModel.animated completion:^{
        [self.pendingAlertControllers removeObject:pendingPopUpModel];
        if (pendingPopUpModel.completion) pendingPopUpModel.completion();
        
        [self log];
    }];
}

// 移除alertHierarchStack里相同identifier的alertController
- (void)removeEqualVcFromStackWithIdentifier:(NSString *)identifier {
    if (self.alertHierarchStack.count != 0) {
        for (NSInteger i = self.alertHierarchStack.count-1; i >= 0; i --) {
            UkePopUpViewController *popUpVc = self.alertHierarchStack[i];
            if ([popUpVc.identifier isEqualToString:identifier]) {
                [self.alertHierarchStack removeObject:popUpVc];
            }
        }
    }
}

- (void)logStack {
    NSLog(@">>> stack: %@", self.alertHierarchStack);
}

- (void)logPending {
    NSLog(@">>> pending: %@\n\n", self.pendingAlertControllers);
}

- (void)log {
    [self logStack];
    [self logPending];
}

- (void)dealloc {
    self.window = nil;
    NSLog(@"UkeAlertPresentingViewController 销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end


@implementation UkePendingPopUpModel
@end
