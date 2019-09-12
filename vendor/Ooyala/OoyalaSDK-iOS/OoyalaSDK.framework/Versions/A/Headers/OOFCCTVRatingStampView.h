//
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

@import UIKit;

#import "OOPlayerState.h"

@class OOPlayer;
@class OOFCCTVRating;
@class OOFCCTVRatingConfiguration;

@interface OOFCCTVRatingStampView : UIView

@property (nonatomic, weak) OOPlayer *player;
@property (nonatomic, weak) OOFCCTVRating *tvRating;
@property (nonatomic, weak) OOFCCTVRatingConfiguration *tvRatingConfiguration;
@property (nonatomic) OOOoyalaPlayerVideoGravity videoGravity;

- (instancetype) __unavailable initWithCoder:(NSCoder *)aDecoder;

- (BOOL)pointInside:(CGPoint)point; /**< point must already be in our coordinate system. */

@end
