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
  [self addCommonWithTitle:@"Error" embedCode:@"aaaa" pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"];
  [self addCommonWithTitle:@"HLS Video" embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1" pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"];
  [self addCommonWithTitle:@"MP4 Video" embedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx" pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"];
  [self addCommonWithTitle:@"VOD with CCs" embedCode:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww" pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"];
  [self addCommonWithTitle:@"4:3 Aspect Ratio" embedCode:@"FwaXZjcjrkydIftLal2cq9ymQMuvjvD8" pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"];
  [self addCommonWithTitle:@"VAST Ad Pre-roll" embedCode:@"Zlcmp0ZDrpHlAFWFsOBsgEXFepeSXY4c" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST Ad Mid-roll" embedCode:@"pncmp0ZDp7OKlwTPJlMZzrI59j8Imefa" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST Ad Post-roll" embedCode:@"Zpcmp0ZDpaB-90xK8MIV9QF973r1ZdUf" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST Ad Wrapper" embedCode:@"pqaWp0ZDqo17Z-Dn_5YiVhjcbQYs5lhq" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"Ooyala Ad Pre-roll" embedCode:@"M4cmp0ZDpYdy8kiL4UD910Rw_DWwaSnU" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"Ooyala Ad Mid-roll" embedCode:@"xhcmp0ZDpnDB2-hXvH7TsYVQKEk_89di" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"Ooyala Ad Post-roll" embedCode:@"Rjcmp0ZDr5yFbZPEfLZKUveR_2JzZjMO" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"Multi Ad combination" embedCode:@"Ftcmp0ZDoz8tALmhPcN2vMzCdg7YU9lc" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  // Skippable and Podded ads
  [self addCommonWithTitle:@"VAST 3.0 - Podded" embedCode:@"ZnaWtqMzE6HLDm_J8pqeKKenfoZt_wj6" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST 3.0 - Skippable Midroll" embedCode:@"BtY3IxNDE6VmZgCbgKBjhCcH4ypJPD8x" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST 3.0 - Skippable Preroll" embedCode:@"55MjA5MTE6iZTRzrTtLoxUy78YbffT2G" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST 3.0 - Ad Wrapper" embedCode:@"Fkcm9lMjE6GOcDOtPSiRnNCRhqsz-96e" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  // Icon ads
  [self addCommonWithTitle:@"VAST 3.0 - Icon General" embedCode:@"80dWtqMzE6_f8I1lphM6iLSZ7CPuhJiz" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST 3.0 - Icon Top Right" embedCode:@"RndWtqMzE6Ntq7eH648UHTe00oL4Tld6" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST 3.0 - Icon Bottom Left" embedCode:@"4zMzA5MTE63GOQrCXisPVr5deWsc9WiY" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  // Error Reporting
  [self addCommonWithTitle:@"VAST 3.0 Error Case - General Linear Error" embedCode:@"M5dmtqMzE6oH_PYHHUrvtPiYb2erJmAc" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST 3.0 Error Case - No Ads Error" embedCode:@"xsdmtqMzE64N4xS6f4s9A35gt4KRMOFk" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST 3.0 Error Case - Unsupported Version Error" embedCode:@"xld2tqMzE6YLRevbnbwJGEtKw33F1qEJ" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  // VMAP
  [self addCommonWithTitle:@"VAST 3.0 - VMAP PreMidPost using AdTagURI" embedCode:@"41MzA5MTE65SC6VQAS3H3d9rX-hwHQSK" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST 3.0 - VMAP PreMid using VASTAdData" embedCode:@"10eGE0MjE6TZG6mdHfJJEAGnxbuEv1Vi" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  // Ad Overlay
  [self addCommonWithTitle:@"VAST 3.0 - Overlay Ad" embedCode:@"10MzA5MTE6IsBf0ers2BiZu8l7AB0TOi" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
  [self addCommonWithTitle:@"VAST 3.0 - Overlay with PreMid" embedCode:@"9uajEwMzE6K3pBlfg3Z65LapnI9dLouv" pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"];
}
@end
