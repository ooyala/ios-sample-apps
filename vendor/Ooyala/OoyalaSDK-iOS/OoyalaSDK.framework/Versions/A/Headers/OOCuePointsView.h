/**
 * @class OOCuePointsView OOCuePointsView.h "OOCuePointsView.h"
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>

/**
 An interface that gives OOCuePointsView the duration to use when rendering its cuepoints
 */
@protocol OOCuePointViewDurationDataSource

@property (nonatomic, readonly) double duration; /**< The duration of a video */

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
 @param frame the frame to render cue points in
 @param padding size of padding to be used on the left and right of the cue points
 @param durationDataSource a class which can be queried for duration of the playing asset
 @param diameter the diameter of the cue points to be rendered
 @return an initialized OOCuePointsView, or nil
 */
- (instancetype)initWithFrame:(CGRect)frame
                      padding:(CGFloat)padding
           durationDataSource:(id <OOCuePointViewDurationDataSource>)durationDataSource
                     diameter:(CGFloat)diameter;
@end
