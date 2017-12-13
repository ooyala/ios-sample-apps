//
//  OOPulseAdError.h
//  Pulse
//
//  Created by Jacques du Toit on 11/11/15.
//  Copyright © 2015 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Potential errors encountered trying to play an ad.
typedef NS_ENUM(NSInteger, OOPulseAdError) {
  /// The request for the ad's media file did not return a valid response.
  OOPulseAdErrorRequestFailed = 0,
  /// The request for the ad's media file did not complete, or playback timed out.
  OOPulseAdErrorTimedOut,
  /// The ad did not contain any supported media file formats.
  OOPulseAdErrorNoSupportedMediaFile,
  /// The video player could not display the ad's media file.
  OOPulseAdErrorCouldNotPlay,
  /// The ad type (OOPulsePauseAd, OOPulseVideoAd etc.) is not supported
  OOPulseAdErrorNotSupported
};