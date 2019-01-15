//
//  OOPlayerState.h
//  OoyalaSDK
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef OOPlayerState_h
#define OOPlayerState_h

/**
 * Defines different gravity modes, which control how video is adjusted to available screen size
 */
typedef NS_ENUM(NSInteger, OOOoyalaPlayerVideoGravity) {
  /** Specifies that the video should be stretched to fill the layer’s bounds. */
  OOOoyalaPlayerVideoGravityResize,
  /** Specifies that the player should preserve the video’s aspect ratio and fit the video within the layer’s bounds */
  OOOoyalaPlayerVideoGravityResizeAspect,
  /** Specifies that the player should preserve the video’s aspect ratio and fill the layer’s bounds. */
  OOOoyalaPlayerVideoGravityResizeAspectFill
};

/**
 * Defines different possible player states
 */
typedef NS_ENUM(NSUInteger, OOOoyalaPlayerState) {
  /** Initial state, player is created but no content is loaded */
  OOOoyalaPlayerStateInit,
  /** Loading content */
  OOOoyalaPlayerStateLoading,
  /** Content is loaded and initialized, player is ready to begin playback */
  OOOoyalaPlayerStateReady,
  /** Player is playing a video */
  OOOoyalaPlayerStatePlaying,
  /** Player is paused, video is showing */
  OOOoyalaPlayerStatePaused,
  /** Player has finished playing content */
  OOOoyalaPlayerStateCompleted,
  /** Player has encountered an error, check OOOoyalaPlayer.error */
  OOOoyalaPlayerStateError
};

typedef NS_ENUM(NSInteger, OOOoyalaPlayerDesiredState) {
  /** user is playing a video */
  OOOoyalaPlayerDesiredStatePlaying,
  /** user is paused, video is showing */
  OOOoyalaPlayerDesiredStatePaused,
};

@interface OOOoyalaPlayerStateConverter : NSObject
/**
 * Converts PlayerState to a String.
 * @param[in] state the PlayerState
 * @returns an external facing state string
 */
+ (NSString *)playerStateToString:(OOOoyalaPlayerState)state;

/**
 * Converts PlayerDesiredState to a String.
 * @param[in] desiredState the PlayerState
 * @returns an external facing DesiredState string
 */
+ (NSString *)playerDesiredStateToString:(OOOoyalaPlayerDesiredState)desiredState;
@end


#endif /* OOPlayerState_h */
