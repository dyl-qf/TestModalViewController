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
@property (nonatomic, strong) UIView *backContentView;
@property (nonatomic, strong) UIScrollView *headerScrollView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIScrollView *actionScrollview;
@end

@implementation UkeAlertContentView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backContentView = [[UIView alloc] init];
        self.backContentView.backgroundColor = [UIColor whiteColor];
        self.backContentView.layer.cornerRadius = 12.0;
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
            CGFloat maxmumHeight = [UIScreen mainScreen].bounds.size.height-24-24;
//            UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//            if (orientation == UIInterfaceOrientationLandscapeLeft ||
//                orientation == UIInterfaceOrientationLandscapeRight) {
//
//            }
            make.height.mas_lessThanOrEqualTo(maxmumHeight);
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

- (void)insertHeaderView:(UIView *)headerView {
    if (!headerView) return;
    
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
//        make.height.mas_lessThanOrEqualTo(200);
        [self.headerScrollView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        make.height.mas_greaterThanOrEqualTo(100);
        make.height.mas_equalTo(headerView.mas_height).priority(500);
    }];
}

- (void)insertActionGroupView:(UIView *)actionGroupView {
    if (!actionGroupView) return;
    
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
//        make.height.mas_lessThanOrEqualTo(300);
        make.height.mas_equalTo(actionGroupView.mas_height).priority(500);
    }];
}

@end
