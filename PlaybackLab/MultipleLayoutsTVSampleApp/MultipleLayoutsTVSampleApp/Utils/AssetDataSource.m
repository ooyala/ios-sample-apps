//
//  AssetDataSource.m
//  MultipleLayoutsTVSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "AssetDataSource.h"
#import "PlayerSelectionOption.h"
#import "FullscreenPlayerViewController.h"
#import "ChildPlayerViewController.h"

@implementation AssetDataSource

+ (NSArray *)assets:(AssetDataSourceType)type {
  switch (type) {
    case AssetDataSourceTypeEncoding:
      return [self assetsForEncoding];
      break;
    case AssetDataSourceTypeLayout:
      return [self assetsForLayout];
      break;
    default:
      break;
  }
  return nil;
}

+ (NSArray *)assetsForEncoding {
  return @[
           [[PlayerSelectionOption alloc] initWithTitle:@"HLS"
                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"],
           [[PlayerSelectionOption alloc] initWithTitle:@"eHLS"
                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"],
           [[PlayerSelectionOption alloc] initWithTitle:@"MP4"
                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"],
           ];
}

+ (NSArray *)assetsForLayout {
  return @[
           [[PlayerSelectionOption alloc] initWithTitle:@"Fullscreen Player"
                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                         viewController:[FullscreenPlayerViewController class]],
           [[PlayerSelectionOption alloc] initWithTitle:@"Inline Player"
                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                         viewController:[ChildPlayerViewController class]],
           ];
}

@end
