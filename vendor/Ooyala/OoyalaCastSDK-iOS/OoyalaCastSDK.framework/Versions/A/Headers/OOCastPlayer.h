//
//  OOCastPlayer.h
//  OoyalaSDK
//
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleCast/GoogleCast.h>
#import <OoyalaSDK/OOPlayerProtocol.h>
#import <OoyalaSDK/OOStateNotifier.h>


@class OOCastManager, OOCastModeOptions, OOOoyalaPlayer;
@protocol OOCastMiniControllerProtocol;


@interface OOCastPlayer : GCKCastChannel <OOPlayerProtocol>

@property (nonatomic) OOStateNotifier *stateNotifier;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) Float64 playheadTime;
@property (nonatomic) NSString *castItemTitle;
@property (nonatomic) NSString *castItemDescription;
@property (nonatomic) NSString *castItemPromoImg;
@property (nonatomic, readonly) BOOL isMiniControllerInteractionAvailable;

- (instancetype)init __attribute__((unavailable("use initWithNamespace:deviceManager:castManager")));
- (instancetype)initWithNamespace:(NSString *)appNamespace castSession:(GCKCastSession *)castSession castManager:(OOCastManager *)castManager;

- (void)initStateNotifier:(OOStateNotifier *)stateNotifier;
- (void)registerWithOoyalaPlayer:(OOOoyalaPlayer*)ooyalaPlayer;
- (void)updateMetadataFromOoyalaPlayer:(NSString *)castItemPromoImg castItemTitle:(NSString *)castItemTitle castItemDescription:(NSString *)castItemDescription;
- (void)enterCastModeWithOptions:(OOCastModeOptions *)options embedToken:(NSString *)embedToken additionalInitParams:(NSDictionary *)params;
- (void)registerMiniController:(id<OOCastMiniControllerProtocol>) miniController;
- (void)deregisterMiniController:(id<OOCastMiniControllerProtocol>)miniController;
- (void)onExitCastMode;
- (void)forceAssetRejoin;

@end
