//
//  VPCategory.h
//  Pulse
//
//  Created by Joao Sampaio on 09/02/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Used in creative separation and for compliance in certain programs, a category field is needed to categorize the ad’s content.
 */
@interface OOAdCategory : NSObject

/**
 A string that provides a category code or label that identifies the ad content.
 */
- (NSString *)category;

/**
 A URL for the organizational authority that produced the list being used to identify ad content.
 */
- (NSURL *)authority;

@end
