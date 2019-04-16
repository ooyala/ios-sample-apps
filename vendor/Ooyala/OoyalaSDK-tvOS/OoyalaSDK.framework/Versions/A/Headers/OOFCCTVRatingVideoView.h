//
//  OOFCCTVRatingVideoView.h
//  OoyalaSDK
//
// Copyright © 2015 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOFCCTVRating.h"
#import "OOFCCTVRatingConfiguration.h"
#import "OOOoyalaPlayer.h"

@class OOPlayer;

@interface OOFCCTVRatingVideoView : UIView

@property (nonatomic) OOFCCTVRating *tvRating;
@property (nonatomic) OOFCCTVRatingConfiguration *tvRatingConfiguration;
@property (nonatomic) OOOoyalaPlayerVideoGravity videoGravity;

- (instancetype) __unavailable initWithCoder:(NSCoder *)aDecoder;
- (void)setContentPlayerAndSubview:(OOPlayer*)player;
- (void)setAdPlayerAndSubview:(OOPlayer*)player;

@end
