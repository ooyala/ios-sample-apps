// Copyright 2015 Google Inc.

#import <GoogleCast/GCKDefines.h>

#import <Foundation/Foundation.h>

GCK_ASSUME_NONNULL_BEGIN

/**
 * A member device of a multizone group.
 *
 * @since 3.1
 */
GCK_EXPORT
@interface GCKMultizoneDevice : NSObject <NSCopying, NSSecureCoding>

/** The unique device ID. */
@property(nonatomic, copy, readonly) NSString *deviceID;

/** The device's friendly name. */
@property(nonatomic, copy, readonly) NSString *friendlyName;

/** The device capabilities. */
@property(nonatomic, assign, readwrite) NSInteger capabilities;

/** The device volume level. */
@property(nonatomic, assign, readwrite) float volumeLevel;

/** Whether the device is muted. */
@property(nonatomic, assign, readwrite) BOOL muted;

/**
 * Initializes the object with the given JSON data.
 */
- (instancetype)initWithJSONObject:(id)JSONObject;

/**
 * Designated initializer.
 *
 * @param deviceID The unique device ID.
 * @param friendlyName The device's friendly name.
 * @param capabilities The device capabilities.
 * @param volume The device volume level.
 * @param muted Whether the device is muted.
 */
- (instancetype)initWithDeviceID:(NSString *)deviceID
                    friendlyName:(NSString *)friendlyName
                    capabilities:(NSInteger)capabilities
                     volumeLevel:(float)volume
                           muted:(BOOL)muted;

@end

GCK_ASSUME_NONNULL_END
