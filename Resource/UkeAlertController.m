//
//  UkeAlertController.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertController.h"
#import "UkeAlertContentView.h"
#import "UkeAlertHeaderView.h"
#import "Masonry.h"

@interface UkeAlertController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation UkeAlertController

+ (instancetype)uke_alertControllerWithTitle:(NSString *)title
                                     message:(NSString *)message
                              preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UkeAlertController *alertVc = [[UkeAlertController alloc] init];
    alertVc.preferredStyle = preferredStyle;
    UIView *contentView = [alertVc generateAlertContentViewWithTitle:title message:message preferredStyle:preferredStyle];
    [alertVc addContentView:contentView];
    return alertVc;
}

- (UkeAlertContentView *)generateAlertContentViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                               preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UkeAlertHeaderView *header = [[UkeAlertHeaderView alloc] initWithTitle:title message:message];
    
    UkeAlertContentView *content = [[UkeAlertContentView alloc] init];
    [content insertHeaderView:header];
    
    return content;
}

@end
