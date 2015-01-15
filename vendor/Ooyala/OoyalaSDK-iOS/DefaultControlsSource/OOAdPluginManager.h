//
//  OOAdPluginManager.h
//  OoyalaSDK
//
//  Created by Zhihui Chen on 7/31/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OOAdPluginManagerProtocol.h"
#import "OOLifeCycle.h"
#import "OOOoyalaAdPlayer.h"
#import "OOPlayerProtocol.h"

@interface OOAdPluginManager : NSObject<OOAdPluginManagerProtocol, OOLifeCycle>

@property id<OOAdPlugin> activePlugin;
@property (readonly) OOAdMode adMode;
@property (readonly) id<OOPlayerProtocol> player;

- (id)initWithPlayer:(OOOoyalaPlayer *)player;
- (BOOL)inAdMode;
- (BOOL)onAdMode:(OOAdMode)mode parameter:(NSNumber *)param;
- (void)resetAds;
- (void)skipAd;
- (void)onAdModeEntered;
- (NSSet*/*<NSNumber int seconds>*/) getCuePointsAtSeconds;
- (void)resetManager;

+ (NSString *)modeToString:(OOAdMode)mode;

@end
