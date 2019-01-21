//
//  OOEnums.h
//  OoyalaSDK
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#ifndef Enums_h
#define Enums_h

/**
 * Defines player behavior after video playback has ended, defaults to OOOoyalaPlayerActionAtEndContinue
 */
typedef NS_ENUM(NSInteger, OOOoyalaPlayerActionAtEnd) {
  /** Start playing next video if available, otherwise pause */
  OOOoyalaPlayerActionAtEndContinue,
  /** Pause at the end of the video */
  OOOoyalaPlayerActionAtEndPause,
  /** Stops at the end of the video and unloads the video from memory */
  OOOoyalaPlayerActionAtEndStop,
  /** Pause and reset to the beginning of the current video */
  OOOoyalaPlayerActionAtEndReset
};

/**
 * Defines which Ooyala API environment is used for API calls.
 * Defaults to OOOoyalaPlayerEnvironmentProduction and should never change for customer apps.
 */
typedef NS_ENUM(NSInteger, OOOoyalaPlayerEnvironment) {
  /** Ooyala production environment */
  OOOoyalaPlayerEnvironmentProduction,
  /** Ooyala staging environment */
  OOOoyalaPlayerEnvironmentStaging,
  /** Ooyala next-staging environment */
  OOOoyalaPlayerEnvironmentNextStaging,
  /** Ooyala local environment */
  OOOoyalaPlayerEnvironmentLocal
};

/** @internal
 * Defines different seek modes, which control the way seeking of the video is performed
 */
typedef NS_ENUM(NSInteger, OOSeekStyle) {
  /** @internal No seeking is allowed */
  OOSeekStyleNone,
  /** @internal Seeking is expensive and can only be performed at the end of user action */
  OOSeekStyleBasic,
  /** @internal Continous seeking is allowed */
  OOSeekStyleEnhanced
};

/**
 * Defines different slider UI styles
 * Defaults to OOOoyalaPlayerEnvironmentProduction and should never change for customer apps.
 */
typedef NS_ENUM(NSInteger, OOUIProgressSliderMode) {
  OOUIProgressSliderModeLive,
  OOUIProgressSliderModeAdInLive,
  OOUIProgressSliderModeNormal,
  OOUIProgressSliderModeLiveNoSrubber,
  OOUIProgressSliderModeElapsedDuration
};

/**
 Defines states for Ooyala Analytics (IQ) tracking.

 - OOIQAnalyticsTrackingStateDefault:
 Analytics is enabled and sends data to analytics servers
 Device guid will stay same until app is present on phone.
 Device guid will be stored in local storage
 - OOIQAnalyticsTrackingStateDisabled:
 Analytics will be completely disabled and no data will be send to analytics servers
 - OOIQAnalyticsTrackingStateAnonymous:
 Analytics data will be send to analytics servers
 Each time video plays new device guid will be generated
 Device guid will NOT be stored on device.
 */
typedef NS_ENUM(NSUInteger, OOIQAnalyticsTrackingState) {
  OOIQAnalyticsTrackingStateDefault,
  OOIQAnalyticsTrackingStateDisabled,
  OOIQAnalyticsTrackingStateAnonymous,
};

#endif /* Enums_h */
