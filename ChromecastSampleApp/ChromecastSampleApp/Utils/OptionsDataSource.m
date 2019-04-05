//
//  OptionsDataSource.m
//  ChromecastSampleApp
//
//  Created on 4/2/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import "OptionsDataSource.h"
#import "ChromecastPlayerSelectionOption.h"
#import "PlayerViewController.h"

@implementation OptionsDataSource

+ (NSArray *)options {
  return @[
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"HLS Asset"
                                                        embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"VOD with CC Asset"
                                                        embedCode:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"MP4 Video"
                                                        embedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"DASH Live Channel"
                                                        embedCode:@"92Zm51ZjE6WiUvDqQ7JcqJ_yJK9e0cX4"
                                                            pcode:@"t5MGs6osydJR0KO0RRrDqi_PXSRM"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Encrypted HLS Asset"
                                                        embedCode:@"ZtZmtmbjpLGohvF5zBLvDyWexJ70KsL-"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Playready Smooth with Clear HLS Backup"
                                                        embedCode:@"pkMm1rdTqIAxx9DQ4-8Hyp9P_AHRe4pt"
                                                            pcode:@"FoeG863GnBL4IhhlFC1Q2jqbkH9m"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"2 Assets autoplayed"
                                                        embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                       embedCode2:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           //This asset will not be configured correctly. To test your OPT-enabled assets, you need:
           // 1. an OPT-enabled embed code (set here)
           // 2. the correlating PCode (set here)
           // 3. an API Key and Secret for the provider to locally-sign the authorization (set in the PlayerViewController)
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Ooyala Player Token Asset (unconfigured)"
                                                        embedCode:@"0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class]
           ];
}

@end
