/**
 * @class      OOIMAAdPlayer OOIMAAdPlayer.h "OOIMAAdPlayer.h"
 * @copyright  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
 */

#import "OOAdMoviePlayer.h"
#import "OOIMAManager.h"

@interface OOIMAAdPlayer : OOAdMoviePlayer <OOIMAManagerDelegate>


/**
 * Initialize a OOIMAAdPlayer using the given OOIMAManager
 * @param[in] imaManager the current OOIMAManager connected to OoyalaPlayer
 * @returns the initialized OOIMAAdPlayer
 */
- (id)initWithIMAManager:(OOIMAManager *)imaManager;

/**
 * Set the frame of this OOIMAAdPlayer to be the given CGRect
 * @param[in] frame the frame to be set
 */
-(void)setFrame:(CGRect)frame;

/**
 * Resume content playback
 */
-(void)resumeContent;

/**
 * @returns the current OOOoyalaPlayerState for IMA Ads Playback
 */
-(OOOoyalaPlayerState)state;

/**
 * Schedule a non-repeated Timer to update current Playback time based on content playback every 0.25 second
 */
-(void)schedulePlaybackTimeUpdate;
@end
