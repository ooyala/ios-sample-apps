//
//  OOAdMoviePlayer.h
//  OoyalaSDK
//
//  Created by Michael Len on 3/6/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import "OOMoviePlayer.h"

@class OOAdSpot;

@interface OOAdMoviePlayer : OOMoviePlayer
	//@property(readonly, nonatomic, weak) OOAdSpot *ad;
- (id) initWithAd:(OOAdSpot *)ad;

/** @internal
 * Call to send the click tracking events from the VastAdPlayer when Learn More button is clicked on
 */
- (void)processClickThrough;

@end
