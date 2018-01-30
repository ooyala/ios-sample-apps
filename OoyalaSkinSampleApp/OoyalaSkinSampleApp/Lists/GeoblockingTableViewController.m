//
//  GeoblockingTableViewController.m
//  OoyalaSkinSampleApp
//
//  Created by Ivan Sakharovskii on 1/30/18.
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
  [self insertNewObject:[[GeoblockingPlayerSelectionOptions alloc] initWithTitle:@"Not live (staging). Geoblocking false"
                                                                       embedCode:@"tlbzk1ZTE6oxBGducc5GsdUf0B316n5E"
                                                                           pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"
                                                                    playerDomain:@"http://www.ooyala.com"
                                                                  viewController:[GeoblockingSkinViewController class]
                                                                             nib:@"DefaultSkinPlayerView"
                                                                          apiKey:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj.APkQ3"
                                                                       secretKey:@"nYDE1TkyZOhyQ2HZBRjCZ1E0tCNFvgk8b2UmvHd1"
                                                                       accountId:@"110698"]];
  
  [self insertNewObject:[[GeoblockingPlayerSelectionOptions alloc] initWithTitle:@"Not live (staging). Geoblocking true"
                                                                       embedCode:@"1xbjk1ZTE6I_7_bB93RURHX9VZHrPSJI"
                                                                           pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"
                                                                    playerDomain:@"http://www.ooyala.com"
                                                                  viewController:[GeoblockingSkinViewController class]
                                                                             nib:@"DefaultSkinPlayerView"
                                                                          apiKey:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj.APkQ3"
                                                                       secretKey:@"nYDE1TkyZOhyQ2HZBRjCZ1E0tCNFvgk8b2UmvHd1"
                                                                       accountId:@"110698"]];
  
  [self insertNewObject:[[GeoblockingPlayerSelectionOptions alloc] initWithTitle:@"Live (staging). Geoblocking true"
                                                                       embedCode:@"Uybzk1ZTE6VkcCpiKUyF4omKz2kljW-q"
                                                                           pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"
                                                                    playerDomain:@"http://www.ooyala.com"
                                                                  viewController:[GeoblockingSkinViewController class]
                                                                             nib:@"DefaultSkinPlayerView"
                                                                          apiKey:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj.APkQ3"
                                                                       secretKey:@"nYDE1TkyZOhyQ2HZBRjCZ1E0tCNFvgk8b2UmvHd1"
                                                                       accountId:@"110698"]];
  
  [self insertNewObject:[[GeoblockingPlayerSelectionOptions alloc] initWithTitle:@"Live (staging). Geoblocking false"
                                                                       embedCode:@"licTk1ZTE68zveSS51vipPWwwafEVEG8"
                                                                           pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"
                                                                    playerDomain:@"http://www.ooyala.com"
                                                                  viewController:[GeoblockingSkinViewController class]
                                                                             nib:@"DefaultSkinPlayerView"
                                                                          apiKey:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj.APkQ3"
                                                                       secretKey:@"nYDE1TkyZOhyQ2HZBRjCZ1E0tCNFvgk8b2UmvHd1"
                                                                       accountId:@"110698"]];
             
}


@end
