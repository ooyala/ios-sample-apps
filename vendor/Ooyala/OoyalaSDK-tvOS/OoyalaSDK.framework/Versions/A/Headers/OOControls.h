//
//  OOControls.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@protocol OOControls <NSObject>

// TODO: - need ensure that protocol's method -setIsPlayingState: used in all linked SDK's only for play/pause icon and improove naming
- (void)setIsPlayingState:(BOOL)isPlaying;
- (void)setFullscreenButtonShowing:(BOOL)showing;
- (void)setAirPlayButtonShowing:(BOOL)showing;
- (void)setClosedCaptionsButtonShowing:(BOOL)showing;
- (void)setVideoGravityButtonShowing:(BOOL)showing;
- (void)setGravityState:(BOOL)isZoomed;
- (void)setHiddenControls:(BOOL)hidden;
- (void)setPiPButtonShowing:(BOOL)showing;
- (void)showReplayButton;

@end
