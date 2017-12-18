//
//  OOUniversalAdId.h
//  Pulse
//
//  Created by Joao Sampaio on 10/02/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The Universal Ad Identifier is used to provide a unique creative identifier that is maintained across systems.
 */
@interface OOUniversalAdId : NSObject

/**
 A string identifying the unique creative identifier.
 */
- (NSString *)identifier;

/**
 A string used to identify the URL for the registry webside where the unique creative ID is cataloged. Default value is "unknown".
 */
- (NSString *)registry;

@end
