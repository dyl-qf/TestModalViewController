//
//  UkeAlertContentView.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertContentView.h"
#import "UkeAlertHeaderView.h"
#import "UkeAlertActionGroupView.h"
#import "Masonry.h"

@interface UkeAlertContentView ()
@property (nonatomic, strong) UIView *backContentView;
@property (nonatomic, strong) UIScrollView *headerScrollView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIScrollView *actionScrollview;

@property (nonatomic, strong) UkeAlertHeaderView *headerView;
@property (nonatomic, strong) UkeAlertActionGroupView *actionGroupView;
@end

@implementation UkeAlertContentView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backContentView = [[UIView alloc] init];
        self.backContentView.backgroundColor = [UIColor whiteColor];
        self.backContentView.layer.masksToBounds = YES;
        [self addSubview:self.backContentView];
        
        self.headerScrollView = [[UIScrollView alloc] init];
        [self.backContentView addSubview:self.headerScrollView];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [self.backContentView addSubview:self.lineView];
        
        self.actionScrollview = [[UIScrollView alloc] init];
        [self.backContentView addSubview:self.actionScrollview];
        
        // layout
        [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.offset(0);
        }];
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
        
        // 添加scrollView的默认占位内容
        UIView *defaultHeader = [[UIView alloc] init];
        [self.headerScrollView addSubview:defaultHeader];
        [defaultHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.height.mas_equalTo(0);
            make.width.mas_equalTo(self.headerScrollView.mas_width);
        }];
        [self.headerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(defaultHeader.mas_height);
        }];
        
        UIView *defaultActionView = [[UIView alloc] init];
        [self.actionScrollview addSubview:defaultActionView];
        [defaultActionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.height.mas_equalTo(0);
            make.width.mas_equalTo(self.actionScrollview.mas_width);
        }];
        [self.actionScrollview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(defaultActionView.mas_height);
        }];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.backContentView.layer.cornerRadius = _cornerRadius;
    }
}

- (void)insertHeaderView:(UIView *)headerView {
    if (!headerView) return;
    
    self.headerView = (UkeAlertHeaderView *)headerView;
    
    if (self.headerScrollView.subviews.count) {
        UIView *oldView = self.headerScrollView.subviews.firstObject;
        [oldView removeFromSuperview];
    }
    
    [self.headerScrollView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.mas_equalTo(self.headerScrollView.mas_width);
    }];
    
    [self.headerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_lessThanOrEqualTo([self headerViewMaximumHeight]);
        make.height.mas_equalTo(headerView.mas_height).priority(500);        
    }];
}

- (void)insertActionGroupView:(UIView *)actionGroupView {
    if (!actionGroupView) return;
    
    self.actionGroupView = (UkeAlertActionGroupView *)actionGroupView;
    
    if (self.actionScrollview.subviews.count) {
        UIView *oldView = self.actionScrollview.subviews.firstObject;
        [oldView removeFromSuperview];
    }
    
    [self.actionScrollview addSubview:actionGroupView];
    [actionGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.mas_equalTo(self.actionScrollview.mas_width);
    }];
    
    [self.actionScrollview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(actionGroupView.mas_height).priority(250);
    }];
    
    [self.headerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_lessThanOrEqualTo([self headerViewMaximumHeight]);
        make.height.mas_equalTo(self.headerView.mas_height).priority(500);
    }];
}

#pragma mark - Override.
- (CGFloat)headerViewMaximumHeight {
    if (self.actionGroupView) {
        if (self.actionGroupView.actions.count <= 2) {
            // alert中1个按钮和2个按钮都是只占一行的高度
            return self.contentMaximumHeight-1*self.actionGroupView.actionButtonHeight;
        }else {
            // 多露出0.5个按钮，不然用户以为按钮区域不能滚动
            return self.contentMaximumHeight-2.5*self.actionGroupView.actionButtonHeight;
        }
    }else {
        return self.contentMaximumHeight;
    }
    return 0;
}

#pragma mark - Setter.
- (void)setContentMaximumHeight:(CGFloat)contentMaximumHeight {
    _contentMaximumHeight = contentMaximumHeight;
    // todo...
    
}

@end
