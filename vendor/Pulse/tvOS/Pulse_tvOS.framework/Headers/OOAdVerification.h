//
//  OOAdVerification.h
//  Pulse
//
//  Created by Joao Sampaio on 22/06/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The AdVerification is used to contain the JavaScript or Flash code used to collect data. Multiple Verification elements may be used in cases where more than one verification vendor needs to collect data or when different API frameworks are used.
 */
@interface OOAdVerification : NSObject

/**
 A container for the URL to the JavaScript file used to collect verification data.
 */
- (NSURL *)javaScriptResource;

/**
 The name of the Javascript API framework used to execute the AdVerification code.
 */
- (NSString *)javaScriptApiFramework;

/**
 A container for the URL to the Flash file used to collect verification data.
 */
- (NSURL *)flashResource;

/**
 The name of the Flash API framework used to execute the AdVerification code.
 */
- (NSString *)flashApiFramework;

/**
 The home page URL for the verification service provider that supplies the resource file.
 */
- (NSURL *)vendor;

@end
