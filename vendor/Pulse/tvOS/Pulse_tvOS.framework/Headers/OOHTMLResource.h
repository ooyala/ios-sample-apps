//
//  OOHTMLResource.h
//  Pulse
//
//  Created by Jacques du Toit on 03/06/15.
//  Copyright (c) 2015 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Pulse_tvOS/OOResource.h>

/** 
 A resource containing HTML code, used by OOPulseCompanionAd 
 */
@interface OOHTMLResource : OOResource

/** 
 The HTML code to render when the companion is displayed.
 */
- (NSString *)HTML;

@end
