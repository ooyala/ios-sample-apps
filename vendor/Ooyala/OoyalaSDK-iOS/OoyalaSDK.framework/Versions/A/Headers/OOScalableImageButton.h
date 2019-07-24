//
//  OOScalableImageButton.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@import UIKit.UIButton;

#ifndef OOScalableImageButton_h
#define OOScalableImageButton_h

@interface OOScalableImageButton : UIButton

@property (nonatomic) CGFloat scale;

/**
 Initialize an OOScalableImageButton
 @param scale a multiplier to resize the button
 @return an initialized OOScalableImageButton, or nil
 */
- (instancetype)initWithScale:(CGFloat)scale;

@end

#endif /* OOScalableImageButton_h */
