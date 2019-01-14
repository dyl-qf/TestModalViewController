//
//  UkeAlertPresentingViewController.m
//  TestModalViewController
//
//  Created by liqian on 2019/1/14.
//  Copyright © 2019 liqian. All rights reserved.
//

#import "UkeAlertPresentingViewController.h"

@interface UkeAlertPresentingViewController ()
@property (nonatomic, strong) UIWindow *window;
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
    }
    return self;
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    self.window.rootViewController = self;
    self.window.hidden = NO;
    [self.window makeKeyAndVisible];
    
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)alertControllerDidDismiss {
    self.window.rootViewController = nil;
    self.window.hidden = YES;
}

- (void)dealloc {
    self.window = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
