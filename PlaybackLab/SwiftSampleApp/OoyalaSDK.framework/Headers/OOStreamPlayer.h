//
//  OOStreamPlayer.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OOPlayer.h"
#import "OOPlayerInfo.h"

@interface OOStreamPlayer : OOPlayer
@property OOSeekStyle seekStyle;
+ (id<OOPlayerInfo>) defaultPlayerInfo;
+ (void) setDefaultPlayerInfo:(id<OOPlayerInfo>) playerInfo;

- (BOOL)setup:(NSArray *)streams parent:(OOOoyalaPlayer*)parent;
- (id<OOPlayerInfo>)playerInfo;

/**
 * seek to time
 * @param[in] time to seek
 * @param[in] onCompletion a callback when seek is completed
 */
- (void)seekToTime:(Float64)time completion:(void (^)())onCompletion;

@end
