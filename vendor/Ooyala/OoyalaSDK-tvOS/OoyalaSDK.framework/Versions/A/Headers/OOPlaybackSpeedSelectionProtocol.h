//
//  OOPlaybackSpeedSelectionProtocol.h
//  OoyalaSDK
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//


@protocol OOPlaybackSpeedSelectionProtocol <NSObject>
/**
 Requests to change the current playback speed rate to the one provided as a parameter.
 @param playbackSpeedRate to be used
 */
- (void)changePlaybackSpeedRate:(float)playbackSpeedRate;

@end
