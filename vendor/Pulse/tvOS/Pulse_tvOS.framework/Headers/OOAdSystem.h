//
//  OOAdSystem.h
//  Pulse
//
//  Created by Joao Sampaio on 13/02/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A descriptive name for the system that serves the ad. Optionally, a version number for the ad system may also be provided using the version attribute.
 */
@interface OOAdSystem : NSObject

/**
 A string that provides the name of the ad server that returned the ad.
 */
- (NSString *)name;

/**
 A string that provides the version number of the ad system that returned the ad.
 */
- (NSString *)version;

@end
