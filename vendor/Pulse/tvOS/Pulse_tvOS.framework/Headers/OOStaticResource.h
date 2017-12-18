//
//  OOStaticResource.h
//  Pulse
//
//  Created by Jacques du Toit on 03/06/15.
//  Copyright (c) 2015 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Pulse_tvOS/OOResource.h>

/**
 A static resource, such as an image or Flash banner, used by OOPulseCompanionAd.
 */
@interface OOStaticResource : OOResource

/**
 A URL of a page which should be opened when the user clicks a companion 
 displaying the static resource.
 */
- (NSURL *)clickThroughURL;

/**
 Asset MIME type. 
 Equal to creativeType in the VAST 3.0 spec.
*/
- (NSString *)mimeType;

/**
 The URL of the asset to display.
 */
- (NSURL *)URL;

@end
