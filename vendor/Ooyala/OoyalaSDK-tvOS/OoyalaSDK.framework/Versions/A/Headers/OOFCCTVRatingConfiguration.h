//
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

@import Foundation;
@import CoreGraphics;

typedef NS_ENUM(NSInteger, OOFCCTvRatingsPosition) {
  OOFCCTvRatingsPositionTopLeft,
  OOFCCTvRatingsPositionTopRight,
  OOFCCTvRatingsPositionBottomLeft,
  OOFCCTvRatingsPositionBottomRight
};

/**
 * Use this when first setting up the OoyalaPlayer to control
 * the layout and behavior of the TV Ratings stamp.
 */
@interface OOFCCTVRatingConfiguration : NSObject

@property (nonatomic, readonly) int durationSeconds;
@property (nonatomic, readonly) OOFCCTvRatingsPosition position;
@property (nonatomic, readonly) CGFloat scale;
@property (nonatomic, readonly) CGFloat opacity;

- (instancetype)init;
- (instancetype)initWithDurationSeconds:(int)durationSeconds
                               position:(OOFCCTvRatingsPosition)position
                                  scale:(CGFloat)scale
                                opacity:(CGFloat)opacity;

@end
