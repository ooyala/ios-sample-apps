/**
 * @class OOCuePointsView OOCuePointsView.h "OOCuePointsView.h"
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 An interface that gives OOCuePointsView the duration to use when rendering its cuepoints
 */
@protocol OOCuePointViewDurationDataSource
@property (nonatomic, readonly) float duration; /**< The duration of a video */
@end

/**
 A view that renders the cue points of advertisements within a certain frame
 */
@interface OOCuePointsView : UIView
@property (nonatomic) NSSet *cuePointsAtSeconds; /**< The set of NSNumber cuepoints to render, in seconds */

/**
 Initialize an OOCuePointsView. This constructor is not available. Please use initWithFrame:padding:durationDataSource:diameter instead
 */
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable));

/**
 Initialize an OOCuePointsView
 @param[in] frame the frame to render cue points in
 @param[in] padding size of padding to be used on the left and right of the cue points
 @param[in] durationDataSource a class which can be queried for duration of the playing asset
 @param[in] diameter the diameter of the cue points to be rendered
 @returns an initialized OOCuePointsView, or nil
 */
- (instancetype)initWithFrame:(CGRect)frame padding:(float)padding durationDataSource:(id <OOCuePointViewDurationDataSource>)durationDataSource diameter:(float)diameter;
@end