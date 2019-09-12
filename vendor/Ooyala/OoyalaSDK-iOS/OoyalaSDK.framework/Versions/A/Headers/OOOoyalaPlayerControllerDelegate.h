//
//  OOOoyalaPlayerControllerDelegate.h
//  OoyalaSDK
//
//  Created on 6/21/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#ifndef OOOoyalaPlayerControllerDelegate_h
#define OOOoyalaPlayerControllerDelegate_h

@import UIKit;

@protocol OOOoyalaPlayerControllerDelegate

- (void)onFullscreenDoneButtonClick;
- (void)showFullscreen;
- (void)closedCaptionsSelector;
- (void)switchVideoGravity;

/**
 update closed caption view position
 @param bottomControlsRect the bottom controls rect
 @param hidden @c YES if the bottom control is hidden, NO if it is not hidden
 */
- (void)updateClosedCaptionsViewPosition:(CGRect)bottomControlsRect
                        withControlsHide:(BOOL)hidden;

@optional
#if !TARGET_OS_TV
- (BOOL)doesPreferStatusBarHidden;
- (UIInterfaceOrientationMask)supportedIfaceOrientations;
#endif

@end

#endif /* OOOoyalaPlayerControllerDelegate_h */
