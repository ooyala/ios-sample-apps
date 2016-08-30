//
//  DownloadViewController.m
//  DownloadToOwnSampleApp
//
//  Created by Eric Vargas on 8/16/16.
//  Copyright © 2016 Eric Vargas. All rights reserved.
//

#import "DownloadViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>

@interface DownloadViewController ()

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (nonatomic) OOAssetDownloadManager *manager;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation DownloadViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.cancelButton.enabled = NO;
}

- (IBAction)start {
  [self.manager startDownload];
  self.startButton.enabled = NO;
  self.cancelButton.enabled = YES;
}

- (IBAction)cancel {
  [self.manager cancelDownload];
  self.cancelButton.enabled = NO;
  self.startButton.enabled = YES;
}

@end
