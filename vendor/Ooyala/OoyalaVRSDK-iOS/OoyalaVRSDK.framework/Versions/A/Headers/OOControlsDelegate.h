//
//  OOControlsDelegate.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@protocol OOControlsDelegate <NSObject>

- (void)playPauseButtonDidSelected:(id)sender;
- (void)nextButtonDidSelected:(id)sender;
- (void)previousePauseButtonDidSelected:(id)sender;
- (void)fullscreenButtonDidSelected:(id)sender;
- (void)airPlayButtonDidSelected:(id)sender;
- (void)gravityFillButtonDidSelected:(id)sender;
- (void)closedCaptionsButtonDidSelected:(id)sender;
- (void)doneButtonDidSelect:(id)sender;

@end
