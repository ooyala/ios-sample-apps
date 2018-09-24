// Copyright 2015 Google Inc.

#import <GoogleCast/GCKDefines.h>

#import <Foundation/Foundation.h>

@class GCKMultizoneDevice;

GCK_ASSUME_NONNULL_BEGIN

/**
 * The status of a multizone group.
 *
 * @since 3.1
 */
GCK_EXPORT
@interface GCKMultizoneStatus : NSObject <NSCopying, NSSecureCoding>

/** The member devices of the multizone group. */
@property(nonatomic, copy, readwrite) NSArray<GCKMultizoneDevice *> *devices;

/** Initializes the object with the given JSON data. */
- (instancetype)initWithJSONObject:(id)JSONObject;

/** Initializes the object with the given list of member devices. */
- (instancetype)initWithDevices:(NSArray<GCKMultizoneDevice *> *)devices;

@end

GCK_ASSUME_NONNULL_END
