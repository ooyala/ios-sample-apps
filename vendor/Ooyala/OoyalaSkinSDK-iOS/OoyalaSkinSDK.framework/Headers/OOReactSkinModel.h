//
//  OOReactSkinModel.h
//  OoyalaSkinSDK
//
//  Created by Maksim Kupetskii on 8/13/18.
//  Copyright © 2018 ooyala. All rights reserved.
//

#import <React/RCTBridgeDelegate.h>

@class OOOoyalaPlayer;
@class OOSkinOptions;
@class OOClosedCaptionsStyle;
@class RCTRootView;
@protocol OOSkinViewControllerDelegate;


@interface OOReactSkinModel : NSObject<RCTBridgeDelegate>

@property (nonnull, nonatomic) NSDictionary *skinConfig;
@property (nullable, nonatomic, readwrite) OOClosedCaptionsStyle *closedCaptionsDeviceStyle;
@property (nonatomic, readonly) CGRect videoViewFrame;

- (nonnull instancetype)initWithWithPlayer:(nonnull OOOoyalaPlayer *)player
                               skinOptions:(nonnull OOSkinOptions *)skinOptions
                    skinControllerDelegate:(nonnull id<OOSkinViewControllerDelegate>)skinControllerDelegate;
- (nonnull RCTRootView*)viewForModuleWithName:(nonnull NSString *)moduleName;
- (void)sendEventWithName:(nonnull NSString *)eventName body:(nullable id)body;
- (void)setIsReactReady:(BOOL)isReactReady;
- (void)ccStyleChanged:(nullable NSNotification *)notification;

// Note: This is for IMA ad playback only.
// When IMA ad plays, IMA consumes clicks for learn more, skip, etc and notify ooyala if the click is not consumed.
// toggle play/pause as if the alice ui is clicked.
// see: OOSkinPlayerObserver bridgeAdTappedNotification
- (void)playPauseFromAdTappedNotification;
- (void)maybeLoadDiscovery:(nullable NSString *)embedCode;
- (void)setReactViewInteractionEnabled:(BOOL)reactViewInteractionEnabled;

@end


@protocol OOReactSkinModelDelegate <NSObject>
// Handling events sent from RN
- (void)toggleFullscreen;
- (void)toggleStereoMode;
- (void)handlePip;
- (void)handleIconClick:(NSInteger)index;
- (void)handlePlayPause;
- (void)handlePlay;
- (void)handleReplay;
- (void)handleRewind;
- (void)handleSocialShare;
- (void)handleLearnMore;
- (void)handleSkip;
- (void)handleMoreOption;
- (void)handleUpNextDismiss;
- (void)handleUpNextClick;
- (void)handleLanguageSelection:(nullable NSString *)language;
- (void)handleAudioTrackSelection:(nonnull NSString *)audioTrackName;
- (void)handlePlaybackSpeedRateSelection:(nullable NSNumber *)selectedPlaybackSpeedRate;
- (void)handleOverlay:(nullable NSString *)url;
- (void)handleTouch:(nonnull NSDictionary *)result;
- (void)handleScrub:(Float64)position;
- (void)setEmbedCode:(nonnull NSString *)embedCode;
- (void)handleDiscoveryClick:(nullable NSString *)bucketInfo embedCode:(nonnull NSString *)embedCode;
- (void)handleDiscoveryImpress:(nullable NSString *)bucketInfo;
- (void)handleVolumeChanged:(float)volume;

@end
