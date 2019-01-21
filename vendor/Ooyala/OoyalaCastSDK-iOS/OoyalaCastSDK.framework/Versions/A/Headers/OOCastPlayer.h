//
//  OOCastPlayer.h
//  OoyalaSDK
//
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import <GoogleCast/GoogleCast.h>
#import <OoyalaSDK/OOPlayerProtocol.h>

@class OOCastManager;
@class OOCastModeOptions;
@class OOOoyalaPlayer;
@class OOStateNotifier;
@protocol OOCastMiniControllerProtocol;
@protocol OOCastManagerInternalProtocol;

@interface OOCastPlayer : GCKCastChannel <OOPlayerProtocol>

@property (nullable, nonatomic) OOStateNotifier *stateNotifier;
@property (nullable, nonatomic) NSString *embedCode;
@property (nonatomic) Float64 playheadTime;
@property (nonnull, nonatomic) NSString *castItemTitle;
@property (nonnull, nonatomic) NSString *castItemDescription;
@property (nonnull, nonatomic) NSString *castItemPromoImg;
@property (nonatomic, readonly) BOOL isMiniControllerInteractionAvailable;

- (nonnull instancetype)init __attribute__((unavailable("use initWithNamespace:deviceManager:castManager")));
- (nonnull instancetype)initWithNamespace:(nonnull NSString *)appNamespace
                              castSession:(nullable GCKCastSession *)castSession
                              castManager:(nullable id<OOCastManagerInternalProtocol>)castManager;

- (void)initStateNotifier:(nullable OOStateNotifier *)stateNotifier;
- (void)registerWithOoyalaPlayer:(nullable OOOoyalaPlayer *)ooyalaPlayer;
- (void)updateMetadataCastItemPromoImg:(nullable NSString *)castItemPromoImg
                         castItemTitle:(nullable NSString *)castItemTitle
                   castItemDescription:(nullable NSString *)castItemDescription;
- (void)enterCastModeWithOptions:(nonnull OOCastModeOptions *)options
                      embedToken:(nonnull NSString *)embedToken
            additionalInitParams:(nullable NSDictionary *)params;
- (void)registerMiniController:(nullable id<OOCastMiniControllerProtocol>)miniController;
- (void)deregisterMiniController:(nullable id<OOCastMiniControllerProtocol>)miniController;
- (void)onExitCastMode;
- (void)forceAssetRejoin;

@end
