//
//  OOUIProgressSliderIOS7.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "OOCuePointsView.h"
//Action at end of video
enum
{
  OOUIProgressSliderModeLive,
  OOUIProgressSliderModeAdInLive,
  OOUIProgressSliderModeNormal,
  OOUIProgressSliderModeLiveNoSrubber
};
typedef NSInteger OOUIProgressSliderMode;

@interface OOUIProgressSliderIOS7 : UIView<OOCuePointViewDurationDataSource> {
  OOUIProgressSliderMode mode;
}

@property (nonatomic) float duration;
@property (nonatomic) float currentTime;
@property (nonatomic) float currentAvailableTime;
@property (nonatomic) OOUIProgressSliderMode mode;
@property (nonatomic) CMTimeRange seekableTimeRange;
@property (nonatomic) UILabel *liveIndicator;
@property (nonatomic) UISlider *scrubber;
@property (nonatomic) NSSet *cuePointsAtSeconds; /**< NSNumber int seconds */

- (void)updateTimeDisplay;

- (Float64)scrubberAbsoluteValue;

- (void)drawLiveIndicator;

@end
