//
//  OOFCCTVRatingVideoView.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOFCCTVRating.h"
#import "OOFCCTVRatingConfiguration.h"
#import "OOOoyalaPlayer.h"

@class OOPlayer;

@interface OOFCCTVRatingVideoView : UIView
-(id) __unavailable initWithCoder:(NSCoder *)aDecoder;
-(void) setContentPlayerAndSubview:(OOPlayer*)player;
-(void) setAdPlayerAndSubview:(OOPlayer*)player;
@property (nonatomic) OOFCCTVRating *tvRating;
@property (nonatomic) OOFCCTVRatingConfiguration *tvRatingConfiguration;
@property (nonatomic) OOOoyalaPlayerVideoGravity videoGravity;
@end
