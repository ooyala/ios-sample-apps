//
//  SkinSDKListViewController.m
//  ChromecastSampleApp
//
//  Created on 4/2/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import "SkinSDKListViewController.h"
#import "SkinPlayerViewController.h"
#import "OptionsDataSource.h"


@interface SkinSDKListViewController ()
@end

@implementation SkinSDKListViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"OoyalaSkinSDK assets";
}

#pragma mark - Table View

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  [super prepareForSegue:segue sender:sender];
  SkinPlayerViewController *controller = segue.destinationViewController;
  ChromecastPlayerSelectionOption *selection = OptionsDataSource.options[self.lastSelected.row];
  controller.mediaInfo = selection;
}

@end
