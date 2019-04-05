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

@property (nonatomic) OODiscoveryOptions *discoveryOptions;
@property (nonatomic) NSURL *jsCodeLocation;
@property (nonatomic) NSString *configFileName;
@property (nonatomic) NSDictionary *overrideConfigs;

- (instancetype)initWithDiscoveryOptions:(OODiscoveryOptions *)discoveryOptions
                          jsCodeLocation:(NSURL *)jsCodeLocation
                          configFileName:(NSString *)configFileName
                         overrideConfigs:(NSDictionary *)overrideConfigs;

@end
