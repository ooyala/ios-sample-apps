//
//  OptionsDataSource.h
//  ChromecastSampleApp
//
//  Created on 4/2/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#ifndef OptionsDataSource_h
#define OptionsDataSource_h

@import Foundation;

@interface OptionsDataSource : NSObject
/**
 @return an Array of ChromecastPlayerSelectionOption instances to be used throughout the app.
 */
+ (NSArray *)options;

@end

#endif /* OptionsDataSource_h */
