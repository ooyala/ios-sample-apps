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
                                   pcode:@"x2aDkyOt2q3WtOCp-krSyDffASzL"],

                   [self optionWithTitle:@"Chapter markers with options (config)"
                               embedCode:@"gwbjJqdDobn3Ky6rNnwPzeA2tVVfQ8YJ"
                                   pcode:@"pyaDkyOqdnY0iQC2sTO4JeaXggl9"],

                   [self optionWithTitle:@"Chapter markers with options (config) 2"
                               embedCode:@"JjMWd1ZDE6VW3ylyPcajnpdTV2Xm04Yb"
                                   pcode:@"x2aDkyOt2q3WtOCp-krSyDffASzL"],

                   [self optionWithTitle:@"Chapter markers with options (inline)"
                               embedCode:@"R3YTZ4ZjE6i9a13MsDQAJwElh7zUQ9HO"
                                   pcode:@"BjcWYyOu1KK2DiKOkF41Z2k0X57l"],

                   [self optionWithTitle:@"Chapter markers with options (inline) 2"
                               embedCode:@"xiYmRsZTE6CsDnH0HJ3RDF_LND9RLe3L"
                                   pcode:@"BjcWYyOu1KK2DiKOkF41Z2k0X57l"],
                   ];
}

- (PlayerSelectionOption *)optionWithTitle:(NSString *)title
                                 embedCode:(NSString *)embedCode
                                     pcode:(NSString *)pcode {
  NSString *playerDomain = @"http://www.ooyala.com";
  NSString *nib = @"DefaultSkinPlayerView";
  return [[PlayerSelectionOption alloc] initWithTitle:title
                                            embedCode:embedCode
                                                pcode:pcode
                                         playerDomain:playerDomain
                                       viewController:DefaultSkinPlayerViewController.class
                                                  nib:nib];
}

@end
