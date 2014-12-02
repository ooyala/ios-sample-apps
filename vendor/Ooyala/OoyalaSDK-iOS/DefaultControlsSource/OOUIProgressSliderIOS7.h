//
//  OOUIProgressSliderIOS7.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 8/22/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "OOUIProgressSlider.h"
#import "OOCuePointsView.h"
//Action at end of video
enum
{
  OOUIProgressSliderModeLiveIOS7,
  OOUIProgressSliderModeAdInLiveIOS7,
  OOUIProgressSliderModeNormalIOS7,
  OOUIProgressSliderModeLiveNoSrubberIOS7
};
typedef NSInteger OOUIProgressSliderModeIOS7;

@interface OOUIProgressSliderIOS7 : UIView<OOCuePointViewDurationDataSource> {
  OOUIProgressSliderModeIOS7 mode;
}

@property (nonatomic) float duration;
@property (nonatomic) float currentTime;
@property (nonatomic) float currentAvailableTime;
@property (nonatomic) OOUIProgressSliderModeIOS7 mode;
@property (nonatomic) CMTimeRange seekableTimeRange;
@property (nonatomic) UILabel *liveIndicator;
@property (nonatomic) UISlider *scrubber;
@property (nonatomic) NSSet *cuePointsAtSeconds; /**< NSNumber int seconds */

- (void)updateTimeDisplay;

- (Float64)scrubberAbsoluteValue;

- (void)drawLiveIndicator;

@end
