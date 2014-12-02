/**
 * @class      OOIMAAdSpot OOIMAAdSpot.h "OOIMAAdSpot.h"
 * @brief      OOIMAAdSpot
 * @details    OOIMAAdSpot.h in OoyalaIMASDK
 * @date       24/7/13
 * @copyright  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "OOAdSpot.h"

@class OOIMAManager;

@interface OOIMAAdSpot : OOAdSpot

@property(nonatomic, readonly, weak) OOIMAManager *adManager; /**< OOIMAManager of the current ads */

/**
 * Initialize a OOIMAAdSpot using OOIMAManager
 * @param[in] manager the OOIMAManager for the current ads
 * @returns the initialized OOIMAAdSpot
 */
-(id)initWithAdManager:(OOIMAManager *)adManager;

@end
