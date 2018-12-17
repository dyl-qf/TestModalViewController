//
//  UkeAlertController.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertController.h"

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

- (UIView *)generateAlertContentViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                               preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, 0, 285, 100);
    
    if ([title isKindOfClass:[NSString class]] && title.length) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = title;
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [contentView addSubview:_titleLabel];
    }
    
    if ([message isKindOfClass:[NSString class]] && message.length) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.text = message;
        _messageLabel.font = [UIFont systemFontOfSize:15];
        [contentView addSubview:_messageLabel];
    }
    
    _titleLabel.frame = CGRectMake(0, 20, 285, 20);
    _messageLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+20, 285, 30);
    
    return contentView;
}

@end
