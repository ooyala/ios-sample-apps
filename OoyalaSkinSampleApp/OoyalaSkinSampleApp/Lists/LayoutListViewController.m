//
//  LayoutListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "LayoutListViewController.h"
#import "DefaultSkinPlayerViewController.h"

@interface LayoutListViewController ()

@end

@implementation LayoutListViewController

- (void)addTestCases {
  self.options = [NSArray array];
  self.options = @[
                   [self optionWithTitle:@"Original Alice Test Asset"
                               embedCode:@"ZhMmkycjr4jlHIjvpIIimQSf_CjaQs48"
                                     nib:@"DefaultSkinPlayerView"],

                   [self optionWithTitle:@"Small Player View (BigBuck+Ads)"
                               embedCode:@"ZhMmkycjr4jlHIjvpIIimQSf_CjaQs48"
                                     nib:@"SmallSkinPlayerView"],

                   [self optionWithTitle:@"Small Player View (HLS)"
                               embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                     nib:@"SmallSkinPlayerView"],

                   [self optionWithTitle:@"Tall Player View"
                               embedCode:@"ZhMmkycjr4jlHIjvpIIimQSf_CjaQs48"
                                     nib:@"TallPlayerView"],

                   [self optionWithTitle:@"Wide Player View"
                               embedCode:@"ZhMmkycjr4jlHIjvpIIimQSf_CjaQs48"
                                     nib:@"WidePlayerView"]
                   ];
}

- (PlayerSelectionOption *)optionWithTitle:(NSString *)title
                                 embedCode:(NSString *)embedCode
                                       nib:(NSString *)nib {
  NSString *pcode = @"c0cTkxOqALQviQIGAHWY5hP0q9gU-H";
  NSString *playerDomain = @"http://www.ooyala.com";
  return [[PlayerSelectionOption alloc] initWithTitle:title
                                            embedCode:embedCode
                                                pcode:pcode
                                         playerDomain:playerDomain
                                       viewController:DefaultSkinPlayerViewController.class
                                                  nib:nib];
}

@end
