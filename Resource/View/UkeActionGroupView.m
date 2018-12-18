//
//  UkeActionGroupView.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/18.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeActionGroupView.h"
#import "Masonry.h"
#import "UkeAlertAction.h"

@interface UkeActionGroupView ()
@property (nonatomic, strong) NSArray<UkeAlertAction *> *actions;
@property (nonatomic, strong) NSArray<UkeAlertAction *> *defaultActions;
@property (nonatomic, strong) NSArray<UkeAlertAction *> *cancelActions;
@property (nonatomic, strong) NSArray<UkeAlertAction *> *destructiveActions;
@end

#define UkeAlertActionButtonHeight 44.0

@implementation UkeActionGroupView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        
        self.actions = [NSArray array];
        
    }
    return self;
}

- (void)addAction:(UkeAlertAction *)action {
    NSMutableArray *actions = self.actions.mutableCopy;
    [actions addObject:action];
    self.actions = actions.copy;
    [self layoutActions];
}

- (void)layoutActions {
    [self removeAllSubviews];
    
    if (self.actions.count == 2) {
        [self layoutForTwoActions];
        return;
    }
    
    
}

- (void)layoutForTwoActions {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.mas_equalTo(1);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    for (int i = 0; i < 2; i ++) {
        UkeAlertAction *action = self.actions[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:action.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:button];
    
        if (i == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.offset(0);
                make.right.mas_equalTo(lineView.mas_left);
                make.height.mas_equalTo(UkeAlertActionButtonHeight);
            }];
        }else if (i == 1) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.offset(0);
                make.left.mas_equalTo(lineView.mas_right);
                make.height.mas_equalTo(UkeAlertActionButtonHeight);
            }];
        }
    }
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

@end
