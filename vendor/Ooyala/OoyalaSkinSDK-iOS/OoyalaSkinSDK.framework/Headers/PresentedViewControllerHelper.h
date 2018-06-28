//
// Copyright (c) 2018 ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PresentedViewControllerHelper : NSObject

@property (nullable, nonatomic) UIViewController *rootViewController;
@property (nullable, nonatomic) UIViewController *presentedViewController;


- (void)findAndStorePresentedViewController;

- (void)dismissPresentedViewControllersWithCompletionBlock:(void (^ __nullable)(void))completion;

- (void)presentStoredControllersWithCompletionBlock:(void (^ __nullable)(void))completion;

- (void)clearData;

@end
