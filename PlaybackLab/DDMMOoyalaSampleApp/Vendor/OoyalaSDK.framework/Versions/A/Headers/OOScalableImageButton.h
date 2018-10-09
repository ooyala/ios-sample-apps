//
//  OOScalableImageButton.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOImages.h"


@interface OOScalableImageButton : UIButton

@property (nonatomic) CGFloat scale;

/**
 Initialize an OOPlayPauseButton
 @param[in] scale a multiplier to resize the button
 @returns an initialized OOPlayPauseButton, or nil
 */
- (instancetype)initWithScale:(CGFloat)scale;

@end
