// Copyright 2013 Google Inc.

#import <GoogleCast/GCKAdBreakStatus.h>
#import <GoogleCast/GCKDefines.h>
#import <GoogleCast/GCKMediaCommon.h>

#import <Foundation/Foundation.h>

@class GCKMediaInformation;
@class GCKMediaQueueItem;
@class GCKVideoInfo;

/**
 * @file GCKMediaStatus.h
 * GCKMediaPlayerState and GCKMediaPlayerIdleReason enums.
 */

GCK_ASSUME_NONNULL_BEGIN

/**
 * A flag (bitmask) indicating that a media item can be paused.
 *
 * @memberof GCKMediaStatus
 */
GCK_EXTERN const NSInteger kGCKMediaCommandPause;

/**
 * A flag (bitmask) indicating that a media item supports seeking.
 *
 * @memberof GCKMediaStatus
 */
GCK_EXTERN const NSInteger kGCKMediaCommandSeek;

/**
 * A flag (bitmask) indicating that a media item's audio volume can be changed.
 *
 * @memberof GCKMediaStatus
 */
GCK_EXTERN const NSInteger kGCKMediaCommandSetVolume;

/**
 * A flag (bitmask) indicating that a media item's audio can be muted.
 *
 * @memberof GCKMediaStatus
 */
GCK_EXTERN const NSInteger kGCKMediaCommandToggleMute;

/**
 * A flag (bitmask) indicating that a media item supports skipping forward.
 *
 * @memberof GCKMediaStatus
 */
GCK_EXTERN const NSInteger kGCKMediaCommandSkipForward;

/**
 * A flag (bitmask) indicating that a media item supports skipping backward.
 *
 * @memberof GCKMediaStatus
 */
GCK_EXTERN const NSInteger kGCKMediaCommandSkipBackward;

/**
 * A flag (bitmask) indicating that a media item supports moving to the next item in the queue.
 *
 * @deprecated This flag is currently not implemented.
 * @memberof GCKMediaStatus
 */
GCK_EXTERN const NSInteger kGCKMediaCommandQueueNext;

/**
 * A flag (bitmask) indicating that a media item supports moving to the previous item in the
 * queue.
 *
 * @deprecated This flag is currently not implemented.
 * @memberof GCKMediaStatus
 */
GCK_EXTERN const NSInteger kGCKMediaCommandQueuePrevious;

/**
 * @enum GCKMediaPlayerState
 * Media player states.
 */
typedef NS_ENUM(NSInteger, GCKMediaPlayerState) {
  /** Constant indicating unknown player state. */
  GCKMediaPlayerStateUnknown = 0,
  /** Constant indicating that the media player is idle. */
  GCKMediaPlayerStateIdle = 1,
  /** Constant indicating that the media player is playing. */
  GCKMediaPlayerStatePlaying = 2,
  /** Constant indicating that the media player is paused. */
  GCKMediaPlayerStatePaused = 3,
  /** Constant indicating that the media player is buffering. */
  GCKMediaPlayerStateBuffering = 4,
  /** Constant indicating that the media player is loading media. */
  GCKMediaPlayerStateLoading = 5,
};

/**
 * @enum GCKMediaPlayerIdleReason
 * Media player idle reasons.
 */
typedef NS_ENUM(NSInteger, GCKMediaPlayerIdleReason) {
  /** Constant indicating that the player currently has no idle reason. */
  GCKMediaPlayerIdleReasonNone = 0,

  /** Constant indicating that the player is idle because playback has finished. */
  GCKMediaPlayerIdleReasonFinished = 1,

  /**
   * Constant indicating that the player is idle because playback has been cancelled in
   * response to a STOP command.
   */
  GCKMediaPlayerIdleReasonCancelled = 2,

  /**
   * Constant indicating that the player is idle because playback has been interrupted by
   * a LOAD command.
   */
  GCKMediaPlayerIdleReasonInterrupted = 3,

  /** Constant indicating that the player is idle because a playback error has occurred. */
  GCKMediaPlayerIdleReasonError = 4,
};

/**
 * A class that holds status information about some media.
 */
GCK_EXPORT
@interface GCKMediaStatus : NSObject <NSCopying>

/**
 * The current media session ID, if any; otherwise 0.
 */
@property(nonatomic, assign, readonly) NSInteger mediaSessionID;

/**
 * The current player state.
 */
@property(nonatomic, assign, readonly) GCKMediaPlayerState playerState;

/**
 * Indicates whether the receiver is currently playing an ad.
 *
 * @deprecated Use @ref adBreakStatus instead.
 */
@property(nonatomic, assign, readonly) BOOL playingAd;

/**
 * The current idle reason. This value is only meaningful if the player state is
 * GCKMediaPlayerStateIdle.
 */
@property(nonatomic, assign, readonly) GCKMediaPlayerIdleReason idleReason;

/**
 * Gets the current stream playback rate. This will be negative if the stream is seeking
 * backwards, 0 if the stream is paused, 1 if the stream is playing normally, and some other
 * positive value if the stream is seeking forwards.
 */
@property(nonatomic, assign, readonly) float playbackRate;

/**
 * The GCKMediaInformation for this item.
 */
@property(nonatomic, strong, readonly, GCK_NULLABLE) GCKMediaInformation *mediaInformation;

/**
 * The current stream position, as an NSTimeInterval from the start of the stream.
 */
@property(nonatomic, assign, readonly) NSTimeInterval streamPosition;

/**
 * The stream's volume.
 */
@property(nonatomic, assign, readonly) float volume;

/**
 * The stream's mute state.
 */
@property(nonatomic, assign, readonly) BOOL isMuted;

/**
 * The current queue repeat mode.
 */
@property(nonatomic, assign, readonly) GCKMediaRepeatMode queueRepeatMode;

/**
 * The ID of the current queue item, if any.
 */
@property(nonatomic, assign, readonly) NSUInteger currentItemID;

/**
 * Whether there is a current item in the queue.
 */
@property(nonatomic, assign, readonly) BOOL queueHasCurrentItem;

/**
 * The current queue item, if any.
 */
@property(nonatomic, assign, readonly, GCK_NULLABLE) GCKMediaQueueItem *currentQueueItem;

/**
 * Checks if there is an item after the currently playing item in the queue.
 */
- (BOOL)queueHasNextItem;

/**
 * The next queue item, if any.
 */
@property(nonatomic, assign, readonly, GCK_NULLABLE) GCKMediaQueueItem *nextQueueItem;

/**
 * Whether there is an item before the currently playing item in the queue.
 */
@property(nonatomic, assign, readonly) BOOL queueHasPreviousItem;

/**
 * Whether there is an item being preloaded in the queue.
 */
@property(nonatomic, assign, readonly) BOOL queueHasLoadingItem;

/**
 * The ID of the item that is currently preloaded, if any.
 */
@property(nonatomic, assign, readonly) NSUInteger preloadedItemID;

/**
 * The ID of the item that is currently loading, if any.
 */
@property(nonatomic, assign, readonly) NSUInteger loadingItemID;

/**
 * The list of active track IDs.
 */
@property(nonatomic, strong, readonly, GCK_NULLABLE) NSArray<NSNumber *> *activeTrackIDs;

/**
 * The video information, if any.
 *
 * @since 3.3
 */
@property(nonatomic, strong, readonly, GCK_NULLABLE) GCKVideoInfo *videoInfo;

/**
 * Any custom data that is associated with the media status.
 */
@property(nonatomic, strong, readonly, GCK_NULLABLE) id customData;

/**
 * The current ad playback status.
 *
 * @since 3.3
 */
@property(nonatomic, strong, readonly, GCK_NULLABLE) GCKAdBreakStatus *adBreakStatus;

/**
 * Designated initializer.
 *
 * @param mediaSessionID The media session ID.
 * @param mediaInformation The media information.
 */
- (instancetype)initWithSessionID:(NSInteger)mediaSessionID
                 mediaInformation:(GCKMediaInformation *GCK_NULLABLE_TYPE)mediaInformation;

/**
 * Checks if the stream supports a given control command.
 */
- (BOOL)isMediaCommandSupported:(NSInteger)command;

/**
 * Returns the number of items in the playback queue.
 */
- (NSUInteger)queueItemCount;

/**
 * Returns the item at the specified index in the playback queue.
 */
- (GCKMediaQueueItem *GCK_NULLABLE_TYPE)queueItemAtIndex:(NSUInteger)index;

/**
 * Returns the item with the given item ID in the playback queue.
 */
- (GCKMediaQueueItem *GCK_NULLABLE_TYPE)queueItemWithItemID:(NSUInteger)itemID;

/**
 * Returns the index of the item with the given item ID in the playback queue, or -1 if there is
 * no such item in the queue.
 */
- (NSInteger)queueIndexForItemID:(NSUInteger)itemID;

@end

GCK_ASSUME_NONNULL_END
