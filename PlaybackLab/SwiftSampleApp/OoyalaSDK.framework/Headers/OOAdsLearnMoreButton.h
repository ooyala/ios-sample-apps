/**
 * @class OOAdsLearnMoreButton OOAdsLearnMoreButton.h "OOAdsLearnMoreButton.h"
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOAdMoviePlayer.h"

/**
  A button that enables the customer to click on an advertisement, and learn more about the ad
 */
@interface OOAdsLearnMoreButton : UIView<UIWebViewDelegate>

/**
  Initializes the learn more button, to be connected to a specific Ad Player
  @param[in] AdsPlayer the Ad Player to interface with
  @returns an initialized OOAdsLearnMoreButton
 */
-(id)initWithAdPlayer:(OOAdMoviePlayer *) AdsPlayer;
/**
 Removes the button from the superview, but does not deallocate completely
 */
-(void)deleteButton;
@end
