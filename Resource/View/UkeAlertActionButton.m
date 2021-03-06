//
//  UkeAlertActionButton.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/18.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeAlertActionButton.h"
#import "Masonry.h"

@interface UkeAlertActionButton ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation UkeAlertActionButton

- (instancetype)init {
    self = [super init];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    if (self.isHighlighted == highlighted) {
        return;
    }
    [super setHighlighted:highlighted];
    
    if (highlighted == YES) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.backgroundColor = [UIColor whiteColor];
        });
    }
}

- (void)setEnabled:(BOOL)enabled {
    if (self.isEnabled == enabled) {
        return;
    }
    
    [super setEnabled:enabled];
    
    if (enabled == YES) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.alpha = 1.0;
    }else {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        self.titleLabel.alpha = 0.3;
    }
}

@end
