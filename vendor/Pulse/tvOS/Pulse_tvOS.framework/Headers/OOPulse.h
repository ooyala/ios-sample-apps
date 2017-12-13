//
//  OOPulse.h
//  Pulse
//
//  Created by Jacques du Toit on 21/10/15.
//  Copyright © 2015 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Pulse_tvOS/Pulse.h>

@protocol OOPulseSession;
@protocol OOPulseSessionDelegate;

extern NSString *OOPulseIllegalOperationException;

/**
 * The Ooyala Pulse SDK.
 *
 * This class is used to request ad sessions from Ooyala Pulse. An ad session
 * contains all the ads that will be played along with a specific piece of
 * content. 
 * 
 * When your application has content which it wants to display alongside advertisements,
 * it requests a new ad session using this class. (See OOPulseSession.)
 */
@interface OOPulse : NSObject

/**  @name Methods  */

/**
 *  Initialize the Pulse SDK.
 *
 *  This method must be called before requesting any ad sessions.
 *
 *  @param host            The Ooyala Pulse hostname for the client account being used.
 *  @param deviceContainer The Ooyala Pulse device container, if any; can be nil.
 *  @param persistentId    The Ooyala Pulse persistent user id, if any; can be nil.
 */
+ (void)setPulseHost:(NSString *)host
     deviceContainer:(NSString *)deviceContainer
        persistentId:(NSString *)persistentId;


/**
 *  Set a listener to receive low-level log messages about errors, warnings and 
 *  the like, which may be dispatched during ad or tracking requests.
 *
 * @param listener A OOLogListenerBlock which is called with the log messages.
 */
+ (void)setLogListener:(OOLogListenerBlock)listener;

/**
 * Create a new Pulse ad session with the passed metadata and request settings.
 *
 *  @param contentMetadata Information about the content along with which the requested ads are to be displayed.
 *  @param requestSettings Information about the environment in which the ad will play.
 *
 *  @return An object conforming to the OOPulseSession protocol.
 */
+ (id<OOPulseSession>)sessionWithContentMetadata:(OOContentMetadata *)contentMetadata
                                 requestSettings:(OORequestSettings *)requestSettings;

/**
 *  Set whether or not debug information from the SDK should be logged to the console.
 *
 * @param value YES if debug messages should be logged; NO otherwise.
 */
+ (void)logDebugMessages:(BOOL)value;

/**
 *  Method that requests the status of the debug messages logging inside the Pulse framework.
 *
 *  @return YES if debug messages are enabled; NO otherwise.
 */
+ (BOOL)isDebugLoggingEnabled;

@end


