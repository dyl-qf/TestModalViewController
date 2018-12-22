//
//  UkeAlertController.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/17.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertController.h"
#import "UkeAlertContentView.h"
#import "UkeSheetContentView.h"
#import "UkeAlertHeaderView.h"
#import "UkeSheetHeaderView.h"
#import "UkeAlertActionGroupView.h"
#import "UkeSheetActionGroupView.h"
#import "Masonry.h"

@interface UkeAlertController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UkeAlertContentView *contentView; //! 整个content
@property (nonatomic, strong) UkeAlertHeaderView *headerView; //! title和message
@property (nonatomic, strong) UkeAlertActionGroupView *actionGroupView; //! 按钮区域
@end

@implementation UkeAlertController
@synthesize contentWidth = _contentWidth;

+ (instancetype)alertControllerWithTitle:(NSString *)title
                                     message:(NSString *)message
                              preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UkeAlertController *alertVc = [[UkeAlertController alloc] init];
    alertVc.preferredStyle = preferredStyle;
    UIView *contentView = [alertVc generateAlertContentViewWithTitle:title message:message preferredStyle:preferredStyle];
    [alertVc addContentView:contentView];
    if (preferredStyle == UIAlertControllerStyleAlert) {
        [alertVc setContentWidth:270];
    }else if (preferredStyle == UIAlertControllerStyleActionSheet) {
        CGFloat defaultWidth = [UIScreen mainScreen].bounds.size.width-8-8;
        [alertVc setContentWidth:defaultWidth];
    }
    return alertVc;
}

- (void)addAction:(UkeAlertAction *)action {
    BOOL isSheetCancelAction = NO; // ActionSheet的cancel按钮需要特殊处理，因为这个按钮s不是添加在actionGroupView中的，而是在contentView中
    if (self.preferredStyle == UIAlertControllerStyleActionSheet && action.style == UIAlertActionStyleCancel) {
        isSheetCancelAction = YES;
    }
    
    if (!isSheetCancelAction) {
        [self.actionGroupView addAction:action];
    }
    [self.contentView insertActionGroupView:self.actionGroupView];
    
    if (isSheetCancelAction) {
        UkeSheetContentView *sheetContentView = (UkeSheetContentView *)self.contentView;
        [sheetContentView addCancelAction:action];
    }
    
    [self addContentView:self.contentView];
}

- (UkeAlertContentView *)generateAlertContentViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                               preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UkeAlertContentView *content = nil;
    UkeAlertHeaderView *header = nil;
    if (preferredStyle == UIAlertControllerStyleAlert) {
        content = [[UkeAlertContentView alloc] init];
        header = [[UkeAlertHeaderView alloc] initWithTitle:title message:message];
    }else if (preferredStyle == UIAlertControllerStyleActionSheet) {
        content = [[UkeSheetContentView alloc] init];
        header = [[UkeSheetHeaderView alloc] initWithTitle:title message:message];
    }
    
    [content insertHeaderView:header];
    
    self.headerView = header;
    self.contentView = content;
    
    return content;
}


#pragma mark - Setter.
- (void)setContentWidth:(CGFloat)contentWidth {
    [super setContentWidth:contentWidth];
}

- (void)setTitleAttributes:(NSDictionary<NSString *,id> *)titleAttributes {
    [self.headerView setTitleAttributes:titleAttributes];
}

- (void)setMessageAttributes:(NSDictionary<NSString *,id> *)messageAttributes {
    [self.headerView setMessageAttributes:messageAttributes];
}

- (void)setDefaultButtonAttributes:(NSDictionary<NSString *,id> *)defaultButtonAttributes {
    [self.actionGroupView setDefaultButtonAttributes:defaultButtonAttributes];
}

- (void)setCancelButtonAttributes:(NSDictionary<NSString *,id> *)cancelButtonAttributes {
    [self.actionGroupView setCancelButtonAttributes:cancelButtonAttributes];
}

- (void)setDestructiveButtonAttributes:(NSDictionary<NSString *,id> *)destructiveButtonAttributes {
    [self.actionGroupView setDestructiveButtonAttributes:destructiveButtonAttributes];
}

#pragma mark - Getter.
- (UkeAlertActionGroupView *)actionGroupView {
    if (!_actionGroupView) {
        if (self.preferredStyle == UIAlertControllerStyleAlert) {
            _actionGroupView = [[UkeAlertActionGroupView alloc] init];
        }else if (self.preferredStyle == UIAlertControllerStyleActionSheet) {
            _actionGroupView = [[UkeSheetActionGroupView alloc] init];
        }
        __weak typeof(self)weakSelf = self;
        _actionGroupView.dismissHandler = ^{
            [weakSelf dismiss];
        };
    }
    return _actionGroupView;
}

- (NSArray<UkeAlertAction *> *)actions {
    return self.actionGroupView.actions;
}

@end
