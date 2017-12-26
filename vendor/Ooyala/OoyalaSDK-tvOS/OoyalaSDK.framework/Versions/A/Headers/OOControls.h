//
//  OOControls.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@protocol OOControls <NSObject>

- (void)setIsPlayingState:(BOOL)isPlaying;
- (void)setFullscreenButtonShowing:(BOOL)showing;
- (void)setAirPlayButtonShowing:(BOOL)showing;
- (void)setClosedCaptionsButtonShowing:(BOOL)showing;
- (void)setVideoGravityButtonShowing:(BOOL)showing;
- (void)setGravityState:(BOOL)isZoomed;
- (void)setHiddenControls:(BOOL)hidden;

@end
