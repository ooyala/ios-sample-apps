//
//  OOCastPlayer.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 8/29/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleCast/GoogleCast.h>
#import <OoyalaSDK/OOPlayerProtocol.h>
#import <OoyalaSDK/OOStateNotifier.h>
#import "OOCastMiniControllerProtocol.h"

@class OOCastManager;
@class OOCastModeOptions;
@class OOOoyalaPlayer;

@interface OOCastPlayer : GCKCastChannel<OOPlayerProtocol>

@property(nonatomic, strong) OOStateNotifier *stateNotifier;

@property(nonatomic, strong) NSString *embedCode;

@property(nonatomic) Float64 playheadTime;

@property(nonatomic, strong) NSString *castItemTitle;

@property(nonatomic, strong) NSString *castItemDescription;

@property(nonatomic, strong) NSString *castItemPromoImg;

@property(nonatomic, weak) OOCastManager *castManager;

- (id) init __attribute__((unavailable("use initWithNamespace:appNamespace")));

- (void)initStateNotifier:(OOStateNotifier *)stateNotifier;

- (void)registerWithOoyalaPlayer:(OOOoyalaPlayer*)ooyalaPlayer;

- (void)updateMetadataFromOoyalaPlayer:(NSString *)castItemPromoImg castItemTitle:(NSString *)castItemTitle castItemDescription:(NSString *)castItemDescription;

- (void)enterCastModeWithOptions:(OOCastModeOptions *)options embedToken:(NSString *)embedToken additionalInitParams:(NSDictionary *)params;

- (void)registerMiniController:(id<OOCastMiniControllerProtocol>) miniController;

- (void)deregisterMiniController:(id<OOCastMiniControllerProtocol>)miniController;

- (void)onExitCastMode;
@end
