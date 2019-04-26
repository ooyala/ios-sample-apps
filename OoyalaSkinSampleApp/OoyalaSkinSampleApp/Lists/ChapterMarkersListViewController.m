//
//  ChapterMarkersListViewController.m
//  OoyalaSkinSampleApp
//
//  Created on 4/26/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import "ChapterMarkersListViewController.h"
#import "DefaultSkinPlayerViewController.h"

@implementation ChapterMarkersListViewController

- (void)addTestCases {
  self.options = [NSArray array];
  self.options = @[
                   [self optionWithTitle:@"Chapter markers in a content tree"
                               embedCode:@"dvYXZ1ZDE6fv9e0wJz1LpYWu3GeTBPZm"
                                   pcode:@"x2aDkyOt2q3WtOCp-krSyDffASzL"
                         markersFileName:nil],

                   [self optionWithTitle:@"Chapter markers with options (config)"
                               embedCode:@"gwbjJqdDobn3Ky6rNnwPzeA2tVVfQ8YJ"
                                   pcode:@"pyaDkyOqdnY0iQC2sTO4JeaXggl9"
                         markersFileName:@"markers1"],

                   [self optionWithTitle:@"Chapter markers with options (config) 2"
                               embedCode:@"JjMWd1ZDE6VW3ylyPcajnpdTV2Xm04Yb"
                                   pcode:@"x2aDkyOt2q3WtOCp-krSyDffASzL"
                         markersFileName:@"markers2"],

                   [self optionWithTitle:@"Chapter markers with options (inline)"
                               embedCode:@"R3YTZ4ZjE6i9a13MsDQAJwElh7zUQ9HO"
                                   pcode:@"BjcWYyOu1KK2DiKOkF41Z2k0X57l"
                         markersFileName:@"markers3"],

                   [self optionWithTitle:@"Chapter markers with options (inline) 2"
                               embedCode:@"pkMm1rdTqIAxx9DQ4-8Hyp9P_AHRe4pt"
                                   pcode:@"FoeG863GnBL4IhhlFC1Q2jqbkH9m"
                         markersFileName:@"markers3"],
                   ];
}

- (PlayerSelectionOption *)optionWithTitle:(NSString *)title
                                 embedCode:(NSString *)embedCode
                                     pcode:(NSString *)pcode
                           markersFileName:(NSString *)markersFileName {
  NSString *playerDomain = @"http://www.ooyala.com";
  NSString *nib = @"DefaultSkinPlayerView";
  return [[PlayerSelectionOption alloc] initWithTitle:title
                                            embedCode:embedCode
                                                pcode:pcode
                                         playerDomain:playerDomain
                                       viewController:DefaultSkinPlayerViewController.class
                                      markersFileName:markersFileName
                                                  nib:nib];
}

@end
