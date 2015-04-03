/**
 * @class      OOFreewheelManager OOFreewheelManager.h "OOFreewheelManager.h"
 * @brief      OOFreewheelManager
 * @details    OOFreewheelManager.h in OoyalaFreewheelSDK
 * @date       11/7/13
 * @copyright  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AdManager/FWSDK.h>
#import <OoyalaSDK/OOAdSpotPlugin.h>

@class OOOoyalaPlayerViewController;
@class OOContentItem;
@class OOStateNotifier;

/**
 * A class that manages Freewheel ads. 
 */
@interface OOFreewheelManager : OOAdSpotPlugin<OOAdSpotPluginDelegate>

/** the Freewheel context from Freewheel SDK */
@property(nonatomic) id<FWContext> fwContext;

/** the state notifier to notify state changes */
@property(nonatomic) OOStateNotifier *stateNotifier;

/** if set to YES the ads click through url is opened in in-app web view, if set to NO the ads click through url is opened in an external browser, default value is NO */
@property(nonatomic) BOOL openClickThroughInApp;

 /**
 * Initialize a OOFreewheelManager using the OOOoyalaPlayerViewController
 * @param[in] viewController the OOOoylaPlayerViewController control the OOOoyalaPlayer's View
 * @return the initialized OOFreewheelManager
 */
- (id)initWithOoyalaPlayerViewController:(OOOoyalaPlayerViewController *)viewController;

/**
 * Sets the Freewheel ad parameters to override values from Backlot and Backdoor.
 * <pre><b> Key                            Example Value</b>
 * "fw_android_mrm_network_id"    "42015"
 * "fw_android_ad_server"         "http://demo.v.fwmrm.net/"
 * "fw_android_player_profile"    "fw_tutorial_android"
 * "fw_android_site_section_id"   "fw_tutorial_android"
 * "fw_android_video_asset_id"    "fw_simple_tutorial_asset"</pre>
 * @param[in] freewheelParameters Dictionary with the above defined string keys and values
 */
- (void)overrideFreewheelParameters:(NSMutableDictionary *)freewheelParameters;

@end
