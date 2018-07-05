//
//  MultiAudioListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "MultiAudioListViewController.h"
#import "IMAPlayerViewController.h"
#import "DRMPlayerViewController.h"
#import "DRMPlayerSelectionOptions.h"


@interface MultiAudioListViewController ()

@end


@implementation MultiAudioListViewController

- (void)addTestCases {
  
  [self addCommonWithTitle:@"1 track + No CC" embedCode:@"c0YzVwZTE6mYDzgMMYwoB_bWgD7XB3P-" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];
  [self addCommonWithTitle:@"Several tracks + No CC" embedCode:@"c3cGZwZTE6lh5w1Jm6hK0LAEpP_EKn-6" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];
  [self addCommonWithTitle:@"1 track + CC" embedCode:@"92cmZwZTE613kYlorJkkSJXAw4DnFRxv" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];
  [self addCommonWithTitle:@"Several tracks + CC" embedCode:@"E4bDRwZTE6rMB8oYrzOsuHSPz0XM0dAV" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];
  [self addCommonWithTitle:@"Change Track" embedCode:@"c3cGZwZTE6lh5w1Jm6hK0LAEpP_EKn-6" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];
  [self addCommonWithTitle:@"Change CC" embedCode:@"E4bDRwZTE6rMB8oYrzOsuHSPz0XM0dAV" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];
  [self addCommonWithTitle:@"DASH" embedCode:@"tyOTBvZTE6Gq2ib-GtRchnRCQmk3jLRT" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];
  [self addCommonWithTitle:@"HLS" embedCode:@"tsYjVwZTE6zgfSBx4_gvsVuFuwy844q_" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];
  [self addCommonWithTitle:@"7+ tracks + CC" embedCode:@"p5amdwZTE6NgCrrm18YoUTrgJsI7D26f" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];
  [self insertNewObject:[self IMAOptionWithTitle:@"Mid-roll" embedCode:@"FrZGVyZTE6Bv2s5QwtytNT48VJfq9vdh" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"]];
  [self insertNewObject:[self IMAOptionWithTitle:@"Post-roll" embedCode:@"ppZGVyZTE6dX1q1yTHtygM4lyiRwDFDM" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"]];

  [self addCommonWithTitle:@"MP4 without CC" embedCode:@"g0Z2hwZTE6i-ODpQETJqhOCt2jOE6Y2c" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];
  [self addCommonWithTitle:@"MP4 with CC" embedCode:@"xkaGhwZTE6hghIcejjoTfu0BG2sLdtxp" pcode:@"BzY2syOq6kIK6PTXN7mmrGVSJEFj"];

  [self addCommonWithTitle:@"Azure Clear HLS Var1" embedCode:@"F0YnhyZTE64tQDm5QMdcpjp_hMI8Xqya" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Azure eHLS Var1" embedCode:@"8wMnhyZTE6i6Y54Sz9X7T2f3oT5LU7sq" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self insertNewObject:[self DRMOptionWithTitle:@"Azure DRM HLS Var1"
                                       embedCode:@"FtY3hyZTE6_YTA3Q8SohK9KYIeSAEVl3"
                                           pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"
                                          apiKey:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b.uQXw9"
                                       secretKey:@"ajDRV5fJgCMtLSRaSGDyEdjhWfZqIfi0JFlPkbpZ"
                                       accountId:@"107279"]];
  
  [self addCommonWithTitle:@"Azure Clear HLS Var1-copy" embedCode:@"M1YnhyZTE6X6-QO5AmLg1f623BYEDioW" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Azure eHLS Var1-copy" embedCode:@"gzM3hyZTE6FYgJOHmTfEu0gJTGTNEzjw" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self insertNewObject:[self DRMOptionWithTitle:@"Azure DRM HLS Var1-copy"
                                       embedCode:@"k5ZHhyZTE60bYC8uPfP75GoENXPWa-f_"
                                           pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"
                                          apiKey:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b.uQXw9"
                                       secretKey:@"ajDRV5fJgCMtLSRaSGDyEdjhWfZqIfi0JFlPkbpZ"
                                       accountId:@"107279"]];
  
  [self addCommonWithTitle:@"Azure Clear HLS Var2" embedCode:@"43bnhyZTE64pp4S7s2Ip59h9-u0Tf38R" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Azure eHLS Var2" embedCode:@"1jb3hyZTE6WpUyiXBv-51xhsM_vsoVNi" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self insertNewObject:[self DRMOptionWithTitle:@"Azure DRM HLS Var2"
                                       embedCode:@"dzbXhyZTE6tHVS5qvVQz0ftWGYta-x4F"
                                           pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"
                                          apiKey:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b.uQXw9"
                                       secretKey:@"ajDRV5fJgCMtLSRaSGDyEdjhWfZqIfi0JFlPkbpZ"
                                       accountId:@"107279"]];
  
  [self addCommonWithTitle:@"Azure Clear HLS Var2-copy" embedCode:@"NubnhyZTE6pyMfC0JDjxd5c4Ge5Tpb7t" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Azure eHLS Var2-copy" embedCode:@"4yb3hyZTE6x8VOh3aPPDHk8lJskxaS07" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self insertNewObject:[self DRMOptionWithTitle:@"Azure DRM HLS Var2-copy"
                                       embedCode:@"ljbXhyZTE6gNwjO0MEWyVm6a9k6JoDuK"
                                           pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"
                                          apiKey:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b.uQXw9"
                                       secretKey:@"ajDRV5fJgCMtLSRaSGDyEdjhWfZqIfi0JFlPkbpZ"
                                       accountId:@"107279"]];

  [self addCommonWithTitle:@"Azure Clear HLS Var5" embedCode:@"p1eXhyZTE6qeKu5YljlqjIvtnlvkWig4" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Azure eHLS Var5" embedCode:@"xyeHhyZTE6L_DdyHGh06RQNHxwvpLg37" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self insertNewObject:[self DRMOptionWithTitle:@"Azure DRM HLS Var5"
                                       embedCode:@"Z0MHlyZTE6vRDsTlYedKM3DNYga6EaX8"
                                           pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"
                                          apiKey:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b.uQXw9"
                                       secretKey:@"ajDRV5fJgCMtLSRaSGDyEdjhWfZqIfi0JFlPkbpZ"
                                       accountId:@"107279"]];

  [self addCommonWithTitle:@"Elemental HLS MT-Variant-1" embedCode:@"9oc3ZzZTE6rkpKJVCyGg_vFSWTQ5LOUB" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Elemental eHLS MT-Variant-1" embedCode:@"E4dHZzZTE6-5aCf147EC-uqRTkucqKWB" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  
  [self addCommonWithTitle:@"Elemental HLS MT-Variant-2" embedCode:@"8wdnZzZTE68i13f1fEuC_FnRaMGw0hS1" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Elemental eHLS MT-Variant-2" embedCode:@"84dnZzZTE6BRpY86hFPpUKWjN6BqVPJr" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  
  [self addCommonWithTitle:@"Elemental HLS MT-Variant-2copy" embedCode:@"11Y3lzZTE6lyIUF6bbYSBPEHWkjTFpow" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Elemental eHLS MT-Variant-2copy" embedCode:@"h2ZHlzZTE6-YQJIitmIV5RwlJBWHOwKa" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  
  [self addCommonWithTitle:@"Elemental HLS MT-Variant-6" embedCode:@"kzd3ZzZTE6OtnaIbZKlPL5agHYNKS2cq" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Elemental eHLS MT-Variant-6" embedCode:@"tpdnZzZTE6qe66Fn558NrjrGBfiNbY3r" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  
  [self addCommonWithTitle:@"Elemental HLS MT-Variant-6copy" embedCode:@"RyMDB0ZTE63oqMajyUgE1P0QKR6mln2E" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Elemental eHLS MT-Variant-6copy" embedCode:@"4zNDB0ZTE63Dup-47FIZKwBJUn7DRSST" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  
  [self addCommonWithTitle:@"Elemental HLS MT-Variant-5" embedCode:@"xmMXdzZTE6Bydd2tPBEOg-q5yvQgjebE" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Elemental eHLS MT-Variant-5" embedCode:@"ViNXdzZTE6CxtLfMiTQH4Me8jz-p2cbS" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
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
