//
//  UkeAlertContentView.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertContentView.h"
#import "Masonry.h"

@interface UkeAlertContentView ()
@property (nonatomic, strong) UIScrollView *headerScrollView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIScrollView *actionScrollview;
@end

@implementation UkeAlertContentView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 12.0;
        self.layer.masksToBounds = YES;
        
        self.headerScrollView = [[UIScrollView alloc] init];
        [self addSubview:self.headerScrollView];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [self addSubview:self.lineView];
        
        self.actionScrollview = [[UIScrollView alloc] init];
        [self addSubview:self.actionScrollview];
        
        [self.headerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.offset(0);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.mas_equalTo(1.0);
            make.top.mas_equalTo(self.headerScrollView.mas_bottom);
        }];
        [self.actionScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lineView.mas_bottom);
            make.left.right.bottom.offset(0);
        }];
        
        UIView *defaultHeader = [[UIView alloc] init];
        [self.headerScrollView addSubview:defaultHeader];
        [defaultHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.height.mas_equalTo(0);
            make.height.mas_equalTo(self.headerScrollView.mas_height);
        }];
        
        UIView *defaultActionView = [[UIView alloc] init];
        [self.actionScrollview addSubview:defaultActionView];
        [defaultActionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.height.mas_equalTo(0);
            make.height.mas_equalTo(self.actionScrollview.mas_height);
        }];
    }
    return self;
}

- (void)insertHeaderView:(UIView *)headerView {
    if (!headerView) return;
    
    if (self.headerScrollView.subviews.count) {
        UIView *oldView = self.headerScrollView.subviews.firstObject;
        [oldView removeFromSuperview];
    }
    
    [self.headerScrollView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.height.mas_equalTo(self.headerScrollView.mas_height);
    }];
}

- (void)insertActionView:(UIView *)actionView {
    if (!actionView) return;
    
    if (self.actionScrollview.subviews.count) {
        UIView *oldView = self.actionScrollview.subviews.firstObject;
        [oldView removeFromSuperview];
    }
    
    [self.actionScrollview addSubview:actionView];
    [actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.height.mas_equalTo(self.actionScrollview.mas_height);
    }];
}

@end
