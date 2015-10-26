//
//  IMATestsListViewController.m
//  OoyalaSkinSampleApp
//
//  Created by Zhihui Chen on 7/27/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "IMATestsListViewController.h"
#import "IMAPlayerViewController.h"

@interface IMATestsListViewController ()

@end

@implementation IMATestsListViewController

- (void)addTestCases {
  [self insertNewObject:[self optionWithTitle:@"Ad-Rules Preroll" embedCode:@"EzZ29lcTq49IswgZYkMknnU4Ukb9PQMH"]];
  [self insertNewObject:[self optionWithTitle:@"Ad-Rules Midroll" embedCode:@"VlaG9lcTqeUU18adfd1DVeQ8YekP3H4l"]];
  [self insertNewObject:[self optionWithTitle:@"Ad-Rules Postroll" embedCode:@"BnaG9lcTqLXQNyod7ON8Yv3eDas2Oog6"]];
  [self insertNewObject:[self optionWithTitle:@"Podded Preroll" embedCode:@"1wNjE3cDox0G3hQIWxTjsZ8MPUDLSkDY"]];
  [self insertNewObject:[self optionWithTitle:@"Podded Midroll" embedCode:@"1yNjE3cDodUEfUfp2WNzHkCZCMb47MUP"]];
  [self insertNewObject:[self optionWithTitle:@"Podded Postroll" embedCode:@"1sNjE3cDoN3ZewFm1238ce730J4BMrEJ"]];
  [self insertNewObject:[self optionWithTitle:@"Podded Pre-Mid-Post" embedCode:@"ZrOTE3cDoXo2sLOWzQPxjS__M-Qk32Co"]];
  [self insertNewObject:[self optionWithTitle:@"Skippable" embedCode:@"FhbGRjbzq8tfaoA3dhfxc2Qs0-RURJfO"]];
  [self insertNewObject:[self optionWithTitle:@"Pre, Mid and Post Skippable" embedCode:@"10NjE3cDpj8nUzYiV1PnFsjC6nEvPQAE"]];
}

- (PlayerSelectionOption *)optionWithTitle:(NSString *)title embedCode:(NSString *)embedCode {
  NSString *pcode = @"R2d3I6s06RyB712DN0_2GsQS-R-Y";
  NSString *playerDomain = @"http://www.ooyala.com";
  NSString *nib = @"DefaultSkinPlayerView";
  return [[PlayerSelectionOption alloc] initWithTitle:title embedCode:embedCode pcode:pcode playerDomain:playerDomain viewController:[IMAPlayerViewController class] nib:nib];
}

@end
