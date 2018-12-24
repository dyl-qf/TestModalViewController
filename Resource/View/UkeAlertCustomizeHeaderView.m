//
//  UkeAlertCustomizeHeaderView.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/24.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertCustomizeHeaderView.h"
#import "Masonry.h"

@interface UkeAlertCustomizeHeaderView ()
@property (nonatomic, strong) UIView *customizeView;
@end

@implementation UkeAlertCustomizeHeaderView

- (instancetype)initWithCustomizeView:(UIView *)view {
    if (!view) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        while (self.subviews.count) {
            [self.subviews.lastObject removeFromSuperview];
        }
        
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            if (CGRectGetWidth(view.frame) != 0) {
                make.width.mas_equalTo(CGRectGetWidth(view.frame));
            }
            if (CGRectGetHeight(view.frame) != 0) {
                make.height.mas_equalTo(CGRectGetHeight(view.frame));
            }
        }];
        
        self.customizeView = view;
    }
    return self;
}

@end
