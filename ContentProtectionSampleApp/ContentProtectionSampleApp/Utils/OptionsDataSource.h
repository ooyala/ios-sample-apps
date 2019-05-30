//
//  OptionsDataSource.h
//  ContentProtectionSampleApp
//
//  Created on 05/24/19.
//  Copyright © 2019 Ooyala. All rights reserved.
//

@import Foundation;

@class PlayerSelectionOption;

@interface OptionsDataSource : NSObject
/**
 @return an Array of PlayerSelectionOption instances to be used throughout the app. 
 */
+ (NSArray<PlayerSelectionOption *> *)options;

@end
