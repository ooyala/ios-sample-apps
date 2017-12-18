//
//  OOIFrameResource.h
//  Pulse
//
//  Created by Jacques du Toit on 03/06/15.
//  Copyright (c) 2015 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Pulse_tvOS/OOResource.h>

/**
 A resource used by OOPulseCompanionAd to be displayed within an IFrame.
 */
@interface OOIFrameResource : OOResource

/**
 The URL of the resource that should be loaded within the IFrame.
 */
- (NSURL *)URL;

@end
