/**
 * @file  OOAnalyticsPluginProtocol.h
 * @brief A protocol that can be used to plug an Analytics reporter into the OOOoyalaPlayer
 *
 * @details Your Analytics plugin may require more functionality than is reported here.  If this is the case
 * you can additionally observe OoyalaPlayer, and report any other metrics through the observation chain
 *
 * You should most likely NOT implement this interface, and instead extend OOAnalyticsPluginBaseImpl
 *
 * @copyright Copyright (c) 2016 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOOoyalaPlayer.h"
#import "OOLifeCycle.h"
#import "OOSeekInfo.h"

@protocol OOAnalyticsPluginProtocol <NSObject>

/**
 * This is called when content is about to play
 */
- (void)onCurrentItemAboutToPlay:(OOVideo *)video;

/**
 * Called during the first time video starts playing back after the video is changed
 */
- (void)reportPlayStarted;

/**
 * Called when video content is paused
 */
- (void)reportPlayPaused;

/**
 * Called when video content is resumed from paused state;
 */
- (void)reportPlayResumed;

/**
 * Called when video playback is completed
 */
- (void)reportPlayCompleted;

/**
 * Called when the Plugin is registered, effectively reporting when the player is loaded
 */
- (void)reportPlayerLoad;

/**
 * Called whenever the Player reports a playhead change
 */
- (void)reportPlayheadUpdate:(Float64)playheadTime;

/**
 * Called during the first time video starts playing back after a video was Completed
 */
- (void)reportReplay;

/**
 * Called whenever the user or application calls OoyalaPlayer.play()
 */
- (void)reportPlayRequested;
/**
 * Called whenever the user seeks the video
 */
- (void)reportSeekStarted:(OOSeekInfo *)seekInfo;

@end
