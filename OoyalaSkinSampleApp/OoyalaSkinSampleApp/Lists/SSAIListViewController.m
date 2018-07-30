//
//  SSAIListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "SSAIListViewController.h"
#import "SSAIPlayerViewController.h"

@interface SSAIListViewController ()

@end

@implementation SSAIListViewController

- (void)addTestCases {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"SSAI / VOD / Ooyala Pulse"
                                                            embedCode:@"l5bm11ZjE6VFJyNE2iE6EKpCBVSRroAF"
                                                                pcode:@"ZsdGgyOnugo44o442aALkge_dVVK"
                                                         playerDomain:@"http://www.ooyala.com"
                                                        adSetProvider:@"ooyala_pulse"
                                                       viewController:[SSAIPlayerViewController class] nib: @"SSAIPlayerViewController"]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"SSAI / VOD / Google DFP"
                                                            embedCode:@"13bm11ZjE6Wl7CQ2iKPH_Z1VpspHGOud"
                                                                pcode:@"ZsdGgyOnugo44o442aALkge_dVVK"
                                                         playerDomain:@"http://www.ooyala.com"
                                                        adSetProvider:@"google_dfp"
                                                       viewController:[SSAIPlayerViewController class] nib: @"SSAIPlayerViewController"]];
  
}

@end
