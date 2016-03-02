/**
 * @file       OOSkinPlayerObserver.h
 * @class      OOSkinPlayerObserver OOSkinPlayerObserver.h "OOSkinPlayerObserver.h"
 * @brief      OOSkinPlayerObserver
 * @details    OOSkinPlayerObserver contains all of the code around listening to the OoyalaPlayer and performing actiosn based off of it.
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */


#import <Foundation/Foundation.h>

@class OOOoyalaPlayer;
@class OOSkinViewController;

@interface OOSkinPlayerObserver : NSObject

- (instancetype) init __attribute__((unavailable("init not available")));
- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player skinViewController:(OOSkinViewController *)viewController;

- (void) bridgeCurrentItemChangedNotification:(NSNotification *)notification;
- (void) bridgeErrorNotification:(NSNotification *)notification;
- (void) bridgeStateChangedNotification:(NSNotification *)notification;
@end
