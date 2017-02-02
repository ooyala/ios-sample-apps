//
//  OOAdobeHeartbeatConfiguration.h
//  OOyalaAdobeAnalyticsSDK
//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOAdobeHeartbeatConfiguration : NSObject

/**
 * Player name used when tracking. Default: "Ooyala iOS SDK".
 */
@property (nonatomic) NSString *playerName;

/**
 * <b>Mandatory value</b>. The adobe heartbeat tracking server. This is where all the hearbeat calls are sent.
 * You should ask for this value to your Adobe consultant.
 */
@property (nonatomic) NSString *heartbeatTrackingServer;

/**
 * <b>Mandatory value</b>. The name of the publisher. This may be the account name you use to login to the Adobe analytics dashboard.
 * Confirm this value with your Adobe consultant.
 */
@property (nonatomic) NSString *heartbeatPublisher;

/**
 * The online video platform that content is being distributed. Default: "Ooyala".
 */
@property (nonatomic) NSString *onlineVideoPlatform;

/**
 *  Enable or disable SSL for Adobe Heartbeat. Default: YES
 */
@property (nonatomic) BOOL sslEnabled;

- (instancetype)initWithHeartbeatTrackingServer:(NSString *)trackingServer
                             heartbeatPublisher:(NSString *)publisher
                                     playerName:(NSString *)playerName
                            onlineVideoPlatform:(NSString *)onlineVideoPlatform NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithHeartbeatTrackingServer:(NSString *)trackingServer heartbeatPublisher:(NSString *)publisher;

@end
