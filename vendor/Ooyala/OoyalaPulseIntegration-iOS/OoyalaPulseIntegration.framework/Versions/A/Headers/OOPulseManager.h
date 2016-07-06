//
//  OOPulseManager.h
//  PulseOVPTestApp
//
//  Created by Jacques du Toit on 03/02/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <OoyalaSDK/OOAdSpotPlugin.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <Pulse/Pulse.h>

@class OOPulseManager;

/**
 *  The OOPulseManagerDelegate protocol provides a way for the OOPulseManager
 *  to communicate with the host application.
 *
 *  This delegate allows you to override the content metadata and request settings
 *  from Ooyala Backlot dynamically, and customize your response to clickthrough events.
 */
@protocol OOPulseManagerDelegate <NSObject>

/**
 *  Requests the delegate to create a Pulse ad session,
 *  which contains information about all ads that should be played
 *  along with the current video content.
 *
 *  The content metadata and request settings are pre-populated with information
 *  from Backlot according to [this scheme](http://support.ooyala.com/users/documentation/reference/adset_fields_pulse.html). The implementation
 *  may freely override any or all of these properties.
 *
 *  @param manager          The Pulse Manager which will create the session.
 *  @param video            The current video content.
 *  @param pulseHost        Your Pulse account host.
 *  @param contentMetadata  The content metadata.
 *  @param requestSettings  The request settings.
 *  @return The newly created Pulse ad session.
 */
- (id<OOPulseSession>)pulseManager:(OOPulseManager *)manager
             createSessionForVideo:(OOVideo *)video
                     withPulseHost:(NSString *)pulseHost
                   contentMetadata:(VPContentMetadata *)contentMetadata
                   requestSettings:(VPRequestSettings *)requestSettings;

@optional

/**
 *  This method is called when the app should show the clickthrough link.
 *
 *  The app must trigger [OOPulseVideoAd.adClickThroughTriggered](http://pulse-sdks.ooyala.com/ios_2/latest/Protocols/OOPulseVideoAd.html#//api/name/adClickThroughTriggered) to notify the
 *  session if the clickthrough link has been opened. You can obtain the URL to open
 *  with [OOPulseVideoAd.clickthroughURL](http://pulse-sdks.ooyala.com/ios_2/latest/Protocols/OOPulseVideoAd.html#//api/name/clickthroughURL)
 *
 *  @note If you leave this method unimplemented, the Pulse Manager automatically
 *        opens the clickthrough link when clicked using the default iOS browser.
 *
 *  @param manager The Pulse Manager from which this request originated.
 *  @param ad      The Ad for which the clickthrough URL must be opened.
 */
- (void)pulseManager:(OOPulseManager *)manager openClickThrough:(id<OOPulseVideoAd>)ad;

@end

/**
 The Pulse Manager plugin allows you to display ads from Ooyala Pulse in the Ooyala Player.
*/
@interface OOPulseManager : NSObject<OOAdPlugin>

/**
 *  Initialize the Pulse Manager.
 *
 *  @param player The Ooyala Player to associate with this ad manager.
 *
 *  @return The OOPulseManager instance.
 */
- (instancetype)initWithPlayer:(OOOoyalaPlayer*)player;


/**
 *  The object that acts as the delegate of the Pulse Manager.
 *
 *  The delegate must adopt the OOPulseManagerDelegate protocol.
 */
@property (weak, nonatomic) id<OOPulseManagerDelegate> delegate;

@end
