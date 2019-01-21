//
//  IMATestsListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "IMATestsListViewController.h"
#import "IMAPlayerViewController.h"

@interface IMATestsListViewController ()

@end

@implementation IMATestsListViewController

- (void)addTestCases {
  self.options = [NSArray array];
  self.options = @[
                   [self optionWithTitle:@"Ad-Rules Midroll"
                               embedCode:@"VlaG9lcTqeUU18adfd1DVeQ8YekP3H4l"],
                   [self optionWithTitle:@"Ad-Rules Postroll"
                               embedCode:@"BnaG9lcTqLXQNyod7ON8Yv3eDas2Oog6"],
                   [self optionWithTitle:@"Podded Preroll"
                               embedCode:@"1wNjE3cDox0G3hQIWxTjsZ8MPUDLSkDY"],
                   [self optionWithTitle:@"Podded Midroll"
                               embedCode:@"1yNjE3cDodUEfUfp2WNzHkCZCMb47MUP"],
                   [self optionWithTitle:@"Podded Postroll"
                               embedCode:@"1sNjE3cDoN3ZewFm1238ce730J4BMrEJ"],
                   [self optionWithTitle:@"Podded Pre-Mid-Post"
                               embedCode:@"ZrOTE3cDoXo2sLOWzQPxjS__M-Qk32Co"],
                   [self optionWithTitle:@"Skippable"
                               embedCode:@"FhbGRjbzq8tfaoA3dhfxc2Qs0-RURJfO"],
                   [self optionWithTitle:@"Pre, Mid and Post Skippable"
                               embedCode:@"10NjE3cDpj8nUzYiV1PnFsjC6nEvPQAE"]
                   // TODO: Replace with a new ad rules preroll asset, this embed code is broken
//                   [self optionWithTitle:@"Ad-Rules Preroll"
//                               embedCode:@"EzZ29lcTq49IswgZYkMknnU4Ukb9PQMH"]
                ];
}

- (PlayerSelectionOption *)optionWithTitle:(NSString *)title
                                 embedCode:(NSString *)embedCode {
  NSString *pcode = @"R2NDYyOhSRhYj0UrUVgcdWlFVP-H";
  NSString *playerDomain = @"http://www.ooyala.com";
  NSString *nib = @"DefaultSkinPlayerView";
  return [[PlayerSelectionOption alloc] initWithTitle:title
                                            embedCode:embedCode
                                                pcode:pcode
                                         playerDomain:playerDomain
                                       viewController:IMAPlayerViewController.class
                                                  nib:nib];
}

@end
