//
//  UkeAlertSingleton.m
//  TestModalViewController
//
//  Created by liqian on 2019/1/14.
//  Copyright © 2019 liqian. All rights reserved.
//

#import "UkeAlertSingleton.h"

@interface UkeAlertSingleton ()
@property (nonatomic, strong) UkeAlertPresentingViewController *presentingVc;
@end

@implementation UkeAlertSingleton

static UkeAlertSingleton *instance;
static dispatch_once_t onceToken;

+ (UkeAlertSingleton *)sharedInstance {
    dispatch_once(&onceToken, ^{
        instance = [[UkeAlertSingleton alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _presentingVc = [[UkeAlertPresentingViewController alloc] init];
    }
    return self;
}

- (UkeAlertPresentingViewController *)ukeAlertPresentViewController {
    return _presentingVc;
}

- (void)destoryUkeAlertSingleton {
    _presentingVc = nil;
    instance = nil;
    onceToken = 0l;
}

- (void)dealloc {
    NSLog(@"UkeAlertSingleton单例销毁");
}

@end
