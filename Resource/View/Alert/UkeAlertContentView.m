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
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UIScrollView *actionScrollview;

@property (nonatomic, strong) UkeAlertHeaderView *headerView;
@property (nonatomic, strong) UkeAlertActionGroupView *actionGroupView;
@end

@implementation UkeAlertContentView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.separatorHeight = 1.0/[UIScreen mainScreen].scale;
        self.separatorColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
        
        self.backContentView = [[UIView alloc] init];
        self.backContentView.backgroundColor = [UIColor whiteColor];
        self.backContentView.layer.masksToBounds = YES;
        [self addSubview:self.backContentView];
        
        self.headerScrollView = [[UIScrollView alloc] init];
        [self.backContentView addSubview:self.headerScrollView];
        
        self.separatorView = [[UIView alloc] init];
        [self.backContentView addSubview:self.separatorView];
        
        self.actionScrollview = [[UIScrollView alloc] init];
        [self.backContentView addSubview:self.actionScrollview];
        
        // layout
        [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.offset(0);
        }];
        
        // 添加scrollView的默认占位内容
        UIView *defaultHeader = [[UIView alloc] init];
        [self.headerScrollView addSubview:defaultHeader];
        [defaultHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.height.mas_equalTo(0);
        }];
        
        UIView *defaultActionView = [[UIView alloc] init];
        [self.actionScrollview addSubview:defaultActionView];
        [defaultActionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.height.mas_equalTo(0);
        }];
        
        
        
        [self.headerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.offset(0);
            make.width.mas_equalTo(defaultHeader.mas_width);
            make.height.mas_equalTo(defaultHeader.mas_height);
        }];
        
        [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.mas_equalTo(self.headerScrollView.mas_bottom);
            make.height.mas_equalTo(0);
        }];

        [self.actionScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.separatorView.mas_bottom);
            make.left.right.bottom.offset(0);
            make.width.mas_equalTo(defaultActionView.mas_width);
            make.height.mas_equalTo(defaultActionView.mas_height);
        }];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.backContentView.layer.cornerRadius = _cornerRadius;
        
        if (self.headerView) {
            [self.headerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(self.headerView.mas_width);
                make.height.mas_lessThanOrEqualTo([self headerViewMaximumHeight]).priority(750);
                make.height.mas_equalTo(self.headerView.mas_height).priority(500);
            }];
        }
        
        if (self.actionGroupView) {
            self.separatorView.backgroundColor = self.separatorColor;
            [self.separatorView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.separatorHeight);
            }];
            
            [self.actionScrollview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(self.actionGroupView.mas_width);
                make.height.mas_equalTo(self.actionGroupView.mas_height).priority(250);
            }];
        }
    }
}

- (void)insertHeaderView:(nullable UIView *)headerView {
    if (!headerView) return;
    
    self.headerView = (UkeAlertHeaderView *)headerView;
    
    if (self.headerScrollView.subviews.count) {
        UIView *oldView = self.headerScrollView.subviews.lastObject;
        [oldView removeFromSuperview];
    }
    
    [self.headerScrollView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)insertActionGroupView:(nullable UIView *)actionGroupView {
    if (!actionGroupView) return;
    
    self.actionGroupView = (UkeAlertActionGroupView *)actionGroupView;
    
    if (self.actionScrollview.subviews.count) {
        UIView *oldView = self.actionScrollview.subviews.lastObject;
        [oldView removeFromSuperview];
    }
    
    [self.actionScrollview addSubview:actionGroupView];
    [actionGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)deviceOrientationWillChangeWithContentMaximumHeight:(CGFloat)contentMaximumHeight
                                                   duration:(NSTimeInterval)duration {
    _contentMaximumHeight = contentMaximumHeight;
    
    if (self.headerView) {
        [self.headerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_lessThanOrEqualTo([self headerViewMaximumHeight]).priority(750);
            make.height.mas_equalTo(self.headerView.mas_height).priority(500);
        }];
    }
    
    if (self.actionGroupView) {
        [self.actionScrollview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.actionGroupView.mas_height).priority(250);
        }];
    }
}

#pragma mark - Override.
- (CGFloat)headerViewMaximumHeight {
    if (self.actionGroupView && self.actionGroupView.actions.count) {
        if (self.actionGroupView.actions.count <= 2) {
            // alert中1个按钮和2个按钮都是只占一行的高度
            return self.contentMaximumHeight-self.separatorHeight-(1*self.actionGroupView.actionButtonHeight);
        }else {
            // 露出1.5个按钮
            // 多露出0.5个按钮，不然用户以为按钮区域不能滚动
            return self.contentMaximumHeight-self.separatorHeight-1.5*self.actionGroupView.actionButtonHeight-1*self.actionGroupView.lineHeight;
        }
    }else {
        return self.contentMaximumHeight;
    }
    return 0;
}

@end
