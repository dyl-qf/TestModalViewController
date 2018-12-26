//
//  UkeSheetContentView.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/22.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeSheetContentView.h"
#import "UkeAlertActionButton.h"
#import "UkeAlertAction.h"
#import "Masonry.h"

@interface UkeSheetContentView ()
@property (nonatomic, strong) UkeAlertAction *cancelAction;
@property (nonatomic, strong) UIView *cancelButtonWrapperView;
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

- (void)addCancelAction:(UkeAlertAction *)action {
    self.cancelAction = action;
    
    UIView *cancelView = [[UIView alloc] init];
    cancelView.backgroundColor = [UIColor whiteColor];
    cancelView.layer.cornerRadius = 12.0;
    cancelView.layer.masksToBounds = YES;
    [self addSubview:cancelView];
    self.cancelButtonWrapperView = cancelView;
    
    UkeAlertActionButton *cancelButton = [[UkeAlertActionButton alloc] init];
    [self setAttributedTextWith:action.title forButton:cancelButton];
    [cancelButton addTarget:self action:@selector(handleCancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelView addSubview:cancelButton];
    
    
    [self.backContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-self.sheetCancelButtonMarginTop-self.cancelActionButtonHeight);
    }];
    
    [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(self.cancelActionButtonHeight);
    }];

    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - Override.
- (CGFloat)headerViewMaximumHeight {
    return self.contentMaximumHeight-100;
}

- (void)setAttributedTextWith:(NSString *)text
                    forButton:(UkeAlertActionButton *)button {
    button.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:self.cancelButtonAttributes];
}

- (void)setSheetCancelButtonMarginTop:(CGFloat)sheetCancelButtonMarginTop {
    _sheetCancelButtonMarginTop = sheetCancelButtonMarginTop;
    // 调整约束
    [self updateConstraintsIfNeeded];
}

- (void)setCancelActionButtonHeight:(CGFloat)cancelActionButtonHeight {
    _cancelActionButtonHeight = cancelActionButtonHeight;
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    if (_cancelAction) {
        [self.backContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-self.sheetCancelButtonMarginTop-self.cancelActionButtonHeight);
        }];
        [self.cancelButtonWrapperView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.cancelActionButtonHeight);
        }];
    }
    
    [super updateConstraints];
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
