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
  // Skippable and Podded ads
  [self addCommonWithTitle:@"VAST 3.0 - Podded" embedCode:@"ZnaWtqMzE6HLDm_J8pqeKKenfoZt_wj6"];
  [self addCommonWithTitle:@"VAST 3.0 - Skippable Midroll" embedCode:@"4xMzA5MTE6tCoMA9RY26vlJ9RsBPiJOK"];
  [self addCommonWithTitle:@"VAST 3.0 - Skippable Preroll" embedCode:@"55MjA5MTE6iZTRzrTtLoxUy78YbffT2G"];
  [self addCommonWithTitle:@"VAST 3.0 - Ad Wrapper" embedCode:@"Fkcm9lMjE6GOcDOtPSiRnNCRhqsz-96e"];
  // Icon ads
  [self addCommonWithTitle:@"VAST 3.0 - Icon General" embedCode:@"80dWtqMzE6_f8I1lphM6iLSZ7CPuhJiz"];
  [self addCommonWithTitle:@"VAST 3.0 - Icon Top Right" embedCode:@"RndWtqMzE6Ntq7eH648UHTe00oL4Tld6"];
  [self addCommonWithTitle:@"VAST 3.0 - Icon Bottom Left" embedCode:@"4zMzA5MTE63GOQrCXisPVr5deWsc9WiY"];
  // Error Reporting
  [self addCommonWithTitle:@"VAST 3.0 Error Case - General Linear Error" embedCode:@"M5dmtqMzE6oH_PYHHUrvtPiYb2erJmAc"];
  [self addCommonWithTitle:@"VAST 3.0 Error Case - No Ads Error" embedCode:@"xsdmtqMzE64N4xS6f4s9A35gt4KRMOFk"];
  [self addCommonWithTitle:@"VAST 3.0 Error Case - Unsupported Version Error" embedCode:@"xld2tqMzE6YLRevbnbwJGEtKw33F1qEJ"];
  // VMAP
  [self addCommonWithTitle:@"VAST 3.0 - VMAP PreMidPost using AdTagURI" embedCode:@"41MzA5MTE65SC6VQAS3H3d9rX-hwHQSK"];
  [self addCommonWithTitle:@"VAST 3.0 - VMAP PreMid using VASTAdData" embedCode:@"10eGE0MjE6TZG6mdHfJJEAGnxbuEv1Vi"];
  // Ad Overlay
  [self addCommonWithTitle:@"VAST 3.0 - Overlay Ad" embedCode:@"10MzA5MTE6IsBf0ers2BiZu8l7AB0TOi"];
  [self addCommonWithTitle:@"VAST 3.0 - Overlay with PreMid Podded" embedCode:@"9uajEwMzE6K3pBlfg3Z65LapnI9dLouv"];
}
@end
