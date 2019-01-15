//
//  OOOoyalaPlayer+Channel.h
//  OoyalaSDK
//
//  Created on 10/31/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"

#ifndef OOOoyalaPlayer_Channel_h
#define OOOoyalaPlayer_Channel_h

@interface OOOoyalaPlayer (Channel)

/**
 * Tries to set the current video to the next video in the OOChannel or ChannetSet
 * @returns a BOOL indicating that the item was successfully changed
 */
- (BOOL)nextVideo;

/**
 * Tries to set the current video to the previous video in the OOChannel or ChannetSet
 * @returns a BOOL indicating that the item was successfully changed
 */
- (BOOL)previousVideo;

/**
 * @returns current frame of current asset
 */
- (UIImage *)screenshot;

@end

#endif /* OOOoyalaPlayer_Channel_h */
