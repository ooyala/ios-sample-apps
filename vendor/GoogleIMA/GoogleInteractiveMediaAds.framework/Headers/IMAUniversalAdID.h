//
//  IMAUniversalAdID.h
//  GoogleIMA3
//
//  Copyright (c) 2019 Google Inc. All rights reserved.
//
//  Represents the universal ad ID information for a single ad.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Simple data object containing universal ad ID information.
 */
@interface IMAUniversalAdID : NSObject

/**
 *  The universal ad ID value. This will be "unknown" if it isn't defined by the ad.
 */
@property(nonatomic, copy, readonly) NSString *adIDValue;

/**
 *  The universal ad ID registry with which the value is registerd. This will be "unknown"
 *  if it isn't defined by the ad.
 */
@property(nonatomic, copy, readonly) NSString *adIDRegistry;

/**
 * :nodoc:
 */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
