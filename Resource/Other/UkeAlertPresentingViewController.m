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

//typedef NS_ENUM(NSInteger, UkeAlertControllerPresentingState) {
//    UkeAlertControllerPresentingStatePresenting = 0,
//    UkeAlertControllerPresentingStatePresented,
//    UkeAlertControllerPresentingStateNeedPresent,
//    UkeAlertControllerPresentingStateInitial = UkeAlertControllerPresentingStatePresented
//};

@interface UkeAlertPresentingViewController ()
@property (nonatomic, strong) UIWindow *window;

@property (atomic, assign) BOOL isPresenting;
@property (nonatomic, strong) UkePopUpViewController *currentPrentedVc;
// 已经弹出过的alertController，用于当前alertController消失后可以再弹出之前的alertController
@property (nonatomic, strong) NSMutableArray<UkePopUpViewController *> *alertHierarchStack;
// 需要弹出的alertController信息，用于解决同一时间弹出多个alertController时，由于第一个还未弹出完毕，导致后面的无法弹出的问题
@property (nonatomic, strong) NSMutableArray<UkePendingPopUpModel *> *pendingAlertControllers;
@end

@implementation UkeAlertPresentingViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIWindow *window = [[UIWindow alloc] init];
        window.backgroundColor = [UIColor clearColor];
        window.frame = [UIScreen mainScreen].bounds;
        window.windowLevel = UIWindowLevelAlert;
        _window = window;
        
        _isPresenting = NO;
        _alertHierarchStack = [NSMutableArray array];
        _pendingAlertControllers = [NSMutableArray array];
    }
    return self;
}

- (void)presentPopUpViewController:(UkePopUpViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                        completion:(void (^)(void))completion {
    if (self.window.isHidden) {
        self.window.rootViewController = self;
        self.window.hidden = NO;
        [self.window makeKeyAndVisible];
    }
    
    if (_isPresenting == YES) {
        UkePendingPopUpModel *model = [[UkePendingPopUpModel alloc] init];
        model.popController = viewControllerToPresent;
        model.animated = flag;
        model.completion = completion;
        [_pendingAlertControllers addObject:model];
        return;
    }
    
    _isPresenting = YES;
    if (_currentPrentedVc) {
        [_currentPrentedVc dismissViewControllerAnimated:NO completion:^{
            [self removeEqualVcFromStackWithIdentifier:viewControllerToPresent.identifier];
            [self presentViewController:viewControllerToPresent animated:flag completion:^{
                self.currentPrentedVc = viewControllerToPresent;
                [self.alertHierarchStack addObject:self.currentPrentedVc];
                self.isPresenting = NO;
                [self presentToPendingPopUpControllerWhenCurrentPresentedCompletion:viewControllerToPresent];
                if (completion) {
                    completion();
                }
            }];
        }];
    }else {
        [self removeEqualVcFromStackWithIdentifier:viewControllerToPresent.identifier];
        [self presentViewController:viewControllerToPresent animated:flag completion:^{
            self.currentPrentedVc = viewControllerToPresent;
            [self.alertHierarchStack addObject:self.currentPrentedVc];
            self.isPresenting = NO;
            [self presentToPendingPopUpControllerWhenCurrentPresentedCompletion:viewControllerToPresent];
            if (completion) {
                completion();
            }
        }];
    }
}

- (void)presentToPendingPopUpControllerWhenCurrentPresentedCompletion:(UkePopUpViewController *)currentPresentedPopUpVc {
    if (_pendingAlertControllers.count == 0) {
        return;
    }
    
    for (int i = 0; i < _pendingAlertControllers.count; i ++) {
        UkePendingPopUpModel *lastPendingModel = _pendingAlertControllers[i];
        UkePopUpViewController *lastPendingVc = lastPendingModel.popController;
        if (lastPendingVc == currentPresentedPopUpVc) {
            [_pendingAlertControllers removeObject:lastPendingModel];
            break;
        }
    }
    if (_pendingAlertControllers.count == 0) {
        return;
    }
    
    UkePendingPopUpModel *pendingPopUpModel = _pendingAlertControllers.firstObject;
    [self presentPopUpViewController:pendingPopUpModel.popController animated:pendingPopUpModel.animated completion:pendingPopUpModel.completion];
}

#pragma mark - pop消失回调
//! 注意：只有调用dismissWithAnimated:方法才会有下面两个回调，
//! 而调用系统的dismissViewControllerAnimated:不会有下面的回调
- (void)ukePopUpViewControllerWillDismiss:(UkePopUpViewController *)popUpViewController {
    [_alertHierarchStack removeObject:popUpViewController];
}
- (void)ukePopUpViewControllerDidDismiss {
    _currentPrentedVc = nil;
    
    if (_alertHierarchStack.count == 0) {
        self.window.rootViewController = nil;
        self.window.hidden = YES;
        [[UkeAlertSingleton sharedInstance] destoryUkeAlertSingleton];
    }else {
        UkePopUpViewController *previousVc = _alertHierarchStack.lastObject;
        [self presentViewController:previousVc animated:YES completion:^{
            self.currentPrentedVc = previousVc;
        }];
    }
}

- (void)ukeRemoveAllAlertConrollerAnimated:(BOOL)animated
                                completion:(nullable void (^)(void))completion {
    if (_currentPrentedVc) {
        [self.alertHierarchStack removeAllObjects];
        [_currentPrentedVc dismissWithAnimated:animated completion:^{
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
        [_currentPrentedVc dismissWithAnimated:animated completion:completion];
    }else {
        [self removeEqualVcFromStackWithIdentifier:identifier];
    }
}

// 如果之前存在相同的popUpVc，则移除掉
- (void)removeEqualVcFromStackWithIdentifier:(NSString *)identifier {
    if (self.alertHierarchStack.count != 0) {
        for (NSInteger i = self.alertHierarchStack.count-1; i >= 0; i --) {
            UkePopUpViewController *popUpVc = self.alertHierarchStack[i];
            if ([popUpVc.identifier isEqualToString:identifier]) {
                [self.alertHierarchStack removeObject:popUpVc];
                break;
            }
        }
    }
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
