//
//  UkeAlertHeaderView.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertHeaderView.h"
#import "Masonry.h"

@interface UkeAlertHeaderView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation UkeAlertHeaderView

- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message {
    BOOL hasTitle = NO;
    BOOL hasMessage = NO;
    if ([title isKindOfClass:[NSString class]] && title.length) {
        hasTitle = YES;
    }
    if ([message isKindOfClass:[NSString class]] && message.length) {
        hasMessage = YES;
    }
    if (!hasTitle && !hasMessage) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        NSMutableArray *subviews = [NSMutableArray array];
        if (hasTitle) {
            _titleLabel = [[UILabel alloc] init];
            _titleLabel.numberOfLines = 0;
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.text = title;
            _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
            [self addSubview:_titleLabel];
            [subviews addObject:_titleLabel];
        }
        
        if (hasMessage) {
            _messageLabel = [[UILabel alloc] init];
            _messageLabel.numberOfLines = 0;
            _messageLabel.textAlignment = NSTextAlignmentCenter;
            _messageLabel.text = message;
            _messageLabel.font = [UIFont systemFontOfSize:16];
            [self addSubview:_messageLabel];
            [subviews addObject:_messageLabel];
        }
        
        [self layoutTitleAndMessage:subviews.copy];
    }
    return self;
}

- (void)layoutTitleAndMessage:(NSArray *)subviews {
    UIView *firstView = subviews.firstObject;
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.top.offset(24);
        if (subviews.count == 1) {
            make.bottom.offset(-24);
        }
    }];
    
    if (subviews.count == 2) {
        UIView *secondView = subviews.firstObject;
        [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(40);
            make.right.offset(-40);
            make.top.mas_equalTo(firstView.mas_bottom).offset(24);
            make.bottom.offset(-30);
        }];
    }
    [self layoutIfNeeded];
}

@end
