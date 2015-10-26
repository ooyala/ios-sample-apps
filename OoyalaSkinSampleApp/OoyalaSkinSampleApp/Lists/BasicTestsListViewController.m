//
//  BasicListViewController.m
//  OoyalaSkinSampleApp
//
//  Created by Zhihui Chen on 7/27/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "BasicTestsListViewController.h"
#import "DefaultSkinPlayerViewController.h"

@interface BasicTestsListViewController ()

@end

@implementation BasicTestsListViewController

- (void)addTestCases {
  [self addCommonWithTitle:@"Error" embedCode:@"aaaa"];
  [self addCommonWithTitle:@"HLS Video" embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"];
  [self addCommonWithTitle:@"MP4 Video" embedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx"];
  [self addCommonWithTitle:@"VOD with CCs" embedCode:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"];
  [self addCommonWithTitle:@"CC to no-CC Channel" embedCode:@"ZwNThkdTrSfttI2N_-MH3MRIdJQ3Ox8I"];
  [self addCommonWithTitle:@"4:3 Aspect Ratio" embedCode:@"FwaXZjcjrkydIftLal2cq9ymQMuvjvD8"];
  [self addCommonWithTitle:@"VAST Ad Pre-roll" embedCode:@"Zlcmp0ZDrpHlAFWFsOBsgEXFepeSXY4c"];
  [self addCommonWithTitle:@"VAST Ad Mid-roll" embedCode:@"pncmp0ZDp7OKlwTPJlMZzrI59j8Imefa"];
  [self addCommonWithTitle:@"VAST Ad Post-roll" embedCode:@"Zpcmp0ZDpaB-90xK8MIV9QF973r1ZdUf"];
  [self addCommonWithTitle:@"VAST Ad Wrapper" embedCode:@"pqaWp0ZDqo17Z-Dn_5YiVhjcbQYs5lhq"];
  [self addCommonWithTitle:@"Ooyala Ad Pre-roll" embedCode:@"M4cmp0ZDpYdy8kiL4UD910Rw_DWwaSnU"];
  [self addCommonWithTitle:@"Ooyala Ad Mid-roll" embedCode:@"xhcmp0ZDpnDB2-hXvH7TsYVQKEk_89di"];
  [self addCommonWithTitle:@"Ooyala Ad Post-roll" embedCode:@"Rjcmp0ZDr5yFbZPEfLZKUveR_2JzZjMO"];
  [self addCommonWithTitle:@"Multi Ad combination" embedCode:@"Ftcmp0ZDoz8tALmhPcN2vMzCdg7YU9lc"];
  [self addCommonWithTitle:@"Vast multi-ads" embedCode:@"trNnFwdTogG_HxAgEV01zWLg3o8umVEJ"];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"BYU Live"
                                                            embedCode:@"Rva245YTpHWP-9bchhJL25BMl1shI2fG"
                                                                pcode:@"Vpd3E6BNabnn09G72IWye5O2RzN1"
                                                         playerDomain:@"http://www.byu.edu"
                                                       viewController:[DefaultSkinPlayerViewController class]
                                                                  nib: @"DefaultSkinPlayerView"]];

}
@end
