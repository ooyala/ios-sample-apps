/**
 * @class      OOUIProgressSlider OOUIProgressSlider.h "OOUIProgressSlider.h"
 * @brief      OOUIProgressSlider
 * @details    OOUIProgressSlider.h in OoyalaSDK
 * @date       1/9/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

//Action at end of video
enum
{
  OOUIProgressSliderModeLive,
  OOUIProgressSliderModeAdInLive,
  OOUIProgressSliderModeNormal,
  OOUIProgressSliderModeLiveNoSrubber
};
typedef NSInteger OOUIProgressSliderMode;


@interface OOUIProgressSlider : UIView {
  OOUIProgressSliderMode mode;
}

@property (nonatomic) float duration;
@property (nonatomic) float currentTime;
@property (nonatomic) float currentAvailableTime;
@property (nonatomic) OOUIProgressSliderMode mode;
@property (nonatomic) CMTimeRange seekableTimeRange;

@property (nonatomic) UISlider *scrubber;


- (void)updateTimeDisplay;

- (Float64)scrubberAbsoluteValue;
@end
