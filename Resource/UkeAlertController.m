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
@synthesize sheetContentMarginBottom = _sheetContentMarginBottom;

+ (instancetype)alertControllerWithTitle:(NSString *)title
                                     message:(NSString *)message
                              preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UkeAlertController *alertVc = [[UkeAlertController alloc] initWithTitle:title message:message preferredStyle:preferredStyle];
    return alertVc;
}


- (instancetype)initWithTitle:(NSString *)title
                                 message:(NSString *)message
                          preferredStyle:(UIAlertControllerStyle)preferredStyle {
    self = [super init];
    if (self) {
        self.preferredStyle = preferredStyle;
        
        CGFloat defaultContentWidth = 0;
        UkeAlertContentView *content = nil;
        UkeAlertHeaderView *header = nil;

        if (preferredStyle == UIAlertControllerStyleAlert) {
            content = [[UkeAlertContentView alloc] init];
            header = [[UkeAlertHeaderView alloc] initWithTitle:title message:message];
            defaultContentWidth = 270.0;
        }else if (preferredStyle == UIAlertControllerStyleActionSheet) {
            [self setSheetContentMarginBottom:8.0];
        
            content = [self sheetContentView];
            header = [[UkeSheetHeaderView alloc] initWithTitle:title message:message];
            defaultContentWidth = [UIScreen mainScreen].bounds.size.width-8-8;
        }
        
        [self setContentWidth:defaultContentWidth];
        self.contentView = content;
        self.headerView = header;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.actionGroupView layoutActions];

    [self.contentView insertHeaderView:self.headerView];
    [self.contentView insertActionGroupView:self.actionGroupView];
    
    [self addContentView:self.contentView];
}

- (void)addAction:(UkeAlertAction *)action {
    // ActionSheet的cancel按钮需要特殊处理，因为这个按钮s不是添加在actionGroupView中的，而是在contentView中
    BOOL isSheetCancelAction = NO;
    if (self.preferredStyle == UIAlertControllerStyleActionSheet && action.style == UIAlertActionStyleCancel) {
        isSheetCancelAction = YES;
    }
    
    if (isSheetCancelAction) {
        [[self sheetContentView] addCancelAction:action];
    }else {
        [self.actionGroupView addAction:action];
    }
    [self.contentView insertActionGroupView:self.actionGroupView];
}

#pragma mark - Setter.
- (void)setContentWidth:(CGFloat)contentWidth {
    _contentWidth = contentWidth;
    [super setContentWidth:contentWidth];
}

- (void)setSheetContentMarginBottom:(CGFloat)sheetContentMarginBottom {
    _sheetContentMarginBottom = sheetContentMarginBottom;
    [super setSheetContentMarginBottom:sheetContentMarginBottom];
}

- (void)setSheetCancelButtonMarginTop:(CGFloat)sheetCancelButtonMarginTop {
    _sheetCancelButtonMarginTop = sheetCancelButtonMarginTop;
    if (self.preferredStyle == UIAlertControllerStyleActionSheet) {
        [self sheetContentView].sheetCancelButtonMarginTop = sheetCancelButtonMarginTop;
    }
}

- (void)setTitleAttributes:(NSDictionary<NSString *,id> *)titleAttributes {
    [self.headerView setTitleAttributes:titleAttributes];
}

- (void)setMessageAttributes:(NSDictionary<NSString *,id> *)messageAttributes {
    [self.headerView setMessageAttributes:messageAttributes];
}

- (void)setActionButtonHeight:(CGFloat)actionButtonHeight {
    _actionButtonHeight = actionButtonHeight;
    [self.actionGroupView setActionButtonHeight:actionButtonHeight];
    if (self.preferredStyle == UIAlertControllerStyleActionSheet) {
        [self sheetContentView].cancelActionButtonHeight = actionButtonHeight;
    }
}

- (void)setDefaultButtonAttributes:(NSDictionary<NSString *,id> *)defaultButtonAttributes {
    [self.actionGroupView setDefaultButtonAttributes:defaultButtonAttributes];
}

- (void)setCancelButtonAttributes:(NSDictionary<NSString *,id> *)cancelButtonAttributes {
    [self.actionGroupView setCancelButtonAttributes:cancelButtonAttributes];
    if (self.preferredStyle == UIAlertControllerStyleActionSheet) {
        [self sheetContentView].cancelButtonAttributes = cancelButtonAttributes;
    }
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

- (UkeSheetContentView *)sheetContentView {
    UkeSheetContentView *sheetContentView = (UkeSheetContentView *)self.contentView;
    if (!sheetContentView) {
        sheetContentView = [[UkeSheetContentView alloc] init];
        __weak typeof(self)weakSelf = self;
        sheetContentView.dismissHandler = ^{
            [weakSelf dismiss];
        };
    }
    return sheetContentView;
}

- (NSArray<UkeAlertAction *> *)actions {
    return self.actionGroupView.actions;
}

@end
