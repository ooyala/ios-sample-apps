//
//  OOAdobeAnalyticsManager.h
//  OOyalaAdobeAnalyticsSDK
//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

@import Foundation;

@class OOOoyalaPlayer;
@class OOAdobeHeartbeatConfiguration;

/**
 * Class integrated with Adobe Heartbeat Analytics. You'll use this to initiate Adobe analytics
 * tracking with the Ooyala Player.
 */
@interface OOAdobeAnalyticsManager : NSObject

#pragma mark - Initializers

- (nullable instancetype)init NS_UNAVAILABLE;

/**
 * Designated initializer that expects an OoyalaPlayer. It will prepare Adobe Analytics with this
 * player.
 * @param player The player that will be used to retrieve info from.
 * @param config Configuration used to initialize analytics.
 */
- (nullable instancetype)initWithPlayer:(nonnull OOOoyalaPlayer *)player
                                 config:(nonnull OOAdobeHeartbeatConfiguration *)config NS_DESIGNATED_INITIALIZER;

#pragma mark - Methods

/**
 * Starts tracking the player events. Also known as starting a video
 * session.
 */
- (void)startCapture;

/**
 * Stops tracking of the player events.
 * It's important to call this to end a video session.
 */
- (void)stopCapture;

@end
