//
//  OOOyalaPlayerInternal.h
//  OoyalaSDK
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#ifndef OOOyalaPlayerFacade_h
#define OOOyalaPlayerFacade_h

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
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
@protocol OOEmbedTokenGenerator;

/**
 * \defgroup key Most Commonly Used Classes
 * \defgroup item Content Item
 * \defgroup performance Performance Utilities
 * \defgroup captions Captions
 * \defgroup vast VAST-Specific
 * \defgroup offline Offline Playback (DTO)
 */

#define OOOOYALAPLAYER_DURATION_MISSING (-1)

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
+ (void)setEnvironment:(OOOoyalaPlayerEnvironment)e;

/**
 * Set if SSL is used for Player APIs. Default YES
 */
+ (void)setSSLEnvironmentEnabled:(BOOL)sslEnabled;

/**
 * Get the version and RC of the Ooyala SDK
 * @returns the string that represents the SDK version
 */
+ (NSString *)version;

/**
 * @returns YES means to try to use local/debug DRM modes,
 * NO means to use regular DRM config.
 */
+ (BOOL)useDebugDRMPlayback;


/**
 * set encryptedloopback.
 * @param[in] enabled true if enabled, false if disabled
 */
+ (void)setEncryptedLoopback:(BOOL)enabled;

/**
 * get encryptedloopback.
 * @returns encryptedLoopback;
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
 @param[in] state The IQ analytics state
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
 * @returns a string containing the current state
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
 * @param[in] apiClient the initialized OOOoyalaAPIClient to use
 * @returns the initialized OOOoyalaPlayer
 */
- (instancetype)initWithOoyalaAPIClient:(OOOoyalaAPIClient *)apiClient;

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param[in] pcode Your Provider Code
 * @param[in] domain Your Embed Domain
 * @returns the initialized OOOoyalaPlayer
 */
- (instancetype)initWithPcode:(NSString *)pcode
                       domain:(OOPlayerDomain *)domain;

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param[in] pcode Your Provider Code
 * @param[in] domain Your Embed Domain
 * @param[in] options the options
 * @returns the initialized OOOoyalaPlayer
 */
- (instancetype)initWithPcode:(NSString *)pcode
                       domain:(OOPlayerDomain *)domain
                      options:(OOOptions *)options;

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param[in] pcode Your Provider Code
 * @param[in] domain Your Embed Domain
 * @param[in] embedTokenGenerator the initialized OOEmbedTokenGenerator to use
 * @returns the initialized OOOoyalaPlayer
 */
- (instancetype)initWithPcode:(NSString *)pcode
                       domain:(OOPlayerDomain *)domain
          embedTokenGenerator:(id<OOEmbedTokenGenerator>)embedTokenGenerator;

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param[in] pcode Your Provider Code
 * @param[in] domain Your Embed Domain
 * @param[in] embedTokenGenerator the initialized OOEmbedTokenGenerator to use
 * @param[in] options Extra settings
 * @returns the initialized OOOoyalaPlayer
 */
- (instancetype)initWithPcode:(NSString *)pcode
                       domain:(OOPlayerDomain *)domain
          embedTokenGenerator:(id<OOEmbedTokenGenerator>)embedTokenGenerator
                      options:(OOOptions*)options;


#pragma mark Content Setters

- (void)setDesiredState:(OOOoyalaPlayerDesiredState)desiredState;

/**
 * @param[in] stream non-nil, non-empty NSArray containing OOStreams.
 */
- (BOOL)setStream:(OOStream*)stream;

/**
 * @param[in] streams non-nil, non-empty NSArray containing OOStreams.
 */
- (BOOL)setStreams:(NSArray*)streams;

/**
 * Casting of OOUnbundledVideo is not supported.
 * @param[in] unbundledVideo non-nil OOUnbundledVideo containing OOStreams.
 */
- (BOOL)setUnbundledVideo:(OOUnbundledVideo*)unbundledVideo;

/**
 * Reinitializes the player with a new embedCode.
 * @param[in] embedCode the embed code to use
 * @returns YES if successful; otherwise, returns NO (check OOOoyalaPlayer.error for reason)
 */
- (BOOL)setEmbedCode:(NSString *)embedCode;

/**
 * Reinitializes the player with the new embedCodes (as an array).
 * @param[in] embedCodes the embed code(s) to use. If more than one is specified, OOOoyalaPlayer.rootItem becomes a OODynamicChannel.
 * @returns YES if successful; otherwise, returns NO (check OOOoyalaPlayer.error for reason)
 */
- (BOOL)setEmbedCodes:(NSArray *)embedCodes;

/**
 * Reinitializes the player with a new embedCode and sets the ad set dynamically.
 * @param[in] embedCode the embed code to use
 * @param[in] adSetCode (possibly nil) the ad set code to use
 * @returns YES if successful; otherwise, returns NO (check OOOoyalaPlayer.error for reason)
 */
- (BOOL)setEmbedCode:(NSString *)embedCode adSetCode:(NSString *)adSetCode;

/**
 * Reinitializes the player with the new embedCodes (as an array) and sets the ad set dynamically.
 * @param[in] embedCodes the embed code(s) to use. If more than one is specified, OOOoyalaPlayer.rootItem becomes a OODynamicChannel.
 * @param[in] adSetCode (possibly nil) the ad set code to use.
 * @returns YES if successful; otherwise, returns NO (check OOOoyalaPlayer.error for reason)
 */
- (BOOL)setEmbedCodes:(NSArray *)embedCodes adSetCode:(NSString *)adSetCode;

/**
 * Reinitializes the player with a new external ID. External IDs enable you to assign custom identifiers to your assets so they are easier to organize, update, and modify.
 * @param[in] externalId the external ID to use
 * @returns YES if successful; otherwise, returns NO (check OOOoyalaPlayer.error for reason)
 */
- (BOOL)setExternalId:(NSString *)externalId;

/**
 * Reinitializes the player with the new external IDs (as an array). External IDs enable you to assign custom identifiers to your assets so they are easier to organize, update, and modify.
 * @param[in] externalIds the external ID(s) to use. If more than one is specified, OOOoyalaPlayer.rootItem becomes a OODynamicChannel.
 * @returns YES if successful; otherwise, returns NO (check OOOoyalaPlayer.error for reason)
 */
- (BOOL)setExternalIds:(NSArray *)externalIds;

/**
 * Reinitializes the player with a root item.
 * @param[in] theRootItem the root item to use
 */
- (void)setRootItem:(OOContentItem *)theRootItem;

/**
 * Reinitializes the player with a new asset JSON.
 * @param[in] asset the new asset JSON to use
 */
- (void)setAsset:(NSDictionary *)asset;

/**
 * Sets the current video in a channel, if the video is present.
 * @param[in] embedCode the embed code of the video to play
 * @returns YES if successful; otherwise, returns NO (check OOOoyalaPlayer.error for reason)
 */
- (BOOL)changeCurrentItemToEmbedCode:(NSString *)embedCode;

/**
 * Sets the current video.  OOVideo must be a part of the content tree provided by the root item.
 * @returns a BOOL indicating that the item was successfully changed
 */
- (BOOL)changeCurrentItemToVideo:(OOVideo *)video;

/**
 * Set the unbundled HA video.
 * @returns a BOOL indicating that the item was successfully changed
 */
- (BOOL) changeUnbundledVideo:(OOVideo *)video;

/**
 Performs authorization on the current item, refreshing teh auth token if necessary

 @param callback a callback with error if present
 */
- (void)reauthorizeCurrentItemWithCallback:(OOAuthorizeCallback)callback;

#pragma mark During-playback status

/**
 * Gets the player's current state.
 * @returns a string containing the current state
 */
- (OOOoyalaPlayerState)state;

#pragma mark Playback Actions

/**
 * DEPRECATED. Sets a tag for custom analytics.
 * @param[in] tags n array of NSStrings
 */
- (void)setCustomAnalyticsTags:(NSArray *)tags;

- (void)destroy;

#pragma mark Plugin registration and interaction

/**
 * Return an OoyalaAPIClient
 */
- (OOOoyalaAPIClient *)api;

/**
 Returns a string with all the actions made by offline analytics
 @param[in] embedCode of the offline file
 @returns a string with a list of the actions
 */
- (NSString *)dataFromFile:(NSString *)embedCode;

@end

#endif /* OOOyalaPlayerFacade_h */
