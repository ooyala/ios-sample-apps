//
//  PresentedViewController.h
//  OoyalaSkinSDK
//
// Copyright (c) 2018 ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PresentedViewControllerHelper : NSObject

@property (nullable, nonatomic) UIViewController *rootViewController;
@property (nullable, nonatomic) UIViewController *presentedViewController;

- (void)findAndStorePresentedViewController;
- (void)dismissPresentedViewControllersWithCompletionBlock:(nullable void (^)(void))completion;
- (void)presentStoredControllersWithCompletionBlock:(nullable void (^)(void))completion;
- (void)clearData;

@end
