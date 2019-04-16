//
//  OOVideoGravityButton.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "OOScalableImageButton.h"

#ifndef OOVideoGravityButton_h
#define OOVideoGravityButton_h

@interface OOVideoGravityButton : OOScalableImageButton

/**
 Set if the Fill icon is showing, or if the Fit icon is showing.
 @param isGravityFillShowing YES to show the Fill icon, or NO to show the Fit icon
 */
- (void)setIsGravityFillShowing:(BOOL)isGravityFillShowing;

@end

#endif /* OOVideoGravityButton_h */
