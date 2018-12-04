//
//  OOReactSkinBridge.h
//  OoyalaSkinSDK
//
//  Created by Maksim Kupetskii on 8/14/18.
//  Copyright © 2018 ooyala. All rights reserved.
//

#import <React/RCTBridge.h>
#import "OOReactSkinEventsEmitter.h"

@protocol OOReactSkinBridgeModule;
@protocol OOReactSkinBridgeDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface OOReactSkinBridge : RCTBridge

- (instancetype)initWithDelegate:(id<OOReactSkinBridgeDelegate>)delegate
                   launchOptions:(nullable NSDictionary *)launchOptions;

- (instancetype)initWithBundleURL:(NSURL *)bundleURL
                   moduleProvider:(RCTBridgeModuleListProvider)block
                    launchOptions:(NSDictionary *)launchOptions NS_UNAVAILABLE;
@end


@interface RCTBridge (OOReactSkinEventsEmitterable)

@property (nonatomic, readonly) OOReactSkinEventsEmitter *skinEventsEmitter;

@end


@protocol OOReactSkinBridgeDelegate <RCTBridgeDelegate>

@optional
- (void)bridge:(OOReactSkinBridge *)bridge didLoadModule:(id<OOReactSkinBridgeModule>)module;

@end

NS_ASSUME_NONNULL_END

