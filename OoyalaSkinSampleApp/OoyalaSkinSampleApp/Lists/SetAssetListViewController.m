//
//  SetAssetListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright (c) 2018 Ooyala, Inc. All rights reserved.
//

#import "SetAssetListViewController.h"
#import "SetAssetPlayerViewController.h"

@interface SetAssetListViewController ()

@end

@implementation SetAssetListViewController

#pragma mark - Override functions

- (void)addTestCases {
  self.options = [NSArray array];
  self.options = @[
                   [self optionWithTitle:@"Set asset"
                               embedCode:@"VlaG9lcTqeUU18adfd1DVeQ8YekP3H4l"]
                   ];
}

- (PlayerSelectionOption *)optionWithTitle:(NSString *)title
                                 embedCode:(NSString *)embedCode {
  NSString *pcode = @"R2NDYyOhSRhYj0UrUVgcdWlFVP-H";
  NSString *playerDomain = @"http://www.ooyala.com";
  NSString *nib = @"SetAssetSkinPlayerView";
  return [[PlayerSelectionOption alloc] initWithTitle:title
                                            embedCode:embedCode
                                                pcode:pcode
                                         playerDomain:playerDomain
                                       viewController:SetAssetPlayerViewController.class
                                                  nib:nib];
}

@end
