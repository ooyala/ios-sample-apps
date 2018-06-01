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
typedef NS_ENUM(NSInteger, OO360VideoType) {
  Mono,
  Stereo,
};

@property (nonatomic, assign) OO360VideoType videoType;

/**
 * Switch mono/stereo type
 */
- (void)switchVideoType:(OO360VideoType)type;

/**
 * Pause or resume the render loop.
 */
- (void)setPaused:(BOOL)paused;

/**
 * Set hidden internal render views.
 */
- (void)setHidden:(BOOL)hidden;

@end
