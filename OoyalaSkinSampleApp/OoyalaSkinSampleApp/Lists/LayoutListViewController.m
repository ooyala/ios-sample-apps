//
//  LayoutListViewController.m
//  OoyalaSkinSampleApp
//
//  Created by Zhihui Chen on 7/27/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "LayoutListViewController.h"
#import "DoublePlayerPlayerViewController.h"
#import "DefaultSkinPlayerViewController.h"

@interface LayoutListViewController ()

@end

@implementation LayoutListViewController

- (void)addTestCases {
  [self addCommonWithTitle:@"Original Alice Test Asset" embedCode:@"ZhMmkycjr4jlHIjvpIIimQSf_CjaQs48" pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Small Player View (BigBuck+Ads)"
                                                            embedCode:@"ZhMmkycjr4jlHIjvpIIimQSf_CjaQs48"
                                                                pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                         playerDomain:@"http://www.ooyala.com"
                                                       viewController:[DefaultSkinPlayerViewController class] nib: @"SmallSkinPlayerView"]];
  
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Double Player"
                                                            embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                         playerDomain:@"http://www.ooyala.com"
                                                       viewController:[DoublePlayerPlayerViewController class] nib: @"DoublePlayerView"]];

  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Small Player View (HLS)"
                                                            embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                         playerDomain:@"http://www.ooyala.com"
                                                       viewController:[DefaultSkinPlayerViewController class] nib: @"SmallSkinPlayerView"]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Tall Player View"
                                                            embedCode:@"ZhMmkycjr4jlHIjvpIIimQSf_CjaQs48"
                                                                pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                         playerDomain:@"http://www.ooyala.com"
                                                       viewController:[DefaultSkinPlayerViewController class] nib: @"TallPlayerView"]];

  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Wide Player View"
                                                            embedCode:@"ZhMmkycjr4jlHIjvpIIimQSf_CjaQs48"
                                                                pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                         playerDomain:@"http://www.ooyala.com"
                                                       viewController:[DefaultSkinPlayerViewController class] nib: @"WidePlayerView"]];


}

@end
