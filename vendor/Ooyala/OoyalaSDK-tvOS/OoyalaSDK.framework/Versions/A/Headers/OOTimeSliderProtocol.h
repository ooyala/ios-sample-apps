//
//  OOTimeSliderProtocol.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "OOOoyalaPlayer.h" // Neef for visible OOUIProgressSliderMode enum


@protocol OOTimeSliderProtocol

- (void)setDuration:(float)duration;
- (void)setCurrentTime:(float)currentTime;
- (void)setCurrentAvailableTime:(float)currentAvailableTime;
- (void)setSeekableTimeRange:(CMTimeRange)seekableTimeRange;
- (void)setCuePointsAtSeconds:(NSSet *)cuePoints;
- (void)setTimeScrubberMode:(OOUIProgressSliderMode)mode;
- (void)setTimeScrubberUserInteractionEnabled:(BOOL)enabled;
- (void)updateTimeDisplay;

@end
