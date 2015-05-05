/**
 * @protocol   OOPlayableItem OOPlayableItem.h "OOPlayableItem.h"
 * @brief      OOPlayableItem
 * @details    OOPlayableItem.h in OoyalaSDK
 * @date       11/29/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

@protocol OOPlayableItem <NSObject>

/** @internal
 * Returns a set of streams representing the currently playing content
 * @returns An NSArray of OOStreams.
 */
- (NSArray *)getStreams;

@end
