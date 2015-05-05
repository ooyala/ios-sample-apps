//
//  OOAdSpot.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOAdSpot : NSObject

@property NSNumber *time;

- (id)initWithTime:(NSNumber *)t;

/**
 * compare two ad spots based on their time *
 * @param[in] the other object to compare
 * @returns compare results
 */
- (NSComparisonResult)compare:(OOAdSpot *)other;

@end
