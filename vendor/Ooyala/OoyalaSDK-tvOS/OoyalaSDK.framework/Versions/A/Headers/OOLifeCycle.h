#import <Foundation/Foundation.h>
/**
 * @brief Handle events around the lifecycle of the OOOoyalaPlayer
 */
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
