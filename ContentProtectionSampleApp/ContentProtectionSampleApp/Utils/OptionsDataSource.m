//
//  OptionsDataSource.m
//  ContentProtectionSampleApp
//
//  Created on 5/24/19.
//  Copyright © 2019 Ooyala. All rights reserved.
//

#import "OptionsDataSource.h"
#import "PlayerSelectionOption.h"
#import "BasicEmbedTokenGenerator.h"
#import "OoyalaPlayerTokenPlayerViewController.h"
#import "FairplayPlayerViewController.h"
#import "DeviceManagementPlayerViewController.h"

@implementation OptionsDataSource

+ (NSArray *)options {
  return @[
           [PlayerSelectionOption initWithTitle:@"Ooyala Player Token (Unconfigured)"
                                      embedCode:@"0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52"
                                          pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                         domain:@"http://www.ooyala.com"
                                 viewController:OoyalaPlayerTokenPlayerViewController.class],
           [PlayerSelectionOption initWithTitle:@"FairPlay Ooyala Player Token (Unconfigured)"
                                      embedCode:@"c1cGpjMzE6-7Fi9nhZ01iK3Gfsyrddiu"
                                          pcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                         domain:@"http://www.ooyala.com"
                                 viewController:FairplayPlayerViewController.class],
           [PlayerSelectionOption initWithTitle:@"Fairplay Baseline Profile (Unconfigured)"
                                      embedCode:@"U0Njh4ZDE6B6s3JAng2BxnIB5evVDiM1"
                                          pcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                         domain:@"http://www.ooyala.com"
                                 viewController:FairplayPlayerViewController.class],
           [PlayerSelectionOption initWithTitle:@"Fairplay Main Profile (Unconfigured)"
                                      embedCode:@"cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ"
                                          pcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                         domain:@"http://www.ooyala.com"
                                 viewController:FairplayPlayerViewController.class],
           [PlayerSelectionOption initWithTitle:@"Fairplay High Profile (Unconfigured)"
                                      embedCode:@"d2dzhnMzE6h-LTaIavPD5k2eqLeCTMC5"
                                          pcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                         domain:@"http://www.ooyala.com"
                                 viewController:FairplayPlayerViewController.class]
//  Adobe's sample Adobe Pass MVPD doesn't respect App Transport Security. Commented out for now
//            [PlayerSelectionOption initWithTitle:@"Adobe Pass"
//                                       embedCode:@"VybW5lODrJ0uM9FBo7XTT6TNjTJfr_7G"
//                                           pcode:@"B3MDExOuTldXc1CiXbzAauYN7Iui"
//                                          domain:@"http://www.ooyala.com"
//                                  viewController:AdobePassPlayerViewController.class],
//  TODO: [PBA-5945] Fix asset configuration
//            [PlayerSelectionOption initWithTitle:@"Device Management (Unconfigured)"
//                                       embedCode:@""
//                                           pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
//                                          domain:@"http://www.ooyala.com"
//                                  viewController:DeviceManagementPlayerViewController.class],
//  TODO: [PBA-5945] Fix asset configuration
//            [PlayerSelectionOption initWithTitle:@"FairPlay (Unconfigured)"
//                                        embedCode:@"BuMjEwMDE6b8-bX45pBkcgFieNehCcln"
//                                            pcode:@"RkcjMxOtMYDwJzrPy3sWJLl6blS1"
//                                           domain:@"http://www.ooyala.com"
//                                   viewController:FairplayPlayerViewController.class]
           ];
}

@end
