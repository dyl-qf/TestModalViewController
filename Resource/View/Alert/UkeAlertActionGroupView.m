//
//  UkeAlertActionGroupView.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/18.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertActionGroupView.h"
#import "Masonry.h"
#import "UkeAlertActionButton.h"
#import "UkeAlertAction.h"

@interface UkeAlertActionGroupView ()
@property (nonatomic, strong) NSArray<UkeAlertAction *> *actions;
@property (nonatomic, strong) UIView *actionGroupArea;
@end

@implementation UkeAlertActionGroupView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.actions = [NSArray array];
        
        _actionButtonHeight = 44.0;
        _lineHeight = 1.0;
        
        _defaultButtonAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:45/255.0 green:139/255.0 blue:245/255.0 alpha:1.0],
                                         NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:17]                             };
        _cancelButtonAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:45/255.0 green:139/255.0 blue:245/255.0 alpha:1.0],
                                        NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size:17]                             };
        _destructiveButtonAttributes = @{NSForegroundColorAttributeName: [UIColor redColor],
                                             NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:17]                             };
    }
    return self;
}

- (void)addAction:(UkeAlertAction *)action {
    NSMutableArray *actions = self.actions.mutableCopy;
    [actions addObject:action];
    self.actions = actions.copy;
}

- (BOOL)layoutActions {
    if (self.actions.count == 0) {
        return NO;
    }
    [self removeAllSubviews];
    
    // 添加横线
    UIView *horizontalLineView = [[UIView alloc] init];
    horizontalLineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self addSubview:horizontalLineView];
    [horizontalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(self.lineHeight);
    }];
    // 添加按钮区域
    _actionGroupArea = [[UIView alloc] init];
    [self addSubview:_actionGroupArea];
    [_actionGroupArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(horizontalLineView.mas_bottom);
        make.left.bottom.right.offset(0);
    }];
    
    if (self.actions.count == 2 && [self isMemberOfClass:[UkeAlertActionGroupView class]]) {
        [self layoutForTwoActions];
    }else {
        [self layoutForNotTwoActions];
    }
    return YES;
}

- (void)layoutForTwoActions {
    UIView *verticalLineView = [[UIView alloc] init];
    verticalLineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [_actionGroupArea addSubview:verticalLineView];
    [verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.mas_equalTo(self.lineHeight);
        make.centerX.mas_equalTo(self.actionGroupArea.mas_centerX);
    }];
    
    for (int i = 0; i < 2; i ++) {
        UkeAlertAction *action = self.actions[i];
        UkeAlertActionButton *button = [[UkeAlertActionButton alloc] init];
        button.tag = i;
        [self setAttributedTextWith:action.title forButton:button style:action.style];
        [button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_actionGroupArea addSubview:button];
    
        if (i == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.offset(0);
                make.right.mas_equalTo(verticalLineView.mas_left);
                make.height.mas_equalTo(self.actionButtonHeight);
            }];
        }else if (i == 1) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.offset(0);
                make.left.mas_equalTo(verticalLineView.mas_right);
                make.height.mas_equalTo(self.actionButtonHeight);
            }];
        }
    }
}

- (void)layoutForNotTwoActions {
    NSMutableArray *lines = [NSMutableArray array];
    [self.actions enumerateObjectsUsingBlock:^(UkeAlertAction *action, NSUInteger idx, BOOL * _Nonnull stop) {
        UkeAlertActionButton *button = [[UkeAlertActionButton alloc] init];
        button.tag = idx;
        [self setAttributedTextWith:action.title forButton:button style:action.style];
        [button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.actionGroupArea addSubview:button];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [self.actionGroupArea addSubview:lineView];
        [lines addObject:lineView];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.mas_equalTo(self.actionButtonHeight);
            if (idx == 0) {
                make.top.offset(0);
            }else {
                UIView *lastLine = lines[idx-1];
                make.top.mas_equalTo(lastLine.mas_bottom);
            }
            
            if (idx == self.actions.count-1) {
                make.bottom.offset(0);
            }
        }];
        
        if (idx != self.actions.count-1) {
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.offset(0);
                make.height.mas_equalTo(self.lineHeight);
                make.top.mas_equalTo(button.mas_bottom);
            }];
        }
    }];
}

- (void)handleButtonAction:(UIButton *)button {
    if (self.ukeActionButtonHandler) {
        UkeAlertAction *action = self.actions[button.tag];
        self.ukeActionButtonHandler(action);
    }
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (void)setAttributedTextWith:(NSString *)text
            forButton:(UkeAlertActionButton *)button
                style:(UIAlertActionStyle)style {
    if (style == UIAlertActionStyleDefault) {
        button.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:_defaultButtonAttributes];
    }else if (style == UIAlertActionStyleCancel) {
        button.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:_cancelButtonAttributes];
    }else if (style == UIAlertActionStyleDestructive) {
        button.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:_destructiveButtonAttributes];
    }
}

@end
