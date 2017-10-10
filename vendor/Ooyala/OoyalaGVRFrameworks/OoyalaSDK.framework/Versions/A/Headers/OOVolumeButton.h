//
//  OOVolumeButton.h
//  OoyalaSDK
//
//  Created by Zhihui Chen on 12/17/15.
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A button that has a volume icon.  This button has no default actions or targets
 */
@interface OOVolumeButton : UIBarButtonItem

/**
 Initialize an OOFullscreenButton
 @param[in] scale a multiplier to resize the button
 @returns an initialized OOFullscreenButton, or nil
 */
- (id) initWithScale:(CGFloat)scale;

@end