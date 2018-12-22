//
//  UkeSheetContentView.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/22.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeSheetContentView.h"
#import "UkeSheetActionGroupView.h"
#import "UkeAlertActionButton.h"
#import "UkeAlertAction.h"
#import "Masonry.h"

@interface UkeSheetContentView ()
@property (nonatomic, strong) UkeAlertAction *cancelAction;
@property (nonatomic, strong) UkeSheetActionGroupView *actionGroupView;
@property (nonatomic, assign) CGFloat actionButtonHeight;
@end

@implementation UkeSheetContentView

- (instancetype)init {
    self = [super init];
    if (self) {        
        self.sheetCancelButtonMarginTop = 8.0;
    }
    return self;
}

- (void)insertActionGroupView:(UIView *)actionGroupView {
    [super insertActionGroupView:actionGroupView];

    _actionGroupView = (UkeSheetActionGroupView *)actionGroupView;
    _actionButtonHeight = _actionGroupView.actionButtonHeight;
}

- (void)addCancelAction:(UkeAlertAction *)action {
    self.cancelAction = action;
    
    UIView *cancelView = [[UIView alloc] init];
    cancelView.backgroundColor = [UIColor whiteColor];
    cancelView.layer.cornerRadius = 12.0;
    cancelView.layer.masksToBounds = YES;
    [self addSubview:cancelView];
    
    UkeAlertActionButton *cancelButton = [[UkeAlertActionButton alloc] init];
    [self setAttributedTextWith:action.title forButton:cancelButton];
    [cancelButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelView addSubview:cancelButton];
    
    
    [self.backContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-self.sheetCancelButtonMarginTop-self.actionButtonHeight);
    }];
    
    [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backContentView.mas_bottom).offset(self.sheetCancelButtonMarginTop);
        make.left.right.offset(0);
        make.height.mas_equalTo(self.actionButtonHeight);
    }];

    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setAttributedTextWith:(NSString *)text
                    forButton:(UkeAlertActionButton *)button {
    button.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:self.actionGroupView.cancelButtonAttributes];
}

- (void)handleButtonAction:(UIButton *)button {
    if (self.cancelAction.actionHandler) {
        self.cancelAction.actionHandler(self.cancelAction);
    }
    
    if (self.actionGroupView.dismissHandler) {
        self.actionGroupView.dismissHandler();
    }
}

@end
