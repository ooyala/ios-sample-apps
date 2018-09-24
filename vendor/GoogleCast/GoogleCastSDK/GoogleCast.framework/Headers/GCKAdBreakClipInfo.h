// Copyright 2013 Google Inc.

#import <Foundation/Foundation.h>

#import <GoogleCast/GCKDefines.h>
#import <GoogleCast/GCKMediaRequestItem.h>

GCK_ASSUME_NONNULL_BEGIN

/**
 * The value for the @ref whenSkippable field if an ad is not skippable.
 *
 * @since 4.3
 */
GCK_EXTERN const int kAdBreakClipNotSkippable;

/**
 * A class representing a VAST request for an ad break clip.
 *
 * @since 4.1
 */
GCK_EXPORT
@interface GCKAdBreakClipVastAdsRequest : NSObject <NSCopying, NSSecureCoding>

/** A URL for the VAST file
 *
 * @since 4.1
 */
@property(nonatomic, strong, readonly) NSURL *adTagUrl;

/**
 * A String specifying a VAST document to be used as the ads response
 * instead of making a request via an ad tag url. This can be useful for
 * debugging and other situations where a CAST response is already
 * available.
 *
 * @since 4.1
 */
@property(nonatomic, strong, readonly) NSString *adsResponse;

@end

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

/**
 * The content's ID.
 * @since 4.1
 */
@property(nonatomic, strong, readonly, GCK_NULLABLE) NSString *contentID;

/**
 * The poster URL for this clip.
 * @since 4.1
 */
@property(nonatomic, strong, readonly, GCK_NULLABLE) NSURL *posterURL;

/**
 * The length of time into the clip when it can be skipped in seconds.
 * @since 4.3
 */
@property(nonatomic, assign, readonly) NSTimeInterval whenSkippable;

/**
 * The HLS segment format for this clip.
 * @since 4.1
 */
@property(nonatomic, assign, readonly) GCKHLSSegmentFormat hlsSegmentFormat;

/**
 * The VAST ad request configuration if any. See more here:
 * <a href="https://www.iab.com/guidelines/digital-video-ad-serving-template-vast-4-0/">
 * Digital Video Ad Serving Template 4.0</a>.
 * @since 4.1
 */
@property(nonatomic, strong, readonly, GCK_NULLABLE) GCKAdBreakClipVastAdsRequest *vastAdsRequest;

/** Custom application-specific data associated with the clip. */
@property(nonatomic, strong, readonly, GCK_NULLABLE) id customData;

@end

GCK_ASSUME_NONNULL_END
