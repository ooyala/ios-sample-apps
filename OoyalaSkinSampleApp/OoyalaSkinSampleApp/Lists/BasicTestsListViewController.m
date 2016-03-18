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
  [self addCommonWithTitle:@"VAST 3.0 - Podded" embedCode:@"tjN2h1MDE65xMHMqNvvU0fYVBi6sFl1M"];
  [self addCommonWithTitle:@"VAST 3.0 - Skippable Midroll" embedCode:@"4xMzA5MTE6tCoMA9RY26vlJ9RsBPiJOK"];
  [self addCommonWithTitle:@"VAST 3.0 - Skippable Preroll" embedCode:@"55MjA5MTE6iZTRzrTtLoxUy78YbffT2G"];
  [self addCommonWithTitle:@"VAST 3.0 - Podded With Skippable" embedCode:@"NuMGp1MDE6EKUv7rAmkSQ3iuLU5N5Ik0"];
  // Icon ads
  [self addCommonWithTitle:@"VAST 3.0 - Icon General" embedCode:@"x3MWp1MDE6yIedkirT0to1t1uy2oA8y3"];
  [self addCommonWithTitle:@"VAST 3.0 - Icon Bottom Left" embedCode:@"1qNGp1MDE6GBl7PkPlWA_FA9NJDhBp_I"];
  [self addCommonWithTitle:@"VAST 3.0 - Icon Top Right" embedCode:@"1uNGp1MDE6DJElG8YeQJ8D7tuuJo9T-t"];
  // Error Reporting
  [self addCommonWithTitle:@"VAST 3.0 - General Linear Error" embedCode:@"1oNGp1MDE6V512gRnkTcz2o3RnFDSxNZ"];
  [self addCommonWithTitle:@"VAST 3.0 - No Ads Error" embedCode:@"1jbGY0MjE6aXLmYWOOeWn9hg9gMCCJh5"];
  [self addCommonWithTitle:@"VAST 3.0 - Unsupported Version Error" embedCode:@"o2bGY0MjE6ugqUtlLp22sESmh6V-2-Dc"];
}
@end
