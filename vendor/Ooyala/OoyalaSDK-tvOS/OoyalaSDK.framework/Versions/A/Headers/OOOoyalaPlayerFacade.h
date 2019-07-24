//
//  OOOyalaPlayerInternal.h
//  OoyalaSDK
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#ifndef OOOyalaPlayerFacade_h
#define OOOyalaPlayerFacade_h

@import AVFoundation;
@import UIKit;

#import "OOCallbacks.h"
#import "OOPlayerState.h"
#import "OOEnums.h"
#import "OOExternNotifications.h"

@class OOContentItem;
@class OOVideo;
@class OOOoyalaError;
@class OOOoyalaAPIClient;
@class OOClosedCaptionsStyle;
@class OOStreamPlayer;
@class OOManagedAdSpot;
@class OOPlayerDomain;
@class OOCastManager;
@class OOStreamPlayerMapping;
@class OOFCCTVRatingConfiguration;
@class OOFCCTVRating;
@class OOOptions;
@class OOManagedAdsPlugin;
@class OOPlayer;
@class OOSsaiAdsMetadata;
@class OOAudioSession;
@class OOOoyalaPlayerContextSwitcher;
@class OOOoyalaPlayerSessionIDManager;
@class OOAssetLoaderDelegate;
@class OOUnbundledVideo;
@class OOStream;
@class OOOoyalaError;
@protocol OOEmbedTokenGenerator;

/**
 * \defgroup key Most Commonly Used Classes
 * \defgroup item Content Item
 * \defgroup performance Performance Utilities
 * \defgroup captions Captions
 * \defgroup vast VAST-Specific
 * \defgroup offline Offline Playback (DTO)
 */

/**
 * The OoyalaPlayer is the heart of the playback system.
 * Use it to configure and control asset playback, and to be aware of playback state changes.
 * \ingroup key
 */
@interface OOOoyalaPlayer : NSObject

#pragma mark Statics
/**
 * Set which environment is used for Player APIs. Default OOOoyalaPlayerEnvironmentProduction
 */
+ (void)setEnvironment:(OOOoyalaPlayerEnvironment)env;

/**
 * Set if SSL is used for Player APIs. Default YES
 */
+ (void)setSSLEnvironmentEnabled:(BOOL)sslEnabled;

/**
 * Get the version and RC of the Ooyala SDK
 * @return the string that represents the SDK version
 */
+ (NSString *)version;

/**
 * @return YES means to try to use local/debug DRM modes,
 * NO means to use regular DRM config.
 */
+ (BOOL)useDebugDRMPlayback;


/**
 * set encryptedloopback.
 * @param enabled true if enabled, false if disabled
 */
+ (void)setEncryptedLoopback:(BOOL)enabled;

/**
 * get encryptedloopback.
 * @return encryptedLoopback;
 */
+ (BOOL)encryptedLoopback;

/**
 * YES means to try to use local/debug DRM modes,
 * NO means to use regular DRM config.
 */
+ (void)setUseDebugDRMPlayback:(BOOL)enable;

/**
 Use to get state for Ooyala Analytics (IQ) tracking.
 @return Returns state for Ooyala Analytics (IQ) tracking.
 */
+ (OOIQAnalyticsTrackingState)iqAnalyticsTrackingState;

/**
 Use to set different states for Ooyala Analytics (IQ) tracking. Default OOIQAnalyticsTrackingStateDefault.
 @warning Property should be set before creating an instance of OOoyalaPlayer.
 @param state The IQ analytics state
 */
+ (void)setIqAnalyticsTrackingState:(OOIQAnalyticsTrackingState)state;

#pragma mark Properties

@property (readonly, nonatomic) OOVideo *currentItem; /**< The OOOoyalaPlayer's currently playing OOVideo */
@property (readonly, nonatomic) OOContentItem *rootItem; /**< The OOOoyalaPlayer's embedded content (OOVideo, OOChannel, or OOChannelSet) */
@property (readonly, nonatomic) NSDictionary *metadata; /**< The OOOoyalaPlayer's content metadata for currently loaded content */
@property (readonly, nonatomic) OOOoyalaError *error; /**< The OOOoyalaPlayer's current error if it exists */
@property (readonly, nonatomic) OOOoyalaPlayerSessionIDManager *sessionIDManager;
@property (readonly, nonatomic) UIView *view; /**< the view associated with the player*/
@property (nonatomic) OOOoyalaPlayerVideoGravity videoGravity;
@property (readonly, nonatomic) BOOL supportsVideoGravityButton;
@property (nonatomic) BOOL seekable; /**< Whether or not the Videos that OOOoyalaPlayer plays are seekable */
@property (nonatomic) BOOL adsSeekable; /**< Whether or not the Ads that OOOoyalaPlayer plays are seekable */
@property (readonly, nonatomic) OOSeekStyle seekStyle;
@property (nonatomic) NSString *closedCaptionsLanguage; /**< the current closed captions language, or nil to hide closed captions. */
/**
 * Get whether the player is playing the audio only stream in an m3u8
 */
@property (readonly, nonatomic) BOOL isAudioOnlyStreamPlaying;
@property (readonly, nonatomic, getter = isClosedCaptionsTrackAvailable) BOOL closedCaptionsTrackAvailable;
@property (nonatomic) OOCurrentItemChangedCallback currentItemChangedCallback; /**< A callback that will be called every time the current item is changed */

@property (nonatomic) OOOoyalaPlayerActionAtEnd actionAtEnd; /**< the OOOoyalaPlayerActionAtEnd to perform when the current item finishes playing. */

@property (readonly, nonatomic, getter = isExternalPlaybackActive) BOOL externalPlaybackActive;

@property (nonatomic) BOOL allowsExternalPlayback;

@property (nonatomic) BOOL usesExternalPlaybackWhileExternalScreenIsActive; /** When external playback is enabled, this will share the video view to the external screen only, instead of mirroring the device. */

@property (nonatomic) float playbackRate; /**< the rate of playback. 1 is the normal speed.  Set to .5 for half speed, 2 for double speed, etc. */
@property (readonly, nonatomic) NSString *authToken; /**< The Auth Token provided by Ooyala Authorization, when using Ooyala Player Token */

@property (readonly, nonatomic) NSString *playerSessionId; /**< A Session ID that is created at the initialization of OoyalaPlayer. Persists for the life of the OoyalaPlayer */
@property (readonly, nonatomic) NSString *contentSessionId; /**< A Session ID that is created on the set of a new piece of content (i.e setEmbedCode). Persists until a new piece of content is set. Can be null if no video was set **/

/**
 * The volume of the OoyalaPlayer, relative to the device's volume setting.
 * For example, if volume is 1.0 (default), the playback volume would be as loud as the device's volume.
 * The volume set here will affect Content, Ooyala, Pulse, and VAST ad playback.  It will not affect other ad managers.
 * This property can be changed at any point after the OoyalaPlayer is initialized
 */
@property (nonatomic) float volume;

/**
 * This property can be used to set the User-Agent for manifest requests served by AVPlayer.
 * This will not change User-Agent for player api requests.
 * Note : [player setUserAgent:@"<value>"] should be called after initializing
 * player but before calling [player setEmbedCode:] method.
 *
 */
@property (nonatomic) NSString *userAgent;

/**
 * This property can be used to pass Custom Implementation of AVAssetResourceLoaderDelegate
 * from AVFoundation.
 * Note : This only for special purposes. Not recommend to use this property often.
 *        When this property is in use, you CAN NOT use FairPlay.
 */
@property (nonatomic) OOAssetLoaderDelegate *assetLoaderDelegate;
@property (nonatomic) NSString *customDrmData;
@property (nonatomic, readonly) OOStreamPlayerMapping *streamPlayerMapping;
@property (nonatomic, readonly) NSString *pcode;


/**
 * Gets the user's current desired state.
 * @return a string containing the current state
 */
@property (nonatomic, readonly)OOOoyalaPlayerDesiredState desiredState;

/**
 * Get the managedAdsPlugin that manages OOOoyalaAdSpots and OOVASTAdSpots.
 */
@property (readonly, nonatomic) OOManagedAdsPlugin *managedAdsPlugin;

/**
 * Get the options
 */
@property (readonly, nonatomic) OOOptions *options;

/**
 * @internal the ui slider mode
 */
@property (nonatomic) OOUIProgressSliderMode normalSliderMode;


/**
 * @internal Audio Session
 */
@property (nonatomic) OOAudioSession *audioSession;

#pragma mark Initializers

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param apiClient the initialized OOOoyalaAPIClient to use
 * @return the initialized OOOoyalaPlayer
 */
- (instancetype)initWithOoyalaAPIClient:(OOOoyalaAPIClient *)apiClient;

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param pcode Your Provider Code
 * @param domain Your Embed Domain
 * @return the initialized OOOoyalaPlayer
 */
- (instancetype)initWithPcode:(NSString *)pcode
                       domain:(OOPlayerDomain *)domain;

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param pcode Your Provider Code
 * @param domain Your Embed Domain
 * @param options the options
 * @return the initialized OOOoyalaPlayer
 */
- (instancetype)initWithPcode:(NSString *)pcode
                       domain:(OOPlayerDomain *)domain
                      options:(OOOptions *)options;

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param pcode Your Provider Code
 * @param domain Your Embed Domain
 * @param embedTokenGenerator the initialized OOEmbedTokenGenerator to use
 * @return the initialized OOOoyalaPlayer
 */
- (instancetype)initWithPcode:(NSString *)pcode
                       domain:(OOPlayerDomain *)domain
          embedTokenGenerator:(id<OOEmbedTokenGenerator>)embedTokenGenerator;

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param pcode Your Provider Code
 * @param domain Your Embed Domain
 * @param embedTokenGenerator the initialized OOEmbedTokenGenerator to use
 * @param options Extra settings
 * @return the initialized OOOoyalaPlayer
 */
- (instancetype)initWithPcode:(NSString *)pcode
                       domain:(OOPlayerDomain *)domain
          embedTokenGenerator:(id<OOEmbedTokenGenerator>)embedTokenGenerator
                      options:(OOOptions *)options;


#pragma mark Content Setters

- (void)setDesiredState:(OOOoyalaPlayerDesiredState)desiredState;

/**
 * @param stream non-nil, non-empty NSArray containing OOStreams.
 */
- (BOOL)setStream:(OOStream *)stream;

/**
 * @param streams non-nil, non-empty NSArray containing OOStreams.
 */
- (BOOL)setStreams:(NSArray *)streams;

/**
 * Casting of OOUnbundledVideo is not supported.
 * @param unbundledVideo non-nil OOUnbundledVideo containing OOStreams.
 */
- (BOOL)setUnbundledVideo:(OOUnbundledVideo *)unbundledVideo;

/**
 DEPRECATED. The internal method of this call is @c asynchronous, so we recommend using a method with a callback.
 Use @c-setEmbedCode:callback: instead
 
 Reinitializes the player with a new embedCode.
 @param embedCode the embed code to use
 @return YES always, doesn't depend on asynchronous execution result, so don't rely on it. If something is wrong please check OOOoyalaPlayer.error for a reason.
 */
- (BOOL)setEmbedCode:(nonnull NSString *)embedCode;
__deprecated_msg("Use -setEmbedCode:callback: instead");

/**
 DEPRECATED. The internal method of this call is @c asynchronous, so we recommend using a method with callback.
 Use @c-setEmbedCodes:withCallback: instead
 
 Reinitializes the player with an array of embedCodes
 @param embedCodes the embed code(s) to use. If more than one is specified, OOOoyalaPlayer.rootItem becomes an OODynamicChannel.
 @return YES always, doesn't depend on asynchronous execution result, so don't rely on it. If something is wrong please check OOOoyalaPlayer.error for a reason.
 */
- (BOOL)setEmbedCodes:(nonnull NSArray<NSString *> *)embedCodes;
__deprecated_msg("Use -setEmbedCodes:withCallback: instead");

/**
 DEPRECATED. The internal method of this call is @c asynchronous, so we recommend using a method with callback.
 Use @c-setEmbedCode:adSetCode:withCallback: instead
 
 Reinitializes the player a new embedCode and sets the ad set dynamically.
 @param embedCode the embed code to use
 @param adSetCode the ad set code to use
 @return YES always, doesn't depend on asynchronous execution result, so don't rely on it. If something is wrong please check OOOoyalaPlayer.error for a reason.
 */
- (BOOL)setEmbedCode:(nonnull NSString *)embedCode adSetCode:(nullable NSString *)adSetCode;
__deprecated_msg("Use -setEmbedCode:adSetCode:withCallback: instead");

/**
  DEPRECATED. The internal method of this call is @c asynchronous, so we recommend using a method with callback.
 Use @c-setEmbedCodes:adSetCode:withCallback: instead
 
 * Reinitializes the player with an array of embedCodes and sets the ad set dynamically.
 * @param embedCodes the embed code(s) to use. If more than one is specified, OOOoyalaPlayer.rootItem becomes an OODynamicChannel.
 * @param adSetCode the ad set code to use.
 * @return YES always, doesn't depend on asynchronous execution result, so don't rely on it. If something is wrong please check OOOoyalaPlayer.error for a reason.
 */
- (BOOL)setEmbedCodes:(nonnull NSArray<NSString *> *)embedCodes adSetCode:(nullable NSString *)adSetCode;
__deprecated_msg("Use -setEmbedCodes:adSetCode:withCallback: instead");

/**
 DEPRECATED. The internal method of this call is @c asynchronous, so we recommend using a method with callback.
 Use @c-setExternalId:withCallback: instead
 
 * Reinitializes the player with a new external ID. External IDs enable you to assign custom identifiers to your assets so they are easier to organize, update, and modify.
 * @param externalId the external ID to use
 * @return YES always, doesn't depend on asynchronous execution result, so don't rely on it. If something is wrong please check OOOoyalaPlayer.error for a reason
 */
- (BOOL)setExternalId:(nonnull NSString *)externalId;
__deprecated_msg("Use -setExternalId:withCallback: instead");

/**
 DEPRECATED. The internal method of this call is @c asynchronous, so we recommend using a method with callback.
 Use @c-setExternalIds:withCallback: instead
 
 * Reinitializes the player with an array of new external IDs. External IDs enable you to assign custom identifiers to your assets so they are easier to organize, update, and modify.
 * @param externalIds the external ID(s) to use. If more than one is specified, OOOoyalaPlayer.rootItem becomes an OODynamicChannel.
 * @return YES always, doesn't depend on asynchronous execution result, so don't rely on it. If something is wrong please check OOOoyalaPlayer.error for a reason
 */
- (BOOL)setExternalIds:(nonnull NSArray<NSString *> *)externalIds;
__deprecated_msg("Use -setExternalIds:withCallback: instead");


/**
 Reinitializes the player with a new external ID. External IDs enable you to assign custom identifiers to your assets so they are easier to organize, update, and modify.
 @param externalId the external ID to use
 @param callback The callback that called when request is completed.
 @param error An error instance that describes why the request failed; otherwise, 'nil'
 */
- (void)setExternalId:(nonnull NSString *)externalId
         withCallback:(void(^_Nullable)(OOOoyalaError * _Nullable error))callback;

/**
 Reinitializes the player with an array of new external IDs. External IDs enable you to assign custom identifiers to your assets so they are easier to organize, update, and modify.
 @param externalIds the external ID(s) to use. If more than one is specified, OOOoyalaPlayer.rootItem becomes an OODynamicChannel.
 @param callback The callback that called when request is completed.
 @param error An error instance that describes why the request failed; otherwise, 'nil'
 */
- (void)setExternalIds:(nonnull NSArray<NSString *> *)externalIds
          withCallback:(void(^_Nullable)(OOOoyalaError * _Nullable error))callback;

/**
 Asynchronous method that reinitializes the player with a new embedCode.
 
 @param embedCode the embed code to use
 @param callback The callback that called when request is completed.
 @param error An error instance that describes why the request failed; otherwise, 'nil'
 */
- (void)setEmbedCode:(nonnull NSString *)embedCode
        withCallback:(void(^_Nullable)(OOOoyalaError * _Nullable error))callback;

/**
 Asynchronous method that reinitializes the player with a new embedCode.
 
 @param embedCode the embed code to use
 @param autoPlay set 'YES' if you need to start playback for new asset when player is ready, otherwise, 'NO'
 @param callback The callback that called when request is completed.
 @param error An error instance that describes why the request failed; otherwise, 'nil'
 */
- (void)setEmbedCode:(nonnull NSString *)embedCode
      shouldAutoPlay:(BOOL)autoPlay
        withCallback:(void(^_Nullable)(OOOoyalaError * _Nullable error))callback;

/**
 Asynchronous method that reinitializes the player with an array of embedCodes.
 
 @param embedCodes the embed code(s) to use. If more than one is specified, OOOoyalaPlayer.rootItem becomes an OODynamicChannel.
 @param callback The callback that called when request is completed.
 @param error An error instance that describes why the request failed; otherwise, 'nil'
 */
- (void)setEmbedCodes:(nonnull NSArray <NSString *> *)embedCodes
         withCallback:(void(^_Nullable)(OOOoyalaError * _Nullable error))callback;

/**
 Asynchronous method that reinitializes the player with an array of embedCodes.
 
 @param embedCodes the embed code(s) to use. If more than one is specified, OOOoyalaPlayer.rootItem becomes an OODynamicChannel.
 @param autoPlay set 'YES' if you need to start playback for new asset when player is ready, otherwise, 'NO'
 @param callback The callback that called when request is completed.
 @param error An error instance that describes why the request failed; otherwise, 'nil'
 */
- (void)setEmbedCodes:(nonnull NSArray <NSString *> *)embedCodes
       shouldAutoPlay:(BOOL)autoPlay
         withCallback:(void(^_Nullable)(OOOoyalaError * _Nullable error))callback;

/**
 Asynchronous method that reinitializes the player with a new embedCode and sets the ad set dynamically.
 
 @param embedCode the embed code to use
 @param adSetCode the ad set code to use
 @param callback The callback that called when request is completed.
 @param error An error instance that describes why the request failed; otherwise, 'nil'
 */
- (void)setEmbedCode:(nonnull NSString *)embedCode
           adSetCode:(nullable NSString *)adSetCode
        withCallback:(void(^_Nullable)(OOOoyalaError * _Nullable error))callback;

/**
 Asynchronous method that reinitializes the player with a new embedCode and sets the ad set dynamically.
 
 @param embedCode the embed code to use
 @param adSetCode the ad set code to use
 @param autoPlay set 'YES' if you need to start playback for new asset when player is ready, otherwise, 'NO'
 @param callback The callback that called when request is completed.
 @param error An error instance that describes why the request failed; otherwise, 'nil'
 */
- (void)setEmbedCode:(nonnull NSString *)embedCode
           adSetCode:(nullable NSString *)adSetCode
      shouldAutoPlay:(BOOL)autoPlay
        withCallback:(void(^_Nullable)(OOOoyalaError * _Nullable error))callback;

/**
 Asynchronous method that reinitializes the player with an array of embedCodes and sets the ad set dynamically.
 
 @param embedCodes the embed code(s) to use. If more than one is specified, OOOoyalaPlayer.rootItem becomes an OODynamicChannel.
 @param adSetCode the ad set code to use.
 @param callback The callback that called when request is completed.
 @param error An error instance that describes why the request failed; otherwise, 'nil'
 */
- (void)setEmbedCodes:(nonnull NSArray<NSString *> *)embedCodes
            adSetCode:(nullable NSString *)adSetCode
         withCallback:(void(^_Nullable)(OOOoyalaError * _Nullable error))callback;

/**
 Asynchronous method that reinitializes the player with an array of embedCodes and sets the ad set dynamically.
 
 @param embedCodes the embed code(s) to use. If more than one is specified, OOOoyalaPlayer.rootItem becomes an OODynamicChannel.
 @param adSetCode the ad set code to use.
 @param autoPlay set 'YES' if you need to start playback for new asset when player is ready, otherwise, 'NO'
 @param callback The callback that called when request is completed.
 @param error An error instance that describes why the request failed; otherwise, 'nil'
 */
- (void)setEmbedCodes:(nonnull NSArray<NSString *> *)embedCodes
            adSetCode:(nullable NSString *)adSetCode
       shouldAutoPlay:(BOOL)autoPlay
         withCallback:(void(^_Nullable)(OOOoyalaError * _Nullable error))callback;

/**
 * Reinitializes the player with a root item.
 * @param theRootItem the root item to use
 */
- (void)setRootItem:(OOContentItem *)theRootItem;

/**
 * Reinitializes the player with a new asset JSON.
 * @param asset the new asset JSON to use
 */
- (void)setAsset:(nonnull NSDictionary *)asset;

/**
 * Sets the current video in a channel, if the video is present.
 * @param embedCode the embed code of the video to play
 * @return YES if successful; otherwise, returns NO (check OOOoyalaPlayer.error for a reason)
 */
- (BOOL)changeCurrentItemToEmbedCode:(nonnull NSString *)embedCode;

/**
 Sets the current video.  OOVideo must be a part of the content tree provided by the root item.
 @return Return YES if all data checkings was completed, linked objects were updated and async request for playback info was send. Flag doesn’t describe request result. NO - if checking failed and/or updating interrupted and/or request wasn’t sent. If something is wrong please check OOOoyalaPlayer.error for a reason
 */
- (BOOL)changeCurrentItemToVideo:(nonnull OOVideo *)video;

/**
 * Set the unbundled HA video.
 * @return a BOOL indicating that the item was successfully changed
 */
- (BOOL)changeUnbundledVideo:(nonnull OOVideo *)video;

/**
 Performs authorization on the current item, refreshing teh auth token if necessary

 @param callback a callback with error if present
 */
- (void)reauthorizeCurrentItemWithCallback:(OOAuthorizeCallback)callback;

#pragma mark During-playback status

/**
 * Gets the player's current state.
 * @return a string containing the current state
 */
- (OOOoyalaPlayerState)state;

#pragma mark Playback Actions

/**
 * DEPRECATED. Sets a tag for custom analytics.
 * @param tags n array of NSStrings
 */
- (void)setCustomAnalyticsTags:(NSArray *)tags;

- (void)destroy;

#pragma mark Plugin registration and interaction

/**
 * Return an OoyalaAPIClient
 */
- (OOOoyalaAPIClient *)api;

@end

#endif /* OOOyalaPlayerFacade_h */
