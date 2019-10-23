//
//  UkeAlertAction.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/18.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertAction.h"

@interface UkeAlertAction ()
@property (nullable, nonatomic) NSString *title;
@property (nonatomic, assign) UIAlertActionStyle style;
@property (nonatomic, strong) void(^actionHandler)(UkeAlertAction *action);
@end

@implementation UkeAlertAction

+ (instancetype)actionWithTitle:(NSString *)title
                              style:(UIAlertActionStyle)style
                            handler:(void (^)(UkeAlertAction * _Nonnull))handler {
    UkeAlertAction *action = [[UkeAlertAction alloc] init];
    action.title = title;
    action.style = style;
    action.actionHandler = handler;
    action.enabled = YES;
    action.shouldAutoDismissAlertController = YES;
    action.actionButton = nil;
    return action;
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    if (self.actionButton) {
        self.actionButton.enabled = enabled;
    }
}

@end
