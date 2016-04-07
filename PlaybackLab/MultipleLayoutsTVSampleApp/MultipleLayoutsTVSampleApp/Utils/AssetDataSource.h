//
//  AssetDataSource.h
//  MultipleLayoutsTVSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AssetDataSourceType) {
  AssetDataSourceTypeEncoding,
  AssetDataSourceTypeLayout
};


@interface AssetDataSource : NSObject

+ (NSArray *)assets:(AssetDataSourceType)type;

@end
