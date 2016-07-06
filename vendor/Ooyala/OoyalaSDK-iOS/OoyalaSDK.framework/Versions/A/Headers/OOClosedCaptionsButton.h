/**
 * @class OOClosedCaptionsButton OOClosedCaptionsButton.h "OOClosedCaptionsButton.h"
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A button that has a closed captions icon.  This button has no default actions or targets
 */
@interface OOClosedCaptionsButton : UIBarButtonItem

/**
 Initialize an OOClosedCaptionsButton
 @param[in] scale a multiplier to resize the button
 @returns an initialized OOClosedCaptionsButton, or nil
 */
- (id) initWithScale:(CGFloat)scale;

@end
