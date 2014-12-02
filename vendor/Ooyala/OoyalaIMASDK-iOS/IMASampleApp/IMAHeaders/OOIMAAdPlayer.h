/**
 * @class      OOAdMoviePlayer OOAdMoviePlayer.h "OOAdMoviePlayer.h"
 * @brief      OOAdMoviePlayer
 * @details    OOAdMoviePlayer.h in OoyalaIMASDK
 * @date       24/7/13
 * @copyright  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
 */

#import "OOAdMoviePlayer.h"
#import "OOIMAManager.h"

@interface OOIMAAdPlayer : OOAdMoviePlayer <OOIMAManagerDelegate>
- (id)initWithIMAManager:(OOIMAManager *)imaManager;
-(void)setFrame:(CGRect)frame;
-(void)resumeContent;
-(OOOoyalaPlayerState)state;
-(void)schedulePlaybackTimeUpdate;
@end
