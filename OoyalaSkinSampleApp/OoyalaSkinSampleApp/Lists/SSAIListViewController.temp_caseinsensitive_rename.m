//
//  SsaiListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "SsaiListViewController.h"
#import "DefaultSkinPlayerViewController.h"

@interface SsaiListViewController ()

@end

@implementation SsaiListViewController

- (void)addTestCases {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Small Player View (BigBuck+Ads)"
                                                            embedCode:@"ZhMmkycjr4jlHIjvpIIimQSf_CjaQs48"
                                                                pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                         playerDomain:@"http://www.ooyala.com"
                                                       viewController:[DefaultSkinPlayerViewController class] nib: @"SSAIPlayerViewController"]];
  
  
}

@end
