//
//  UkeSheetActionGroupView.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/22.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "UkeSheetActionGroupView.h"

@implementation UkeSheetActionGroupView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.actionButtonHeight = 57.0;
        self.defaultButtonAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:45/255.0 green:139/255.0 blue:245/255.0 alpha:1.0],
                                     NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:20]                             };
        self.cancelButtonAttributes = @{NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                    NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:20]                             };
        self.destructiveButtonAttributes = @{NSForegroundColorAttributeName: [UIColor redColor],
                                         NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:20]                             };
    }
    return self;
}

@end
