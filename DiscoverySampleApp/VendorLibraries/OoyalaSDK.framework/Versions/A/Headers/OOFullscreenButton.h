/**
 * @class OOFullscreenButton OOFullscreenButton.h "OOFullscreenButton.h"
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A button that has a fullscreen icon.  This button has no default actions or targets
 */
@interface OOFullscreenButton : UIBarButtonItem

/**
 Initialize an OOFullscreenButton
 @param[in] scale a multiplier to resize the button
 @returns an initialized OOFullscreenButton, or nil
 */
- (id) initWithScale:(CGFloat)scale;

@end
