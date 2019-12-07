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
@property (nonatomic, strong) NSMutableArray<UkePopUpViewController *> *alertedStack;
// 将要弹出的UkePopUpViewController，来不及弹出的UkePopUpViewController都会被放在这个数组里
@property (nonatomic, strong) NSMutableArray<UkePendingPopUpModel *> *pendingStack;
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
        self.alertedStack = [NSMutableArray array];
        self.pendingStack = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Public
- (void)uke_presentPopUpViewController:(UkePopUpViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                        completion:(void (^)(void))completion {
    
    __weak typeof(self) weakSelf = self;
    if (self.window.isHidden == YES) {
        self.window.rootViewController = weakSelf;
        self.window.hidden = NO;
    }
    
    if (self.isAnimating == YES) { // 如果正在进行跳转/消失动画，移入pending中
        UkePendingPopUpModel *model = [[UkePendingPopUpModel alloc] init];
        model.popController = viewControllerToPresent;
        model.animated = flag;
        model.completion = completion;
        if (viewControllerToPresent.showPriority == UkePopUpControllerPriorityDefault) {
            [self insertToPendingWith:model atIndex:0];
        } else {
            [self addToPendingWith:model];
        }
        return;
    }
    
    if (self.currentPrentedVc) { // 当前屏幕上有正在显示的alert
        if ([self.currentPrentedVc.identifier isEqualToString:viewControllerToPresent.identifier]) {
            if (completion) completion();
            
            return;
        }
        
        if (viewControllerToPresent.showPriority == UkePopUpControllerPriorityDefault) { // 暂时隐藏旧的，弹出新的
            self.isAnimating = YES;
            // 注意：这里不能调用uke_dismiss方法，因为这会触发下面"pop消失回调"的那两个方法。
            [self.currentPrentedVc dismissViewControllerAnimated:NO completion:^{
                self.isAnimating = NO;
                self.currentPrentedVc = nil;
                [self uke_presentPopUpViewController:viewControllerToPresent animated:flag completion:completion];
            }];
        } else if (viewControllerToPresent.showPriority == UkePopUpControllerPriorityLow) { // 旧的不隐藏，新的暂存
            [self insertToStackWith:viewControllerToPresent atIndex:0];
        }
    } else { // 当前没有正在显示的alert
        self.isAnimating = YES;
        // 注意：这里不能调用uke_presentPopUpViewController方法，否则会进入死循环。
        [self presentViewController:viewControllerToPresent animated:flag completion:^{
            [self addToStackWith:viewControllerToPresent];
            
            self.currentPrentedVc = viewControllerToPresent;
            self.isAnimating = NO;
            
            if (completion) completion();
            
            [self checkToPresentPendingPopUpController];
        }];
    }
}

- (BOOL)ukeIsUkeAlertControllerCurrentShowed {
    return (self.currentPrentedVc != nil);
}

- (void)ukeRemoveAllAlertConrollerAnimated:(BOOL)animated
                                completion:(nullable void (^)(void))completion {
    if (self.currentPrentedVc) {
        [self.alertedStack removeAllObjects];
        [self.currentPrentedVc uke_dismissWithAnimated:animated completion:^{
            if (completion) completion();
        }];
    }else {
        self.window.rootViewController = nil;
        self.window.hidden = YES;
        [[UkeAlertSingleton sharedInstance] destoryUkeAlertSingleton];
        if (completion) completion();
    }
}

- (void)ukeRemoveAlertConrollerWithIdentifier:(NSString *)identifier
                                     animated:(BOOL)animated
                                   completion:(nullable void (^)(void))completion {
    if (self.currentPrentedVc && [self.currentPrentedVc.identifier isEqualToString:identifier]) {
        [self.currentPrentedVc uke_dismissWithAnimated:animated completion:completion];
    }else {
        [self removeEqualVcFromStackWithIdentifier:identifier];
        
        if (completion) completion();
    }
}

#pragma mark - pop消失回调
//! 注意：只有调用uke_dismissWithAnimated:方法才会有下面两个回调，
//! 而调用系统的dismissViewControllerAnimated:不会有下面的回调
- (void)ukePopUpViewControllerWillDismiss:(UkePopUpViewController *)popUpViewController {
    self.isAnimating = YES;
    
    [self.alertedStack removeObject:popUpViewController];
}

- (void)ukePopUpViewControllerDidDismiss {
    self.currentPrentedVc = nil;
    self.isAnimating = NO;
    
    if (self.alertedStack.count == 0) {
        self.window.rootViewController = nil;
        self.window.hidden = YES;
        [[UkeAlertSingleton sharedInstance] destoryUkeAlertSingleton];
    }else {
        UkePopUpViewController *previousVc = self.alertedStack.lastObject;
        
        // 这里的completon不能再回调回去了，否则会重复
        // 优化：这个animated不应该写死，最好在alertedStack里也存储UkePopUpModel
        [self uke_presentPopUpViewController:previousVc animated:YES completion:^{}];
    }
}

#pragma mark - Private.
// 继续跳转到之前将要跳转的alertController
- (void)checkToPresentPendingPopUpController {
    if (self.pendingStack.count == 0) {
        return;
    }
    
    UkePendingPopUpModel *pendingPopUpModel = self.pendingStack.firstObject;
    [self uke_presentPopUpViewController:pendingPopUpModel.popController animated:pendingPopUpModel.animated completion:^{
        [self.pendingStack removeObject:pendingPopUpModel];
        
        if (pendingPopUpModel.completion) pendingPopUpModel.completion();
    }];
}

// 移除alertedStack里相同identifier的alertController
- (void)removeEqualVcFromStackWithIdentifier:(NSString *)identifier {
    for (NSInteger i = self.alertedStack.count-1; i >= 0; i --) {
        UkePopUpViewController *popUpVc = self.alertedStack[i];
        if ([popUpVc.identifier isEqualToString:identifier]) {
            [self.alertedStack removeObject:popUpVc];
        }
    }
}

- (void)addToStackWith:(UkePopUpViewController *)popUpViewController {
    if ([self.alertedStack containsObject:popUpViewController]) {
        [self removeEqualVcFromStackWithIdentifier:popUpViewController.identifier];
    }
    [self.alertedStack addObject:popUpViewController];
}

- (void)insertToStackWith:(UkePopUpViewController *)popUpViewController atIndex:(NSUInteger)index {
    if ([self.alertedStack containsObject:popUpViewController]) {
        [self removeEqualVcFromStackWithIdentifier:popUpViewController.identifier];
    }
    [self.alertedStack insertObject:popUpViewController atIndex:index];
}

- (void)addToPendingWith:(UkePendingPopUpModel *)popUpModel {
    if ([self.pendingStack containsObject:popUpModel]) {
        return;
    }
    [self.pendingStack addObject:popUpModel];
}

- (void)insertToPendingWith:(UkePendingPopUpModel *)popUpModel atIndex:(NSUInteger)index {
    if ([self.pendingStack containsObject:popUpModel]) {
        return;
    }
    [self.pendingStack insertObject:popUpModel atIndex:index];
}

- (void)logStack {
    NSLog(@">>> stack: %@", self.alertedStack);
}

- (void)logPending {
    NSLog(@">>> pending: %@\n\n", self.pendingStack);
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

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        UkePendingPopUpModel *popUpModel = (UkePendingPopUpModel *)object;        
        return [self.popController.identifier isEqualToString:popUpModel.popController.identifier];
    }
    return NO;
}

- (NSUInteger)hash {
    return self.popController.identifier.hash;
}

@end
