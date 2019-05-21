//
//  OptionsDataSource.h
//  DownloadToOwnSampleApp
//
//  Created on 8/23/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

@import Foundation;

@class OODtoAsset;

/**
 Manages the assets to be downloaded.
 */
@interface OptionsDataSource : NSObject
/**
 @return an Array of PlayerSelectionOption instances to be used throughout the app. 
 */
+ (NSArray *)options;

+ (NSMutableArray<OODtoAsset *> *)dtoAssets;

@end
