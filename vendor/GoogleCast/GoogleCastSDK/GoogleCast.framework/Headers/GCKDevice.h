// Copyright 2012 Google Inc.

#import <GoogleCast/GCKDefines.h>

#import <Foundation/Foundation.h>

#import <GoogleCast/GCKNetworkAddress.h>

/**
 * @file GCKDevice.h
 * GCKDeviceStatus enum.
 */

GCK_ASSUME_NONNULL_BEGIN

/**
 * @enum GCKDeviceStatus
 * Enum defining the device status at the time the device was scanned.
 */
typedef NS_ENUM(NSInteger, GCKDeviceStatus) {
  /** Unknown status. */
  GCKDeviceStatusUnknown = -1,
  /** Idle device status. */
  GCKDeviceStatusIdle = 0,
  /** Busy/join device status. */
  GCKDeviceStatusBusy = 1,
};

/**
 * @enum GCKDeviceCapability
 * Enum defining the capabilities of a receiver device.
 */
typedef NS_ENUM(NSInteger, GCKDeviceCapability) {
  /** The device has video-out capability. */
  GCKDeviceCapabilityVideoOut = 1 << 0,
  /** The device has video-in capability. */
  GCKDeviceCapabilityVideoIn = 1 << 1,
  /** The device has audio-out capability. */
  GCKDeviceCapabilityAudioOut = 1 << 2,
  /** The device has audio-in capability. */
  GCKDeviceCapabilityAudioIn = 1 << 3,
  /** The device has multizone group capability. */
  GCKDeviceCapabilityMultizoneGroup = 1 << 5,
  /** The device has master or fixed volume mode capability. */
  GCKDeviceCapabilityMasterOrFixedVolume = 1 << 11,
  /** The device has attenuation or fixed volume mode capability. */
  GCKDeviceCapabilityAttenuationOrFixedVolume = 1 << 12,
};

/**
 * @enum GCKDeviceType
 * Device types.
 * @since 3.3
 */
typedef NS_ENUM(NSInteger, GCKDeviceType) {
  /** Generic Cast device. */
  GCKDeviceTypeGeneric = 0,
  /** Cast-enabled TV. */
  GCKDeviceTypeTV,
  /** Cast-enabled speaker or other audio device. */
  GCKDeviceTypeSpeaker,
  /** Speaker group. */
  GCKDeviceTypeSpeakerGroup,
  /**
   * The "Nearby Devices" pseudo-device, which represents any nearby unpaired guest-mode devices.
   */
  GCKDeviceTypeNearbyUnpaired
};

/**
 * @var kGCKCastDeviceCategory
 * The device category that identifies Cast devices.
 */
GCK_EXTERN NSString *const kGCKCastDeviceCategory;

@class GCKImage;

/**
 * An object representing a receiver device.
 */
GCK_EXPORT
@interface GCKDevice : NSObject <NSCopying, NSSecureCoding>

- (instancetype)init NS_UNAVAILABLE;

/**
 * @deprecated Use @ref networkAddress
 * The device's IPv4 address, in dot-notation. Used when making network requests.
 * This will be an empty string for @ref GCKDevice objects that are created with an IPv6 address.
 */
@property(nonatomic, copy, readonly)
    NSString *ipAddress GCK_DEPRECATED("Use networkAddress for both IPv4 and IPv6 support");

/**
 * The device's IP address. Used when making network requests.
 * @since 4.2
 */
@property(nonatomic, copy, readonly) GCKNetworkAddress *networkAddress;

/** The device's service port. */
@property(nonatomic, assign, readonly) uint16_t servicePort;

/** A unique identifier for the device. */
@property(nonatomic, copy, readonly) NSString *deviceID;

/** The device's friendly name. This is a user-assignable name such as "Living Room". */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) NSString *friendlyName;

/** The device's model name. */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) NSString *modelName;

/** An array of GCKImage objects containing icons for the device. */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) NSArray<GCKImage *> *icons;

/** The device's status at the time that it was most recently scanned. */
@property(nonatomic, assign, readwrite) GCKDeviceStatus status;

/** The status text reported by the currently running receiver application, if any. */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) NSString *statusText;

/** The device's protocol version. */
@property(nonatomic, copy, readwrite, GCK_NULLABLE) NSString *deviceVersion;

/** YES if this device is on the local network. */
@property(nonatomic, assign, readonly) BOOL isOnLocalNetwork;

/**
 * The device type.
 *
 * @since 3.3
 */
@property(nonatomic, assign, readonly) GCKDeviceType type;

/**
 * The device category, a string that uniquely identifies the type of device. Cast devices have
 * a category of @ref kGCKCastDeviceCategory.
 */
@property(nonatomic, copy, readonly) NSString *category;

/**
 * A globally unique ID for this device. This is a concatenation of the @ref category and
 * @ref deviceID properties.
 */
@property(nonatomic, copy, readonly) NSString *uniqueID;

/**
 * Tests if this device refers to the same physical device as another. Returns <code>YES</code> if
 * both GCKDevice objects have the same category, device ID, IP address, service port, and protocol
 * version.
 */
- (BOOL)isSameDeviceAs:(const GCKDevice *)other;

/**
 * Returns <code>YES</code> if the device supports the given capabilities.
 *
 * @param deviceCapabilities A bitwise-OR of one or more of the @ref GCKDeviceCapability constants.
 */
- (BOOL)hasCapabilities:(NSInteger)deviceCapabilities;

/**
 * Sets an arbitrary attribute in the object. May be used by custom device providers to store
 * device-specific information for non-Cast devices.
 *
 * @param attribute The attribute value, which must be key-value coding compliant, and cannot be
 * <code>nil</code>.
 * @param key The key that identifies the attribute. The key is an arbitrary string. It cannot be
 * <code>nil</code>.
 */
- (void)setAttribute:(NSObject<NSSecureCoding> *)attribute forKey:(NSString *)key;

/**
 * Looks up an attribute in the object.
 *
 * @param key The key that identifies the attribute. The key is an arbitrary string. It cannot be
 * <code>nil</code>.
 * @return The value of the attribute, or <code>nil</code> if no such attribute exists.
 */
- (NSObject<NSSecureCoding> * GCK_NULLABLE_TYPE)attributeForKey:(NSString *)key;

/**
 * Removes an attribute from the object.
 *
 * @param key The key that identifies the attribute. The key is an arbitrary string. It cannot be
 * <code>nil</code>.
 */
- (void)removeAttributeForKey:(NSString *)key;

/**
 * Removes all attributes from the object.
 */
- (void)removeAllAttributes;

/**
 * Extracts the device category from a device unique ID.
 */
+ (NSString *)deviceCategoryForDeviceUniqueID:(NSString *)deviceUniqueID;

@end

GCK_ASSUME_NONNULL_END
