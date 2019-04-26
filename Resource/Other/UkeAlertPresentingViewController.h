//
//  UkeAlertPresentingViewController.h
//  TestModalViewController
//
//  Created by liqian on 2019/1/14.
//  Copyright © 2019 liqian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UkePopUpViewController;
@interface UkeAlertPresentingViewController : UIViewController

- (void)presentPopUpViewController:(UkePopUpViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                        completion:(void (^)(void))completion;

- (void)ukePopUpViewControllerWillDismiss:(UkePopUpViewController *)popUpViewController;
- (void)ukePopUpViewControllerDidDismiss;


- (BOOL)ukeIsUkeAlertControllerCurrentShowed;

- (void)ukeRemoveAllAlertConrollerAnimated:(BOOL)animated
                                completion:(nullable void (^)(void))completion;

- (void)ukeRemoveAlertConrollerWithIdentifier:(NSString *)identifier
                                     animated:(BOOL)animated
                                completion:(nullable void (^)(void))completion;

@end



@interface UkePendingPopUpModel : NSObject
@property (nonatomic, strong) UkePopUpViewController *popController;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, strong, nullable) void(^completion)(void);
@end

NS_ASSUME_NONNULL_END
