/**
 * @class      OOLifeCycle OOLifeCycle.h "OOLifeCycle.h"
 * @brief      OOLifeCycle
 * @details    OOLifeCycle.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

@protocol OOLifeCycle

/**
 * This is called when plugin should be reset
 */
- (void)reset;

/**
 * This is called when plugin should be suspended
 */
- (void)suspend;

/**
 * This is called when plugin should be resumed
 */
- (void)resume;

/**
 * This is called when plugin should be resumed
 *
 * @param time
 *          the playhead time to set
 * @param stateToResume
 *          the player state after resume
 */
- (void)resume:(Float64)time stateToResume:(OOOoyalaPlayerState)state;

/**
 * This is called when plugin should be destryed
 */
- (void)destroy;

@end
