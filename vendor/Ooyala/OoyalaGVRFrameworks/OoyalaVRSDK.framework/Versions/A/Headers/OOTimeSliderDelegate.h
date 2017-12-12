//
//  OOTimeSliderDelegate.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@protocol OOTimeSliderDelegate

- (void)onTimeScrubbingStarted:(float)absoluteValue;
- (void)onTimeScrubbingChanged:(float)absoluteValue;
- (void)onTimeScrubbingEnded:(float)absoluteValue;

@end
