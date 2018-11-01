/**
 * @file       OOReactSkinEventsEmitter.h
 * @class      OOReactSkinEventsEmitter OOReactSkinEventsEmitter.h "OOReactSkinEventsEmitter.h"
 * @brief      OOReactSkinEventsEmitter
 * @details    OOReactSkinEventsEmitter.h in OoyalaSDK
 * @date       8/13/18
 * @copyright Copyright (c) 2018 Ooyala, Inc. All rights reserved.
 */

#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>

@interface OOReactSkinEventsEmitter : RCTEventEmitter<RCTBridgeModule>

@property (nonatomic) BOOL isReactReady;

- (void)sendDeviceEventWithName:(NSString *)eventName body:(id)body;

@end
