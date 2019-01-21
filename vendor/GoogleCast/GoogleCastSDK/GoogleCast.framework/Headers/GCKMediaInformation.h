// Copyright 2013 Google Inc.

#import <GoogleCast/GCKAdBreakClipInfo.h>
#import <GoogleCast/GCKAdBreakInfo.h>
#import <GoogleCast/GCKDefines.h>

#import <Foundation/Foundation.h>

/**
 * @file GCKMediaInformation.h
 * GCKMediaStreamType enum.
 */

@class GCKMediaInformationBuilder;
@class GCKMediaMetadata;
@class GCKMediaTextTrackStyle;
@class GCKMediaTrack;

GCK_ASSUME_NONNULL_BEGIN

/**
 * @enum GCKMediaStreamType
 * Enum defining the media stream type.
 */
typedef NS_ENUM(NSInteger, GCKMediaStreamType) {
  /** A stream type of "none". */
  GCKMediaStreamTypeNone = 0,
  /** A buffered stream type. */
  GCKMediaStreamTypeBuffered = 1,
  /** A live stream type. */
  GCKMediaStreamTypeLive = 2,
  /** An unknown stream type. */
  GCKMediaStreamTypeUnknown = 99,
};

/**
 * A class that aggregates information about a media item.
 */
GCK_EXPORT
@interface GCKMediaInformation : NSObject <NSCopying, NSSecureCoding>

/**
 * The content ID for this stream.
 */
@property(nonatomic, copy, readonly) NSString *contentID;

/**
 * The stream type.
 */
@property(nonatomic, assign, readonly) GCKMediaStreamType streamType;

/**
 * The content (MIME) type.
 */
@property(nonatomic, copy, readonly) NSString *contentType;

/**
 * The media item metadata.
 */
@property(nonatomic, strong, readonly, GCK_NULLABLE) GCKMediaMetadata *metadata;

/**
 * The list of ad breaks in this content.
 */
@property(nonatomic, copy, readonly, GCK_NULLABLE) NSArray<GCKAdBreakInfo *> *adBreaks;

/**
 * The list of ad break clips in this content.
 *
 * @since 3.3
 */
@property(nonatomic, copy, readonly, GCK_NULLABLE) NSArray<GCKAdBreakClipInfo *> *adBreakClips;

/**
 * The length of the stream, in seconds, or <code>INFINITY</code> if it is a live stream.
 */
@property(nonatomic, assign, readonly) NSTimeInterval streamDuration;

/**
 * The media tracks for this stream.
 */
@property(nonatomic, copy, readonly, GCK_NULLABLE) NSArray<GCKMediaTrack *> *mediaTracks;

/**
 * The text track style for this stream.
 */
@property(nonatomic, copy, readonly, GCK_NULLABLE) GCKMediaTextTrackStyle *textTrackStyle;

/**
 * The deep link for the media as used by Google Assistant, if any.
 *
 * @since 4.0
 */
@property(nonatomic, copy, readonly, GCK_NULLABLE) NSString *entity;

/**
 * The custom data, if any.
 */
@property(nonatomic, strong, readonly, GCK_NULLABLE) id customData;

/**
 * Designated initializer.
 *
 * @param contentID The content ID.
 * @param streamType The stream type.
 * @param contentType The content (MIME) type.
 * @param metadata The media item metadata.
 * @param adBreaks The list of ad breaks in this content.
 * @param adBreakClips The list of ad break clips in this content.
 * @param streamDuration The stream duration.
 * @param mediaTracks The media tracks, if any, otherwise <code>nil</code>.
 * @param textTrackStyle The text track style, if any, otherwise <code>nil</code>.
 * @param customData The custom application-specific data. Must either be an object that can be
 * serialized to JSON using <a href="https://goo.gl/0vd4Q2"><b>NSJSONSerialization</b></a>, or
 * <code>nil</code>.
 *
 * @since 4.3
 */
- (instancetype)initWithContentID:(NSString *)contentID
                       streamType:(GCKMediaStreamType)streamType
                      contentType:(NSString *)contentType
                         metadata:(GCKMediaMetadata *GCK_NULLABLE_TYPE)metadata
                         adBreaks:(NSArray<GCKAdBreakInfo *> *GCK_NULLABLE_TYPE)adBreaks
                     adBreakClips:(NSArray<GCKAdBreakClipInfo *> *GCK_NULLABLE_TYPE)adBreakClips
                   streamDuration:(NSTimeInterval)streamDuration
                      mediaTracks:(NSArray<GCKMediaTrack *> *GCK_NULLABLE_TYPE)mediaTracks
                   textTrackStyle:(GCKMediaTextTrackStyle *GCK_NULLABLE_TYPE)textTrackStyle
                       customData:(id GCK_NULLABLE_TYPE)customData;

/**
 * Deprecated. Use initWithContentID:streamType:contentType:metadata:adBreaks:
 * adBreakClips:streamDuration:mediaTracks:textTrackStyle:entity:customData:
 * for ads and entity support.
 *
 * @param contentID The content ID.
 * @param streamType The stream type.
 * @param contentType The content (MIME) type.
 * @param metadata The media item metadata.
 * @param streamDuration The stream duration.
 * @param mediaTracks The media tracks, if any, otherwise <code>nil</code>.
 * @param textTrackStyle The text track style, if any, otherwise <code>nil</code>.
 * @param customData The custom application-specific data. Must either be an object that can be
 * serialized to JSON using <a href="https://goo.gl/0vd4Q2"><b>NSJSONSerialization</b></a>, or
 * <code>nil</code>.
 */
- (instancetype)initWithContentID:(NSString *)contentID
                       streamType:(GCKMediaStreamType)streamType
                      contentType:(NSString *)contentType
                         metadata:(GCKMediaMetadata *GCK_NULLABLE_TYPE)metadata
                   streamDuration:(NSTimeInterval)streamDuration
                      mediaTracks:(NSArray<GCKMediaTrack *> *GCK_NULLABLE_TYPE)mediaTracks
                   textTrackStyle:(GCKMediaTextTrackStyle *GCK_NULLABLE_TYPE)textTrackStyle
                       customData:(id GCK_NULLABLE_TYPE)customData
    GCK_DEPRECATED(
        "Use "
        "initWithContentID:streamType:contentType:metadata:adBreaks:adBreakClips:streamDuration:"
        "mediaTracks:textTrackStyle:entity:customData: for ads and entity support.");

/**
 * Searches for a media track with the given track ID.
 *
 * @param trackID The media track ID.
 * @return The matching GCKMediaTrack object, or <code>nil</code> if there is no media track
 * with the given ID.
 */
- (GCKMediaTrack *GCK_NULLABLE_TYPE)mediaTrackWithID:(NSInteger)trackID;

@end

/**
 * A builder object for constructing new or derived GCKMediaInformation instances. The builder may
 * be used to derive a GCKMediaInformation from an existing one:
 *
 * @code
 * GCKMediaInformationBuilder *builder =
 *     [[GCKMediaInformationBuilder alloc] initWithMediaInformation:originalMediaInfo];
 * builder.contentID = ...; // Change the content ID.
 * builder.streamDuration = 100; // Change the stream duration.
 * GCKMediaInformation *derivedMediaInfo = [builder build];
 * @endcode
 *
 * It can also be used to construct a new GCKMediaInformation from scratch:
 *
 * @code
 * GCKMediaInformationBuilder *builder =
 *     [[GCKMediaInformationBuilder alloc] initWithContentID:...];
 * builder.contentType = ...;
 * builder.streamType = ...;
 * builder.metadata = ...;
 * // Set all other desired propreties...
 * GCKMediaInformation *newMediaInfo = [builder build];
 * @endcode
 *
 * @since 4.0
 */
GCK_EXPORT
@interface GCKMediaInformationBuilder : NSObject

/**
 * The content ID for this stream.
 */
@property(nonatomic, copy, readwrite) NSString *contentID;

/**
 * The stream type. Defaults to GCKMediaStreamTypeBuffered.
 */
@property(nonatomic, assign, readwrite) GCKMediaStreamType streamType;

/**
 * The content (MIME) type.
 */
@property(nonatomic, copy, readwrite) NSString *contentType;

/**
 * The media item metadata.
 */
@property(nonatomic, strong, readwrite, GCK_NULLABLE) GCKMediaMetadata *metadata;

/**
 * The list of ad breaks in this content.
 */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) NSArray<GCKAdBreakInfo *> *adBreaks;

/**
 * The list of ad break clips in this content.
 */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) NSArray<GCKAdBreakClipInfo *> *adBreakClips;

/**
 * The length of the stream, in seconds, or <code>INFINITY</code> if it is a live stream. Defaults
 * to 0.
 */
@property(nonatomic, assign, readwrite) NSTimeInterval streamDuration;

/**
 * The media tracks for this stream.
 */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) NSArray<GCKMediaTrack *> *mediaTracks;

/**
 * The text track style for this stream.
 */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) GCKMediaTextTrackStyle *textTrackStyle;

/**
 * The deep link for the media as used by Google Assistant, if any.
 */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) NSString *entity;

/**
 * The custom data, if any.
 */
@property(nonatomic, strong, readwrite, GCK_NULLABLE) id customData;

/**
 * Constructs a new GCKMediaInformationBuilder with the given required attributes, and all other
 * attributes initialized to default values.
 */
- (instancetype)initWithContentID:(NSString *)contentID;

/**
 * Constructs a new GCKMediaInformationBuilder with the given required attributes, and all other
 * attributes initialized to default values.
 */
- (instancetype)initWithContentID:(NSString *)contentID
                           entity:(NSString *)entity;

/**
 * Constructs a new GCKMediaInformationBuilder with the given required attributes, and all other
 * attributes initialized to default values.
 */
- (instancetype)initWithEntity:(NSString *)entity;

/**
 * Constructs a new GCKMediaInformationBuilder with attributes copied from the given
 * GCKMediaInformation instance.
 *
 * @param mediaInfo The instance to copy.
 */
- (instancetype)initWithMediaInformation:(GCKMediaInformation *)mediaInfo;

/**
 * Builds a GCKMediaInformation using the builder's current attributes.
 *
 * @return The new GCKMediaInformation instance.
 */
- (GCKMediaInformation *)build;

@end

GCK_ASSUME_NONNULL_END
