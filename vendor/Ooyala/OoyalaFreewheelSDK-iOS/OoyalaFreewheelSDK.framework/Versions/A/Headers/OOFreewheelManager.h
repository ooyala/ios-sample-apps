/**
 @class      OOFreewheelManager OOFreewheelManager.h "OOFreewheelManager.h"
 @brief      OOFreewheelManager
 @details    OOFreewheelManager.h in OoyalaFreewheelSDK
 @date       11/7/13
 @copyright  Copyright © 2013 Ooyala, Inc. All rights reserved.
 */

#import <OoyalaSDK/OOAdSpotPlugin.h>

@class OOOoyalaPlayerViewController;
@class OOOoyalaPlayer;
@class OOContentItem;
@class OOStateNotifier;
@protocol FWContext;
/**
 A class that manages Freewheel ads.
 */
@interface OOFreewheelManager : OOAdSpotPlugin<OOAdSpotPluginDelegate>

/** the Freewheel context from Freewheel SDK */
@property (nonatomic) id<FWContext> fwContext;

/** the state notifier to notify state changes */
@property (nonatomic) OOStateNotifier *stateNotifier;

/**
 if set to @c YES the ads click through url is opened in in-app web view
 if set to @c NO the ads click through url is opened in an external browser
 default value is @c NO
 */
@property (nonatomic) BOOL openClickThroughInApp;

/**
 Initialize a OOFreewheelManager using the OOOoyalaPlayerViewController
 @param viewController the @c OOOoylaPlayerViewController control the @c OOOoyalaPlayer's View
 @return the initialized OOFreewheelManager
 */
- (instancetype)initWithOoyalaPlayerViewController:(OOOoyalaPlayerViewController *)viewController;

/**
 Initialize a OOFreewheelManager using the OOOoyalaPlayer
 @param player the OOOoylaPlayer
 @return the initialized OOFreewheelManager
 */
- (instancetype)initWithOoyalaPlayer:(OOOoyalaPlayer *)player;

/**
 Sets the Freewheel ad parameters to override values from Backlot and Backdoor.
 @code
 <pre><b> Key                            Example Value</b>
 "fw_android_mrm_network_id"    "42015"
 "fw_android_ad_server"         "http://demo.v.fwmrm.net/"
 "fw_android_player_profile"    "fw_tutorial_android"
 "fw_android_site_section_id"   "fw_tutorial_android"
 "fw_android_video_asset_id"    "fw_simple_tutorial_asset"</pre>
 @endcode
 @param freewheelParameters Dictionary with the above defined string keys and values
 */
- (void)overrideFreewheelParameters:(NSMutableDictionary *)freewheelParameters;

@end
