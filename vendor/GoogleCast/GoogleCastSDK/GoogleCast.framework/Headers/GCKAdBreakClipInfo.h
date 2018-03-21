// Copyright 2013 Google Inc.

#import <GoogleCast/GCKDefines.h>

#import <Foundation/Foundation.h>

GCK_ASSUME_NONNULL_BEGIN

/**
 * A class representing an ad break clip.
 *
 * @since 3.3
 */

GCK_EXPORT
@interface GCKAdBreakClipInfo : NSObject <NSCopying, NSSecureCoding>

/** A string that uniquely identifies this ad break clip. */
@property(nonatomic, strong, readonly) NSString *adBreakClipID;

/** The clip's duration. */
@property(nonatomic, assign, readonly) NSTimeInterval duration;

/** The clip's title. */
@property(nonatomic, strong, readonly, GCK_NULLABLE) NSString *title;

/** The click-through URL for this clip. */
@property(nonatomic, strong, readonly, GCK_NULLABLE) NSURL *clickThroughURL;

/** URL for the content that represents this clip (typically an image). */
@property(nonatomic, strong, readonly, GCK_NULLABLE) NSURL *contentURL;

/** MIME type of the content referenced by @ref contentURL. */
@property(nonatomic, strong, readonly, GCK_NULLABLE) NSString *mimeType;

/** Custom application-specific data associated with the clip. */
@property(nonatomic, strong, readonly, GCK_NULLABLE) id customData;

@end

GCK_ASSUME_NONNULL_END
