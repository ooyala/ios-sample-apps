//
//  PlaybackSpeedListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "PlaybackSpeedListViewController.h"
#import "IMAPlayerViewController.h"
#import "DRMPlayerViewController.h"
#import "DRMPlayerSelectionOptions.h"
#import "SSAIPlayerViewController.h"


@implementation PlaybackSpeedListViewController

- (void)addTestCases {
  
  [self addCommonWithTitle:@"HLS Video" embedCode:@"c0YzVwZTE6mYDzgMMYwoB_bWgD7XB3P-" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];
  [self addCommonWithTitle:@"[LIVE] ELEMENTAL_CC_HLS" embedCode:@"g1anZxZDE6hyE_zQEqtMAGINv7-oSHH8" pcode:@"ViM2wyOicnaFHWsz2iQQj25bnQ32"];

  [self insertNewObject:[self DRMOptionWithTitle:@"Azure DRM HLS"
                                       embedCode:@"FtY3hyZTE6_YTA3Q8SohK9KYIeSAEVl3"
                                           pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"
                                          apiKey:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b.uQXw9"
                                       secretKey:@"ajDRV5fJgCMtLSRaSGDyEdjhWfZqIfi0JFlPkbpZ"
                                       accountId:@"107279"]];
  
  [self insertNewObject:[self IMAOptionWithTitle:@"IMA Mid-roll" embedCode:@"FrZGVyZTE6Bv2s5QwtytNT48VJfq9vdh" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"]];
  
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"SSAI / VOD / Ooyala Pulse"
                                                            embedCode:@"l5bm11ZjE6VFJyNE2iE6EKpCBVSRroAF"
                                                                pcode:@"ZsdGgyOnugo44o442aALkge_dVVK"
                                                         playerDomain:@"http://www.ooyala.com"
                                                        adSetProvider:@"ooyala_pulse"
                                                       viewController:[SSAIPlayerViewController class] nib: @"SSAIPlayerViewController"]];
}

- (PlayerSelectionOption *)IMAOptionWithTitle:(NSString *)title embedCode:(NSString *)embedCode pcode:(NSString *)pcode {
  NSString *playerDomain = @"http://www.ooyala.com";
  NSString *nib = @"DefaultSkinPlayerView";
  
  return [[PlayerSelectionOption alloc] initWithTitle:title
                                            embedCode:embedCode
                                                pcode:pcode
                                         playerDomain:playerDomain
                                       viewController:[IMAPlayerViewController class]
                                                  nib:nib];
}

- (PlayerSelectionOption *)DRMOptionWithTitle:(NSString *)title
                                    embedCode:(NSString *)embedCode
                                        pcode:(NSString *)pcode
                                       apiKey:(NSString *)apiKey
                                    secretKey:(NSString *)secretKey
                                    accountId:(NSString *)accountId {
  
  NSString *playerDomain = @"http://www.ooyala.com";
  NSString *nib = @"DefaultSkinPlayerView";
  
  return [[DRMPlayerSelectionOptions alloc] initWithTitle:title
                                                embedCode:embedCode
                                                    pcode:pcode
                                             playerDomain:playerDomain
                                           viewController:[DRMPlayerViewController class]
                                                      nib:nib
                                                   apiKey:apiKey
                                                secretKey:secretKey
                                                accountId:accountId];
}


@end
