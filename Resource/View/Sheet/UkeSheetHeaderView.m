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
        
        self.titleMessageAreaContentInsets = UIEdgeInsetsMake(14.5, 16, 25, 16);
        self.titleMessageVerticalSpacing = 12;
    }
    return self;
}

@end
