#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OOSignatureGenerator.h"
#import "OOSecureURLGenerator.h"
#import "OOCallbacks.h"
#import "OOEmbedTokenGenerator.h"
#import "OOClosedCaptionsStyle.h"
#import "OOAdPluginManagerProtocol.h"
#import "OOStateNotifier.h"
#import "OOPlayerProtocol.h"
#import "OOStream.h"
#import "OOUnbundledVideo.h"
#import "OOAudioTrack.h"

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
@class OOUserInfo;
@class OOPlayer;
@protocol OOAudioTrackProtocol;

/**
 * \defgroup key Most Commonly Used Classes
 * \defgroup item Content Item
 * \defgroup performance Performance Utilities
 * \defgroup captions Captions
 * \defgroup vast VAST-Specific
 * \defgroup offline Offline Playback (DTO)
 */

/**
 * Defines player behavior after video playback has ended, defaults to OOOoyalaPlayerActionAtEndContinue
 */
typedef enum
{
    /** Start playing next video if available, otherwise pause */
    OOOoyalaPlayerActionAtEndContinue,
    /** Pause at the end of the video */
    OOOoyalaPlayerActionAtEndPause,
    /** Stops at the end of the video and unloads the video from memory */
    OOOoyalaPlayerActionAtEndStop,
    /** Pause and reset to the beginning of the current video */
    OOOoyalaPlayerActionAtEndReset
} OOOoyalaPlayerActionAtEnd;

/**
 * Defines which Ooyala API environment is used for API calls.
 * Defaults to OOOoyalaPlayerEnvironmentProduction and should never change for customer apps.
 */
typedef enum
{
  /** Ooyala production environment */
  OOOoyalaPlayerEnvironmentProduction,
  /** Ooyala staging environment */
  OOOoyalaPlayerEnvironmentStaging,
  /** Ooyala next-staging environment */
  OOOoyalaPlayerEnvironmentNextStaging,
  /** Ooyala local environment */
  OOOoyalaPlayerEnvironmentLocal
} OOOoyalaPlayerEnvironment;

/** @internal
 * Defines different seek modes, which control the way seeking of the video is performed
 */
typedef enum {
  /** @internal No seeking is allowed */
  OOSeekStyleNone,
  /** @internal Seeking is expensive and can only be performed at the end of user action */
  OOSeekStyleBasic,
  /** @internal Continous seeking is allowed */
  OOSeekStyleEnhanced
} OOSeekStyle;

/**
 * Defines different slider UI styles
 * Defaults to OOOoyalaPlayerEnvironmentProduction and should never change for customer apps.
 */
typedef NS_ENUM(NSInteger, OOUIProgressSliderMode)
{
  OOUIProgressSliderModeLive,
  OOUIProgressSliderModeAdInLive,
  OOUIProgressSliderModeNormal,
  OOUIProgressSliderModeLiveNoSrubber,
  OOUIProgressSliderModeElapsedDuration
};

#define OOOOYALAPLAYER_DURATION_MISSING (-1)

#pragma mark Notification Names

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications when playhead time changes.
 * \details Nothing is provided through UserInfo. You can get the time with OOoyalaPlayer.playheadTime
 * @see OOOoyalaPlayer.playheadTime
 */
extern NSString *const OOOoyalaPlayerTimeChangedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications when the player's state changes.
 * \details UserInfo is a dictionary with a key @"newState" with a value of OOOoyalaPlayerState.
 */
extern NSString *const OOOoyalaPlayerStateChangedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications when the player's desired state changes.
 * \details UserInfo is a dictionary with a key @"newState" with a value of OOOoyalaPlayerDesiredState.
 */
extern NSString *const OOOoyalaPlayerDesiredStateChangedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications when the upcoming asset's content tree is ready and can be accessed.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerContentTreeReadyNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications when the upcoming asset's metadata is ready and can be accessed.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerMetadataReadyNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications when the upcoming asset's authorization status is ready and can be accessed.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerAuthorizationReadyNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications when all of the upcoming asset's metadata is ready, and the item is ready to be played.
 * \details Nothing is provided through UserInfo.
 * @see currentItem
 */
extern NSString *const OOOoyalaPlayerCurrentItemChangedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications when video playback starts.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerPlayStartedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire after a successful license acquisition.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaplayerLicenseAcquisitionNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when video playback is completed.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerPlayCompletedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when an ad overlay should be displayed.
 * \details Nothing is provided through UserInfo. This applies to Ooyala-managed VAST Advertisements only.
 */
extern NSString *const OOOoyalaPlayerAdOverlayNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when an ad manager has control of the OoyalaPlayer.
 * \details Nothing is provided through UserInfo. Ads may or may not play during this time.
 */
extern NSString *const OOOoyalaPlayerAdPodStartedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when a linear advertisement starts playing back.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerAdStartedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when a linear advertisement has been completed.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerAdCompletedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when an ad manager has ceded control of the OoyalaPlayer, and content should resume.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerAdPodCompletedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when ads are completed loading.
 * \details Nothing is provided through UserInfo. This only applies to Freewheel and Pulse advertisements.
 */
extern NSString *const OOOoyalaPlayerAdsLoadedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when an advertisement is skipped.
 * \details Nothing is provided through UserInfo. This only applies to VAST advertisements.
 */
extern NSString *const OOOoyalaPlayerAdSkippedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when an advertisement is tapped (IMA only).
 * \details Nothing is provided through UserInfo. This only applies to IMA advertisements.
 */
extern NSString *const OOOoyalaPlayerAdTappedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when content should resume after an advertisement.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerContentResumedAfterAdNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when an irrecoverable error occurs.
 * \details Nothing is provided through UserInfo. You should check the error when you get this.
 * @see error
 */
extern NSString *const OOOoyalaPlayerErrorNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when a recoverrable error occurs during an ad.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerAdErrorNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when the closed captions language is changed.
 * \details Nothing is provided through UserInfo. You can get the language from closedCaptionsLanguage.
 * @see closedCaptionsLanguage
 */
extern NSString *const OOOoyalaPlayerLanguageChangedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when seek is initialized.
 * \details UserInfo is a dictionary with a key @"newState" with a value of a OOSeekInfo object.
 * @see OOSeekInfo
 */
extern NSString *const OOOoyalaPlayerSeekStartedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when seek is completed.
 * \details UserInfo is a dictionary with a key @"newState" with a value of a OOSeekInfo object. The seekStartTime of the object is not set for this notification.
 * @see OOSeekInfo
 */
extern NSString *const OOOoyalaPlayerSeekCompletedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire JSON is received (i.e. ID3 tags).
 * \details UserInfo is a dictionary with keys and values that were all in the JSON from the ID3 tag.
 */
extern NSString *const OOOoyalaPlayerJsonReceivedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire the Embed Code (aka Content ID) has been changed.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerEmbedCodeSetNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when cast device volume changed.
 * \details Nothing is provided through UserInfo. This happens only during Chromecast playback, when the Chromecast volume is affected by a different sender device.
 */
extern NSString *const OOOoyalaPlayerCastVolumeChangeNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief The name used for notifications which fire when bitrate has changed in video playback.
 * \details Nothing is provided through UserInfo. You should be able to check OOOoyalaPlayer.bitrate for a new value.
 */
extern NSString *const OOOoyalaPlayerBitrateChangedNotification;


/**
 * \memberof OOOoyalaPlayer
 * \brief Notification when buffering starts in the player.
 * \details No additional data provided. This notification is for the user to know that the current buffer of the player is empty and it is trying to get more data to resume playback.
 */
extern NSString *const OOOoyalaPlayerBufferingStartedNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief Notification when buffering completes in the player.
 * \details No additional data provided. This notification is for the user to know that the current buffer of the player is full and it is ready to resume playback.
 */
extern NSString *const OOOoyalaPlayerBufferingCompletedNotification;

/** the string for live closed captions */
extern NSString *const OOLiveClosedCaptionsLanguage;

/**
 * The OoyalaPlayer is the heart of the playback system.
 * Use it to configure and control asset playback, and to be aware of playback state changes.
* \ingroup key
 */
@interface OOOoyalaPlayer : NSObject<OOAdPluginManagerProtocol, OOAudioTrackProtocol>

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
 * Converts PlayerState to a String.
 * @param[in] state the PlayerState
 * @returns an external facing state string
 */
+ (NSString *)playerStateToString:(OOOoyalaPlayerState)state;


/**
 * Converts PlayerDesiredState to a String.
 * @param[in] state the PlayerState
 * @returns an external facing DesiredState string
 */
+ (NSString *)playerDesiredStateToString:(OOOoyalaPlayerDesiredState)desiredState;

/**
 * @returns YES means to try to use local/debug DRM modes,
 * NO means to use regular DRM config.
 */
+(BOOL)useDebugDRMPlayback;


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
+(void)setUseDebugDRMPlayback:(BOOL)enable;

#pragma mark Properties

@property(readonly, nonatomic, strong) OOVideo *currentItem; /**< The OOOoyalaPlayer's currently playing OOVideo */
@property(readonly, nonatomic, strong) OOContentItem *rootItem; /**< The OOOoyalaPlayer's embedded content (OOVideo, OOChannel, or OOChannelSet) */
@property(readonly, nonatomic, strong) NSDictionary *metadata; /**< The OOOoyalaPlayer's content metadata for currently loaded content */
@property(readonly, nonatomic, strong) OOOoyalaError *error; /**< The OOOoyalaPlayer's current error if it exists */
@property(readonly, nonatomic, strong) UIView *view; /**< the view associated with the player*/
@property(nonatomic) OOOoyalaPlayerVideoGravity videoGravity;
@property(readonly, nonatomic) BOOL supportsVideoGravityButton;
@property(nonatomic) BOOL seekable; /**< Whether or not the Videos that OOOoyalaPlayer plays are seekable */
@property(nonatomic) BOOL adsSeekable; /**< Whether or not the Ads that OOOoyalaPlayer plays are seekable */
@property(readonly, nonatomic) OOSeekStyle seekStyle;
@property(nonatomic, strong) NSString *closedCaptionsLanguage; /**< the current closed captions language, or nil to hide closed captions. */
/**
 * Get whether the player is playing the audio only stream in an m3u8
 */
@property(readonly, nonatomic) BOOL isAudioOnlyStreamPlaying;
@property(readonly, nonatomic, getter = isClosedCaptionsTrackAvailable) BOOL closedCaptionsTrackAvailable;
@property(nonatomic, strong) OOCurrentItemChangedCallback currentItemChangedCallback; /**< A callback that will be called every time the current item is changed */

@property (nonatomic) OOOoyalaPlayerActionAtEnd actionAtEnd; /**< the OOOoyalaPlayerActionAtEnd to perform when the current item finishes playing. */
@property (readonly, nonatomic, getter = isExternalPlaybackActive) BOOL externalPlaybackActive;

@property (nonatomic) BOOL allowsExternalPlayback;
@property (nonatomic) float playbackRate; /**< the rate of playback. 1 is the normal speed.  Set to .5 for half speed, 2 for double speed, etc. */
@property (readonly, nonatomic) NSString *authToken; /**< The Auth Token provided by Ooyala Authorization, when using Ooyala Player Token */

/**
 * The volume of the OoyalaPlayer, relative to the device's volume setting.
 * For example, if volume is 1.0 (default), the playback volume would be as loud as the device's volume.
 * The volume set here will affect Content, Ooyala, Pulse, and VAST ad playback.  It will not affect other ad managers.
 * This property can be changed at any point after the OoyalaPlayer is initialized
 */
@property (nonatomic) float volume;


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

#pragma mark Initializers

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param[in] apiClient the initialized OOOoyalaAPIClient to use
 * @returns the initialized OOOoyalaPlayer
 */
- (id)initWithOoyalaAPIClient:(OOOoyalaAPIClient *)apiClient;

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param[in] pcode Your Provider Code
 * @param[in] domain Your Embed Domain
 * @returns the initialized OOOoyalaPlayer
 */
- (id)initWithPcode:(NSString *)pcode
             domain:(OOPlayerDomain *)domain;

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param[in] pcode Your Provider Code
 * @param[in] domain Your Embed Domain
 * @param[in] options the options
 * @returns the initialized OOOoyalaPlayer
 */
- (id)initWithPcode:(NSString *)pcode
             domain:(OOPlayerDomain *)domain
            options:(OOOptions *)options;

/**
 * Initialize an OOOoyalaPlayer with the given parameters
 * @param[in] pcode Your Provider Code
 * @param[in] domain Your Embed Domain
 * @param[in] embedTokenGenerator the initialized OOEmbedTokenGenerator to use
 * @returns the initialized OOOoyalaPlayer
 */
- (id)initWithPcode:(NSString *)pcode
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
- (id)initWithPcode:(NSString *)pcode
             domain:(OOPlayerDomain *)domain
embedTokenGenerator:(id<OOEmbedTokenGenerator>)embedTokenGenerator
            options:(OOOptions*)options;


#pragma mark Content Setters

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
 * Performs authorization on the current item, refreshing teh auth token if necessary
 * @returns an OOAsyncTask that can be cancelled if necessary
 */
- (id)reauthorizeCurrentItemWithCallback:(OOAuthorizeCallback)callback;

#pragma mark During-playback status

/**
 * Checks the expiration of the authToken, and compares it to the current time.
 * @returns YES if token is expired, NO otherwise
 */
- (BOOL) isAuthTokenExpired;

/**
 * Gets the current playhead time (the part of the video currently being accessed).
 * @returns the current playhead time, in milliseconds
 */
- (Float64)playheadTime;

/**
 * Gets the  (approximate) real time of a live stream
 * @returns currently playing time
 */
- (NSDate *)liveTime;

/**
 * Gets the duration of the asset.
 * @returns the duration of the currently playing asset, in seconds
 */
- (Float64)duration;

/**
 * current seekable range for main video.
 */
- (CMTimeRange) seekableTimeRange;

/**
 * Get the maximum buffered time
 * @returns the buffered time in seconds of the currently playing item
 */
- (Float64)bufferedTime;

/**
 * Sets the current playhead time of the player (same as seek). For example, to start a video at the 30 second point, you would set the playhead to 30.
 * @param[in] time the playhead time, in seconds
 */
- (void)setPlayheadTime:(Float64) time;

/**
 * Gets the player's current state.
 * @returns a string containing the current state
 */
- (OOOoyalaPlayerState)state;

/**
 * Get whether the player is playing
 * @returns a BOOL indicating the current player is playing
 */
- (BOOL)isPlaying;

/**
 * Get whether the player is playing ad
 * @returns a BOOL indicating the current player is playing ad
 */
- (BOOL)isShowingAd;

/**
 * @return YES if self.isShowingAd==YES and the ad player reports that
 * it has custom controls, instead of using the Ooyala video controls.
 */
- (BOOL)isShowingAdWithCustomControls;

/**
 Lets you know if the current video has multiple audio tracks.
 
 It requires that a video has already loaded.
 
 The following code snippet shows an example of this method. It assumes you are listening
 to the events of the OOOoyalaPlayer using notifications:
@code
// assumes you are observing OOOoyalaPlayer notifications and you have a property
// like `@property OOOoyalaPlayer *player;`
if ([notification.name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
  NSNumber *state = notification.userInfo[@"newState"];
  if (state.intValue == OOOoyalaPlayerStateReady) {
    NSLog(@"has audio tracks: %d", [self.player hasMultipleAudioTracks]);
  }
}
@endcode

 @return true if there are more than one audio tracks, false otherwise.
 */
- (BOOL)hasMultipleAudioTracks;

/**
 * Get the available closed captions languages
 * @returns an NSArray containing the available closed captions languages as NSStrings
 */
- (NSArray *)availableClosedCaptionsLanguages;

/**
 * Get the short code from the natural language name. Example: name="english", code="en".
 * @param name is the long name, from availableClosedCaptionsLanguages.
 * @return the short cc code. If the reverse mapping fails, the original name parameter value is returned.
 */
-(NSString*)languageNameToLanguageCode:(NSString*)name;

/**
 * Get the current bitrate
 * @returns a double indicating the current bitrate in bytes
 */
- (double)bitrate;

#pragma mark UI-specific apis

/**
 * Return a collection of the times at which to show cue points.
 * E.g. for the content player, show when ads are scheduled to play.
 */
-(NSSet*/*<NSNumber int seconds>*/)getCuePointsAtSecondsForCurrentPlayer;

/**
 * @returns the video rect
 */
- (CGRect)videoRect;

/**
 * internal Ooyala use only.
 */
-(void) layoutSubviews;

#pragma mark Playback Actions

/**
 * Pauses the current video.
 */
- (void)pause;

/**
 * Plays the current video.
 */
- (void)play;

 /**
  * Plays the current video with an initial time
  */
- (void)playWithInitialTime:(Float64) time;

/**
 * Sets the current playhead time of the player (same as setPlayheadTime).
 * @param[in] time the playhead time, in seconds
 */
- (void)seek:(Float64) time;

/**
 * Tries to set the current video to the next video in the OOChannel or ChannetSet
 * @returns a BOOL indicating that the item was successfully changed
 */
- (BOOL)nextVideo;

/**
 * Tries to set the current video to the previous video in the OOChannel or ChannetSet
 * @returns a BOOL indicating that the item was successfully changed
 */
- (BOOL)previousVideo;
/**
 * Reset the state of ad plays. Calling this will cause all ads which have been played to play again.
 */
- (void)resetAds;

/**
 * Skips the currently playing ad (if one is playing. does nothing if not)
 */
- (void)skipAd;

/**
 * Click on the currently playing ad
 */
- (void)clickAd;

/**
 * DEPRECATED. Sets a tag for custom analytics.
 * @param[in] tags n array of NSStrings
 */
- (void)setCustomAnalyticsTags:(NSArray *)tags;


/**
 * Called when an icon is clicked
 * @param index the index of the icon
 */
- (void)onAdIconClicked: (NSInteger) index;

/**
 * Called when an ad overlay is clicked
 * @param clickUrl the url of the overlay
 */
- (void)onAdOverlayClicked: (NSString *)clickUrl;

/**
 * Insert VAST ads to the managed ad plugin
 * @param ads the ads to be inserted
 */
- (void)insertAds:(NSMutableArray *)ads;

/**
 * Toggle the picture in picture mode
 * iOS 9 and up only
 */
- (void)togglePictureInPictureMode;

- (void)destroy;

#pragma mark Plugin registration and interaction

/**
 * Register ad player for an ad type
 * @param[in] adPlayerClass the ad player class
 * @param[in] adClass the ad class
 */
- (void)registerAdPlayer:(Class)adPlayerClass forType:(Class)adClass;

/**
 * Called by an ad plugin to create a state notifier
 *
 */
- (OOStateNotifier *)createStateNotifier;

- (void)initCastManager:(OOCastManager *)castManager;

- (void)switchToCastMode;

- (void)exitCastModeWithEmbedCode:(NSString *)embedCode playheadTime:(Float64)playheadTime isPlaying:(BOOL)isPlaying;

- (BOOL)isInCastMode;

/**
 * Return an OoyalaAPIClient
 */
- (OOOoyalaAPIClient *)api;
/**
 * Return an OOUserInfo
 */
- (OOUserInfo *)userInfo;

@end
