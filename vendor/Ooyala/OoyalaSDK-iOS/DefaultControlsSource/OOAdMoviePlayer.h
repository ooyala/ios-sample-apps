//
//  OOAdMoviePlayer.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
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
