//
//  OOSkinOptions.h
//  OoyalaSkinSDK
//
//  Created on 8/12/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

@import Foundation;

@class OODiscoveryOptions;

@interface OOSkinOptions : NSObject

@property (nonatomic, nullable) OODiscoveryOptions *discoveryOptions;
@property (nonatomic, nonnull) NSURL *jsCodeLocation;
@property (nonatomic, nonnull) NSString *configFileName;
@property (nonatomic, nullable) NSDictionary *overrideConfigs;

- (nonnull instancetype)initWithDiscoveryOptions:(nullable OODiscoveryOptions *)discoveryOptions
                                  jsCodeLocation:(nonnull NSURL *)jsCodeLocation
                                  configFileName:(nonnull NSString *)configFileName
                                 overrideConfigs:(nullable NSDictionary *)overrideConfigs;

@end
