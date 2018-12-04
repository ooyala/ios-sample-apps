//
//  OOTimeSliderDelegate.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@protocol OOTimeSliderDelegate

- (void)onTimeScrubbingStarted:(CGFloat)absoluteValue;
- (void)onTimeScrubbingChanged:(CGFloat)absoluteValue;
- (void)onTimeScrubbingEnded:(CGFloat)absoluteValue;

@end
