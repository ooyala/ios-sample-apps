// Copyright 2013 Google Inc.

#import <GoogleCast/GCKAdBreakClipInfo.h>
#import <GoogleCast/GCKDefines.h>

#import <Foundation/Foundation.h>

GCK_ASSUME_NONNULL_BEGIN

/**
 * A class representing an ad break.
 *
 * @since 3.1
 */
GCK_EXPORT
@interface GCKAdBreakInfo : NSObject <NSCopying, NSSecureCoding>

/**
 * A string that uniquely identifies this ad break.
 *
 * @since 3.3
 */
@property(nonatomic, strong, readonly) NSString *adBreakID;

/**
 * The playback position, in seconds, at which this ad will start playing.
 *
 * @since 3.1
 */
@property(nonatomic, assign, readonly) NSTimeInterval playbackPosition;

/**
 * Whether the ad break has already been watched or not.
 *
 * @since 3.3
 */
@property(nonatomic, assign, readonly) BOOL watched;

/**
 * A list of identifier strings for the ad break clips contained by this ad break.
 *
 * @since 3.3
 */
@property(nonatomic, strong, readonly) NSArray<NSString *> *adBreakClipIDs;

/**
 * Whether the ad break is embedded.
 *
 * @since 4.1
 */
@property(nonatomic, assign, readonly) BOOL embedded;

/**
 * Designated initializer. Constructs a new GCKAdBreakInfo.
 * @param playbackPosition The playback position in seconds for this ad break.
 */
- (instancetype)initWithPlaybackPosition:(NSTimeInterval)playbackPosition;

@end

GCK_ASSUME_NONNULL_END
