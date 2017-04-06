/**
 * @file       OOReactBridge.h
 * @class      OOReactBridge OOReactBridge.h "OOReactBridge.h"
 * @brief      OOReactBridge
 * @details    OOReactBridge.h in OoyalaSDK
 * @date       4/2/15
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"

@class OOSkinViewController;

@interface OOReactBridge : NSObject<RCTBridgeModule>
- (void)sendDeviceEventWithName:(NSString *)eventName body:(id)body;
- (void)registerController:(OOSkinViewController *)controller;
- (void)deregisterController:(OOSkinViewController *)controller;

@end
