//
//  UkeSheetContentView.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/22.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeSheetContentView.h"
#import "UkeSheetHeaderView.h"
#import "UkeSheetActionGroupView.h"
#import "UkeAlertActionButton.h"
#import "UkeAlertAction.h"
#import "Masonry.h"

@interface UkeSheetContentView ()
@property (nonatomic, strong) UkeAlertAction *cancelAction;
@property (nonatomic, strong) UIView *cancelButtonWrapperView;

@property (nonatomic, strong) UkeSheetHeaderView *headerView;
@property (nonatomic, strong) UkeSheetActionGroupView *actionGroupView;
@end

@implementation UkeSheetContentView

- (instancetype)init {
    self = [super init];
    if (self) {
        _sheetCancelButtonMarginTop = 8.0;
        _cancelActionButtonHeight = 57.0;
        _cancelButtonAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:45/255.0 green:139/255.0 blue:245/255.0 alpha:1.0],
                                        NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size:20]                             };
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.cancelButtonWrapperView.layer.cornerRadius = self.cornerRadius;
        
        if (self.cancelButtonWrapperView) {
            [self.backContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.offset(-self.sheetCancelButtonMarginTop-self.cancelActionButtonHeight);
            }];
            
            [self.cancelButtonWrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.offset(0);
                make.height.mas_equalTo(self.cancelActionButtonHeight);
            }];
        }
    }
}

- (void)insertHeaderView:(UIView *)headerView {
    self.headerView = (UkeSheetHeaderView *)headerView;
    [super insertHeaderView:headerView];
}

- (void)insertActionGroupView:(UIView *)actionGroupView {
    self.actionGroupView = (UkeSheetActionGroupView *)actionGroupView;
    [super insertActionGroupView:actionGroupView];
}


- (void)addCancelAction:(UkeAlertAction *)action {
    if (!action) return;
    self.cancelAction = action;

    UIView *cancelView = [[UIView alloc] init];
    cancelView.backgroundColor = [UIColor whiteColor];
    cancelView.layer.masksToBounds = YES;
    [self addSubview:cancelView];

    UkeAlertActionButton *cancelButton = [[UkeAlertActionButton alloc] init];
    cancelButton.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.cancelAction.title attributes:self.cancelButtonAttributes];
    [cancelButton addTarget:self action:@selector(handleCancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    self.cancelButtonWrapperView = cancelView;
}

#pragma mark - Override.
- (CGFloat)headerViewMaximumHeight {
    if (self.actionGroupView && self.actionGroupView.actions.count) {
        CGFloat cancelAreaTotalHeight = 0;
        if (self.cancelAction) {
            cancelAreaTotalHeight = self.cancelActionButtonHeight+self.sheetCancelButtonMarginTop;
        }
        
        NSUInteger count = self.actionGroupView.actions.count;
        if (count <= 2) {
            return self.contentMaximumHeight-count*self.actionGroupView.actionButtonHeight-cancelAreaTotalHeight-count*self.actionGroupView.lineHeight;
        }else {
            // 多露出0.5个按钮，不然用户以为按钮区域不能滚动
            return self.contentMaximumHeight-2.5*self.actionGroupView.actionButtonHeight-cancelAreaTotalHeight-3*self.actionGroupView.lineHeight;
        }
    }else {
        return self.contentMaximumHeight;
    }
    return 0;
}

- (void)handleCancelButtonAction:(UIButton *)button {
    if (self.cancelAction.actionHandler) {
        self.cancelAction.actionHandler(self.cancelAction);
    }

    if (self.dismissHandler) {
        self.dismissHandler();
    }
}

@end
