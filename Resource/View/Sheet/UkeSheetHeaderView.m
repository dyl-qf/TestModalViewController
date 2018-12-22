//
//  UkeSheetHeaderView.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/22.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeSheetHeaderView.h"
#import "NSParagraphStyle+Shortcut.h"
#import "Masonry.h"

@implementation UkeSheetHeaderView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    self = [super initWithTitle:title message:message];
    if (self) {        
        self.titleAttributes = @{NSForegroundColorAttributeName: [UIColor lightGrayColor],
                             NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:13],
                             NSParagraphStyleAttributeName: [NSParagraphStyle paragraphStyleWithLineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentCenter]
                             };
        self.messageAttributes = @{NSForegroundColorAttributeName: [UIColor lightGrayColor],
                               NSFontAttributeName: [UIFont systemFontOfSize:12],
                               NSParagraphStyleAttributeName: [NSParagraphStyle paragraphStyleWithLineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentCenter]
                               };
    }
    return self;
}

- (void)layoutTitleAndMessage:(NSArray<UIView *> *)subviews {
    UIView *firstView = subviews.firstObject;
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.top.offset(14.5);
        if (subviews.count == 1) {
            make.bottom.offset(-14.5);
        }
    }];
    
    if (subviews.count == 2) {
        UIView *secondView = subviews.lastObject;
        [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16);
            make.right.offset(-16);
            make.top.mas_equalTo(firstView.mas_bottom).offset(12);
            make.bottom.offset(-25);
        }];
    }
}

@end
