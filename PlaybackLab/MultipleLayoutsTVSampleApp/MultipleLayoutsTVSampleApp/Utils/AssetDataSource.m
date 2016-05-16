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
                                              embedCode:@"ZtZmtmbjpLGohvF5zBLvDyWexJ70KsL-"],
           [[PlayerSelectionOption alloc] initWithTitle:@"MP4"
                                              embedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx"],
           [[PlayerSelectionOption alloc] initWithTitle:@"OPT unauthorized"
                                              embedCode:@"0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52"
                                     needsAuthorization:NO],
           [[PlayerSelectionOption alloc] initWithTitle:@"OPT authorized"
                                              embedCode:@"0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52"
                                     needsAuthorization:YES],
           ];
}

+ (NSArray *)assetsForLayout {
  return @[
           [[PlayerSelectionOption alloc] initWithTitle:@"Fullscreen Player"
                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                     needsAuthorization:NO
                                         viewController:[FullscreenPlayerViewController class]],
           [[PlayerSelectionOption alloc] initWithTitle:@"Inline Player"
                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                     needsAuthorization:NO
                                         viewController:[ChildPlayerViewController class]],
           ];
}

@end
