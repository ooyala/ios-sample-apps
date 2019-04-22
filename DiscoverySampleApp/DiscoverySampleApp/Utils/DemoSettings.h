//
//  DemoSettings.h
//  OoyalaSkinSampleApp
//
//  Created on 4/25/17.
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

@import Foundation;

@interface DemoSettings : NSObject

@property (nonatomic, readonly) NSDictionary *playerParameters;
@property (nonatomic, readonly) NSDictionary *initasset;
@property (nonatomic, readonly) NSArray *carousels;

- (instancetype)init;

- (NSArray *)labels;

@end
