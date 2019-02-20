//
//  OOExternNotifications.h
//  OoyalaSDK
//
//  Created on 12.12.2018.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#ifndef ExternNotifications_h
#define ExternNotifications_h

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
 * \brief The name used for notifications which fire when the closed captions are in manifest.
 * \details Nothing is provided through UserInfo.
 */
extern NSString *const OOOoyalaPlayerCCManifestChangedNotification;

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

/**
 * \memberof OOOoyalaPlayer
 * \brief Notificaation when video get connected or disconnected to airplay.
 * \details No additional data provided. This notification is for the user to know that phone is now connected or disconnected with airplay.
 */
extern NSString *const OOOoyalaplayerExternalPlaybackActiveNotification;

/** the string for live closed captions */
extern NSString *const OOLiveClosedCaptionsLanguage;

/**
 *  \memberof OOOoyalaPlayer
 *   \brief Notification when we handle vr metatag.
 *   \details UserInfo contains bool value "vrContent". YES if video is 360 otherwise NO
 */
extern NSString *const OOOoyalaPlayerVideoHasVRContent;

/**
 * \memberof OOOoyalaPlayer
 * \brief Notification when VR player did configured
 * \details No additional data provided.
 */

extern NSString *const OOOoyalaVRPlayerDidConfigured;

/**
 * \memberof OOOoyalaPlayer
 * \brief Notification when pressed switch between stereo and mono
 * \details No additional data provided.
 */

extern NSString *const OOOoyalaPlayerSwitchSceneNotification;

/**
 * \memberof OOOoyalaPlayer
 * \brief Notification when video view handle touch
 * \details Data contains touch coordinates and event name.
 */

extern NSString *const OOOoyalaPlayerHandleTouchNotification;

/**
 *  \memberof OOOoyalaPlayer
 *   \brief Notification when asset have multi audio.
 */
extern NSString *const OOOoyalaPlayerMultiAudioEnabledNotification;

/**
 *  \memberof OOOoyalaPlayer
 *   \brief Notification when audio track changed.
 */
extern NSString *const OOOoyalaPlayerAudioTrackChangedNotification;

/**
 *  \memberof OOOoyalaPlayer
 *   \brief Notification when received the ads metadata for SSAI.
 */
extern NSString *const OOOoyalaPlayerSsaiAdsMetadataReceivedNotification;

/**
 *  \memberof OOOoyalaPlayer
 *   \brief Notification when an ssai ad break has started.
 */
extern NSString *const OOOoyalaPlayerSsaiPlaySingleAdNotification;

/**
 *  \memberof OOOoyalaPlayer
 *   \brief Notification when an SSAI ad break has ended.
 */
extern NSString *const OOOoyalaPlayerSsaiSingleAdPlayedNotification;

/**
 *  \memberof OOOoyalaPlayer
 *   \brief Notification when asset is available for playback speed.
 */
extern NSString *const OOOoyalaPlayerPlaybackSpeedEnabledNotification;

/**
 *  \memberof OOOoyalaPlayer
 *   \brief Notification when playback speed rate changed.
 */
extern NSString *const OOOoyalaPlayerPlaybackSpeedRateChangedChangedNotification;

/**
 *  \memberof OOOoyalaPlayer
 *   \brief Notification when application volume changed.
 */
extern NSString *const OOOoyalaPlayerApplicationVolumeChangedNotification;

#endif /* ExternNotifications_h */
