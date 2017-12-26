//
//  OOVolumeSliderDelegate.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@protocol OOVolumeSliderDelegate

- (void)onVolumeScrubbingStarted:(float)absoluteValue;
- (void)onVolumeScrubbingChanged:(float)absoluteValue;
- (void)onVolumeScrubbingEnded:(float)absoluteValue;

@end
