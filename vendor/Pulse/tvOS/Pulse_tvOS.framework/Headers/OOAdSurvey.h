//
//  OOAdSurvey.h
//  Pulse
//
//  Created by Joao Sampaio on 10/02/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The AdSurvey is used to provide a URL to any resource file having to do with collecting survey data.
 */
@interface OOAdSurvey : NSObject

/**
 The URL to any resource relating to an integrated survey.
 */
- (NSURL *)survey;

/**
 The MIME type of the resource being served.
 */
- (NSString *)mimeType;

@end
