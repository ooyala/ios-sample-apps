/**
 * @class OOAdsLearnMoreButton OOAdsLearnMoreButton.h "OOAdsLearnMoreButton.h"
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class OOAdMoviePlayer;

/**
  A button that enables the customer to click on an advertisement, and learn more about the ad
 */
#if TARGET_OS_TV
@interface OOAdsLearnMoreButton : UIView
#elif TARGET_OS_IOS
@interface OOAdsLearnMoreButton : UIView <UIWebViewDelegate>
#endif

/**
  Initializes the learn more button, to be connected to a specific Ad Player
  @param AdsPlayer the Ad Player to interface with
  @return an initialized OOAdsLearnMoreButton
 */
-(id)initWithAdPlayer:(OOAdMoviePlayer *) AdsPlayer;
/**
 Removes the button from the superview, but does not deallocate completely
 */
-(void)deleteButton;
@end
