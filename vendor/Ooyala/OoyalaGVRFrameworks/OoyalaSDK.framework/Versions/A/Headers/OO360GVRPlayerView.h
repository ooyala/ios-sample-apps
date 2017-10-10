//
//  OO360GVRPlayerView.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayerView.h"


@interface OO360GVRPlayerView : OOOoyalaPlayerView

/**
 * An enum whose cases describe how a user can change the video type.
 */
typedef enum {
  Mono,
  Stereo,
} OO360VideoType;

@property (nonatomic, assign) OO360VideoType videoType;

/**
 * Switch mono/stereo type
 */
- (void)switchVideoType:(OO360VideoType)type;

/**
 * Pause or resume the render loop.
 */
- (void)setPaused:(BOOL)paused;

@end
