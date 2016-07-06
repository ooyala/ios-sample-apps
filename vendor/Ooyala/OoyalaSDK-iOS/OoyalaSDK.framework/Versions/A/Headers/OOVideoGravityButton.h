/**
 * @class OOVideoGravityButton OOVideoGravityButton.h "OOVideoGravityButton.h"
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A button that can toggle between Fill and Fit icons. This button has no default actions or targets
 */
@interface OOVideoGravityButton : UIBarButtonItem

/**
 Initialize an OOVideoGravityButton
 @param[in] scale a multiplier to resize the button
 @returns an initialized OOVideoGravityButton, or nil
 */
- (id) initWithScale:(CGFloat)scale;
/**
 Set if the Fill icon is showing, or if the Fit icon is showing.
 @param[in] isGravityFillShowing YES to show the Fill icon, or NO to show the Fit icon
 */
- (void)setIsGravityFillShowing:(BOOL)isGravityFillShowing;
@end
