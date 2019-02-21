//
//  GeoblockingTableViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "GeoblockingTableViewController.h"
#import "DefaultSkinPlayerViewController.h"
#import "GeoblockingPlayerSelectionOptions.h"
#import "GeoblockingSkinViewController.h"

@interface GeoblockingTableViewController ()

@end

@implementation GeoblockingTableViewController

- (void)addTestCases {
  self.options = [NSArray array];
  self.options = @[
                   [self optionWithTitle:@"Not live (staging). Geoblocking false"
                               embedCode:@"tlbzk1ZTE6oxBGducc5GsdUf0B316n5E"],

                   [self optionWithTitle:@"Not live (staging). Geoblocking true"
                               embedCode:@"1xbjk1ZTE6I_7_bB93RURHX9VZHrPSJI"],

                   [self optionWithTitle:@"Live (staging). Geoblocking true"
                               embedCode:@"Uybzk1ZTE6VkcCpiKUyF4omKz2kljW-q"],

                   [self optionWithTitle:@"Live (staging). Geoblocking false"
                               embedCode:@"licTk1ZTE68zveSS51vipPWwwafEVEG8"]
                   ];
}

- (GeoblockingPlayerSelectionOptions *)optionWithTitle:(NSString *)title embedCode:(NSString *)embedCode {
  NSString *pcode = @"BzY2syOq6kIK6PTXN7mmrGVSJEFj-H";
  NSString *playerDomain = @"http://www.ooyala.com";
  NSString *nib = @"DefaultSkinPlayerView";
  NSString *apiKey = @"BzY2syOq6kIK6PTXN7mmrGVSJEFj.APkQ3";
  NSString *secretKey = @"nYDE1TkyZOhyQ2HZBRjCZ1E0tCNFvgk8b2UmvHd1";
  NSString *accountId = @"110698";
  return [[GeoblockingPlayerSelectionOptions alloc] initWithTitle:title
                                                        embedCode:embedCode
                                                            pcode:pcode
                                                     playerDomain:playerDomain
                                                   viewController:GeoblockingSkinViewController.class
                                                              nib:nib
                                                           apiKey:apiKey
                                                        secretKey:secretKey
                                                        accountId:accountId];
}

@end
