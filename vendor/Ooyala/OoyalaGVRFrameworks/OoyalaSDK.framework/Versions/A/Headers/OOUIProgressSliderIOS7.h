/**
 * @class OOUIProgressSliderIOS7 OOUIProgressSliderIOS7.h "OOUIProgressSliderIOS7.h"
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "OOCuePointsView.h"
#import "OOOoyalaPlayer.h"

/**
 A view that can display the the current time, duration, and scrubber.
 */
@interface OOUIProgressSliderIOS7 : UIView<OOCuePointViewDurationDataSource> {
  OOUIProgressSliderMode mode;
}

@property (nonatomic) float duration; /**< The duration to display in the slider, in seconds */
@property (nonatomic) float currentTime; /**< The current time to display in the slider, in seconds */
@property (nonatomic) float currentAvailableTime; /**< The available buffer time to display on the slider, in seconds */
@property (nonatomic) OOUIProgressSliderMode mode; /**< The UI style to use in the slider */
@property (nonatomic) CMTimeRange seekableTimeRange; /**< The seekable time range of the OoyalaPlayer */
@property (nonatomic) UILabel *liveIndicator; /**< A label that indicates if the video is live or not */
@property (nonatomic) UISlider *scrubber; /** The UISlider used for scrubbing */
@property (nonatomic) NSSet *cuePointsAtSeconds; /**< The set of NSNumber cuepoints to render, in seconds */

/**
 Force the slider to render up-to-date duration, current time, and slider position
 */
- (void)updateTimeDisplay;

/**
 Get the absolute value of the scrubber.  Used primarily during live streaming
 @returns the absolute value of the scrubber's value
 */
- (Float64)scrubberAbsoluteValue;
/**
 Force the slider to render the "Live" indicator
 */
- (void)drawLiveIndicator;

@end
