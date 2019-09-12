//
//  OOStreamPlayer.h
//  OoyalaSDK
//
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

@import UIKit;

#import "OOPlayer.h"
#import "OOEnums.h"

#ifndef OOStreamPlayer_h
#define OOStreamPlayer_h

@class OOOoyalaPlayer;
@protocol OOPlayerInfo;

@interface OOStreamPlayer : OOPlayer {
  @protected
  OOSeekStyle _seekStyle;
}

@property (nonatomic, readonly) OOSeekStyle seekStyle;
@property (readonly, nonatomic, getter=isPiPActivated) BOOL pipActivated;

+ (id<OOPlayerInfo>)defaultPlayerInfo;
+ (void)setDefaultPlayerInfo:(id<OOPlayerInfo>)playerInfo;

- (BOOL)setup:(NSArray *)streams parent:(OOOoyalaPlayer *)parent;

/**
 * seek to time
 * @param time to seek
 * @param onCompletion a callback when seek is completed
 */
- (void)seekToTime:(Float64)time completion:(void (^)(void))onCompletion;

/**
 * toggle picture in picture mode
 */
- (void)togglePictureInPictureMode;

/**
 * Disables the CC in the HLS Playlist.
 */
- (void)disablePlaylistClosedCaptions;

@end

#endif /* OOStreamPlayer_h */
