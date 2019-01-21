// Copyright 2017 Google Inc.

#import <GoogleCast/GCKDefines.h>

#import <Foundation/Foundation.h>

GCK_ASSUME_NONNULL_BEGIN

/**
 * A constant indicating credentials that have been received from the cloud.
 *
 * @since 4.1.1
 */
GCK_EXTERN NSString *const kGCKCredentialsTypeCloud;

/**
 * Options for loading media with GCKRemoteMediaClient.
 *
 * @since 4.0
 */
GCK_EXPORT
@interface GCKMediaLoadOptions : NSObject <NSCopying, NSSecureCoding>

/**
 * Designated initializer. Initializes a GCKMediaLoadOptions with default values for all properties.
 */
- (instancetype)init;

/**
 * Whether playback should start immediately. The default value is <code>YES</code>.
 */
@property(nonatomic, assign, readwrite) BOOL autoplay;

/**
 * The initial playback position. The default value is @ref kGCKInvalidTimeInterval, which indicates
 * a default playback position.
 */
@property(nonatomic, assign, readwrite) NSTimeInterval playPosition;

/**
 * The playback rate. The default value is <code>1</code>.
 */
@property(nonatomic, assign, readwrite) float playbackRate;

/**
 * An array of integers specifying the active tracks. The default value is <code>nil</code>.
 */
@property(nonatomic, strong, readwrite, GCK_NULLABLE) NSArray<NSNumber *> *activeTrackIDs;

/**
 * Custom application-specific data to pass along with the request. Must either be
 * an object that can be serialized to JSON using
 * <a href="https://goo.gl/0vd4Q2"><b>NSJSONSerialization</b></a>, or <code>nil</code>.
 */
@property(nonatomic, strong, readwrite, GCK_NULLABLE) id customData;

/**
 * The user credentials for the media item being loaded.
 *
 * @since 4.1.1
 */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) NSString *credentials;

/**
 * The type of user credentials specified in #GCKMediaLoadOptions::credentials.
 *
 * @since 4.1.1
 */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) NSString *credentialsType;

@end

GCK_ASSUME_NONNULL_END
