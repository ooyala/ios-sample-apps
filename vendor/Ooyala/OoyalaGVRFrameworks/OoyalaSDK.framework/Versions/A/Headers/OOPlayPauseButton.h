/**
 * @class OOFullscreenButton OOFullscreenButton.h "OOFullscreenButton.h"
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A button that can toggle between play and pause icons.  This button calls selectors for "play" and "pause" on their target
 */
@interface OOPlayPauseButton : UIBarButtonItem

@property (nonatomic) BOOL isPlayShowing; /**< set to YES to show the play icon, or NO to show the pause icon */

/**
 Initialize an OOPlayPauseButton
 @param[in] scale a multiplier to resize the button
 @returns an initialized OOPlayPauseButton, or nil
 */
- (id) initWithScale:(CGFloat)scale;

@end
