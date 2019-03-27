// Copyright 2015 Google Inc.

#import <GoogleCast/GCKDefines.h>

#import <Foundation/Foundation.h>

@class GCKDiscoveryCriteria;
@class GCKLaunchOptions;

NS_ASSUME_NONNULL_BEGIN

/**
 * Options that affect the discovery of Cast devices and the behavior of Cast sessions. Writable
 * properties must be set before passing this object to the GCKCastContext.
 *
 * @since 3.0
 */
GCK_EXPORT
@interface GCKCastOptions : NSObject <NSCopying, NSSecureCoding>

/**
 * Constructs a new GCKCastOptions object with the specified discovery criteria.
 *
 * @param discoveryCriteria The discovery criteria to apply to discovered Cast devices. Only those
 * devices that satisfy the criteria will be made available to the application.
 *
 * @since 4.0
 */
- (instancetype)initWithDiscoveryCriteria:(GCKDiscoveryCriteria *)discoveryCriteria;

/**
 * Constructs a new GCKCastOptions object with the specified receiver application ID.
 *
 * @param applicationID The ID of the receiver application which must be supported by discovered
 * Cast devices, and which will be launched when starting a new Cast session.
 *
 * @deprecated Use initWithDiscoveryCriteria:.
 */
- (instancetype)initWithReceiverApplicationID:(NSString *)applicationID
    GCK_DEPRECATED("Use initWithDiscoveryCriteria:");

/**
 * Constructs a new GCKCastOptions object with the specified list of namespaces.
 *
 * @param namespaces A list of namespaces which must be supported by the currently running receiver
 * application on each discovered Cast device.
 *
 * @deprecated Use initWithDiscoveryCriteria:.
 */
- (instancetype)initWithSupportedNamespaces:(NSArray<NSString *> *)namespaces
    GCK_DEPRECATED("Use initWithDiscoveryCriteria:");

/**
 * A flag indicating whether the sender device's physical volume buttons should control the
 * session's volume.
 */
@property(nonatomic, assign) BOOL physicalVolumeButtonsWillControlDeviceVolume;

/**
 * A flag indicating whether the discovery of Cast devices should start automatically at
 * context initialization time. If set to <code>NO</code>, discovery can be started and stopped
 * on-demand by using the methods GCKDiscoveryManager::startDiscovery and
 * GCKDiscoveryManager::stopDiscovery.
 *
 * @since 3.4
 */
@property(nonatomic, assign) BOOL disableDiscoveryAutostart;

/**
 * A flag which is used to disable or enable collection of diagnostic data to improve the
 * reliability of Cast device discovery. The default value is <code>NO</code> (enabled); it may be
 * disabled by setting the value to <code>YES</code>.
 *
 * @since 4.0
 */
@property(nonatomic, assign) BOOL disableAnalyticsLogging;

/**
 * The receiver launch options to use when starting a Cast session.
 */
@property(nonatomic, copy, nullable) GCKLaunchOptions *launchOptions;

/**
 * The shared container identifier to use for background HTTP downloads that are performed by the
 * framework.
 *
 * @since 3.2
 */
@property(nonatomic, copy, nullable) NSString *sharedContainerIdentifier;

/**
 * Whether sessions should be suspended when the sender application goes into the background (and
 * resumed when it returns to the foreground). By default this option is set to <code>YES</code>.
 * It is appropriate to set this to <code>NO</code> in applications that are able to maintain
 * network connections indefinitely while in the background.
 *
 * @since 3.4
 */
@property(nonatomic, assign) BOOL suspendSessionsWhenBackgrounded;

/**
 * Whether the receiver application should be terminated when the user ends the session via the
 * "Stop Casting" button. By default this option is set to <code>NO</code>.
 *
 * @since 4.0
 */
@property(nonatomic, assign) BOOL stopReceiverApplicationWhenEndingSession;

@end

NS_ASSUME_NONNULL_END
