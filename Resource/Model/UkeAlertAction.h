//
//  UkeAlertAction.h
//  TestModalViewController
//
//  Created by liqian on 2018/12/18.
//  Copyright © 2018 liqian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UkeAlertAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title
                              style:(UIAlertActionStyle)style
                            handler:(void (^ __nullable)(UkeAlertAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, assign, readonly) UIAlertActionStyle style;
@property (nullable, nonatomic, strong, readonly) void(^actionHandler)(UkeAlertAction *action);

@end

NS_ASSUME_NONNULL_END
