/**
 @file  OOAnalyticsPluginProtocol.h
 @brief A protocol that can be used to plug an Analytics reporter into the OOOoyalaPlayer

 @details Your Analytics plugin may require more functionality than is reported here.  If this is the case
 you can additionally observe OoyalaPlayer, and report any other metrics through the observation chain

 You should most likely NOT implement this interface, and instead extend OOAnalyticsPluginBaseImpl

 @copyright Copyright © 2016 Ooyala, Inc. All rights reserved.
 */

@import Foundation;

typedef NS_ENUM(NSInteger, OOBitrateState) {
  /** Bitrate after the play has started */
  OOBitrateStateInitial,
  /** Bitrate after 5 seconds */
  OOBitrateStateFiveSeconds,
  /** Bitrate after 30 seconds */
  OOBitrateStateStable
};

@class OOVideo;
@class OOSeekInfo;
@class OOOoyalaError;

@protocol OOAnalyticsPluginProtocol <NSObject>
/**
 This is called when content is about to play
 */
- (void)onCurrentItemAboutToPlay:(OOVideo *)video;
/**
 Called during the first time video starts playing back after the video is changed
 */
- (void)reportPlayStarted;
/**
 Called when video content is paused
 */
- (void)reportPlayPaused;
/**
 Called when video content is resumed from paused state
 */
- (void)reportPlayResumed;
/**
 Called when video playback is completed
 */
- (void)reportPlayCompleted;
/**
 Called when the Plugin is registered, effectively reporting when the player is loaded
 */
- (void)reportPlayerLoad;
/**
 Called whenever the Player reports a playhead change

 @param playheadTime a time to report
 */
- (void)reportPlayheadUpdate:(Float64)playheadTime;
/**
 Called during the first time video starts playing back after a video was Completed
 */
- (void)reportReplay;
/**
 Called whenever the user or application calls @c OoyalaPlayer.play()
 */
- (void)reportPlayRequestedWithAutoplay:(BOOL)autoplay;
/**
 Called whenever the user seeks the video
 */
- (void)reportSeekStarted:(OOSeekInfo *)seekInfo;
/**
 Called when an API error occurs

 @param ooyalaError an error to report
 */
- (void)reportApiError:(OOOoyalaError *)ooyalaError;
/**
 Called for reporting current bitrate of a player

 @param bitrate a bitrate to report
 @param bitrateState a state when bitrate is measured
 */
- (void)reportBitrate:(double)bitrate
      forBitrateState:(OOBitrateState)bitrateState;
/**
 Called when buffering has started
 */
- (void)reportBufferingStarted;
/**
 Called when buffering has ended
 */
- (void)reportBufferingEnded;

@end
