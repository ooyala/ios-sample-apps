/**
 * @class OOAdsLearnMoreButton OOAdsLearnMoreButton.h "OOAdsLearnMoreButton.h"
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

@import UIKit;

@class OOAdMoviePlayer;

/**
  A button that enables the customer to click on an advertisement, and learn more about the ad
 */
@interface OOAdsLearnMoreButton : UIView

/**
  Initializes the learn more button, to be connected to a specific Ad Player
  @param adPlayer the Ad Player to interface with
  @return an initialized OOAdsLearnMoreButton
 */
- (instancetype)initWithAdPlayer:(OOAdMoviePlayer *)adPlayer;
/**
 Removes the button from the superview, but does not deallocate completely
 */
- (void)deleteButton;

@end
