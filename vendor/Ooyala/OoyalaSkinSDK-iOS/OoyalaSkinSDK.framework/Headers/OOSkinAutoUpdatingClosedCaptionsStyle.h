//
//  OOSkinAutoUpdatingClosedCaptionsStyle.h
//  OoyalaSkinSDK
//
//  Created by Jon Slenk on 6/4/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

#import <OoyalaSDK/OOClosedCaptionsStyle.h>

@class OOClosedCaptionsView;

@interface OOSkinAutoUpdatingClosedCaptionsStyle : OOClosedCaptionsStyle
- (instancetype)initWithClosedCaptionsView:(OOClosedCaptionsView*)ccView;
@end

