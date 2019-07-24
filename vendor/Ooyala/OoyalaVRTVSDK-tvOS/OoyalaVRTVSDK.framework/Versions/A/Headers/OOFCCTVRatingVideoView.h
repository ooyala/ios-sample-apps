//
//  OOFCCTVRatingVideoView.h
//  OoyalaSDK
//
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

@import UIKit;

#import "OOPlayerState.h"

@class OOPlayer;
@class OOOoyalaPlayer;
@class OOFCCTVRatingConfiguration;
@class OOFCCTVRating;

@interface OOFCCTVRatingVideoView : UIView

@property (nonatomic) OOFCCTVRating *tvRating;
@property (nonatomic) OOFCCTVRatingConfiguration *tvRatingConfiguration;
@property (nonatomic) OOOoyalaPlayerVideoGravity videoGravity;

- (instancetype) __unavailable initWithCoder:(NSCoder *)aDecoder;
- (void)setContentPlayerAndSubview:(OOPlayer *)player;
- (void)setAdPlayerAndSubview:(OOPlayer *)player;

@end
