//
//  IMAAVPlayerVideoDisplay.h
//  GoogleIMA3
//
//  Copyright (c) 2013 Google Inc. All rights reserved.
//
//  Declares an object that reuses an AVPlayer for both content and ad playback

#import <UIKit/UIKit.h>

#import "IMAVideoDisplay.h"

@class AVPlayer;

/**
 *  An implementation of the IMAVideoDisplay protocol. This object is intended
 *  to be initialized with the content player, and will reuse the player for
 *  playing ads.
 */
@interface IMAAVPlayerVideoDisplay : NSObject <IMAVideoDisplay>

/**
 *  The content player used for both content and ad video playback.
 */
@property(nonatomic, strong, readonly) AVPlayer *player;

/**
 *  Creates an IMAAVPlayerVideoDisplay that will play ads in the passed in
 *  content player.
 *
 *  @param player the AVPlayer instance used for playing content
 *
 *  @return an IMAAVPlayerVideoDisplay instance
 */
- (instancetype)initWithAVPlayer:(AVPlayer *)player;

- (instancetype)init NS_UNAVAILABLE;

@end
