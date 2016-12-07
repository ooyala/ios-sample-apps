//
//  OOIQConfiguration.h
//  OoyalaSDK
//
//  Created by Unnath Kumar on 10/11/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#define OOIQCONFIGURATION_PLAYER_ID @"ooyala ios player" /** default player ID value. */

/**
 * Configurable values for IQ Analytics
 * \ingroup key
 */
@interface OOIQConfiguration : NSObject
@property (nonatomic) NSString *playerID;     /** playerID value for IQ Analytics */

@end
