//
//  SampleDownloadViewController.m
//  DownloadToOwnSampleApp
//
//  Created by Eric Vargas on 9/27/16.
//  Copyright © 2016 Eric Vargas. All rights reserved.
//

#import "SampleDownloadViewController.h"
#import "BasicEmbedTokenGenerator.h"
#import <OoyalaSDK/OoyalaSDK.h>

@interface SampleDownloadViewController ()

@property (nonatomic) OOAssetDownloadManager *downloadManager;

@end

@implementation SampleDownloadViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  OOAssetDownloadOptions *options = [[OOAssetDownloadOptions alloc] init];
  options.pcode = @"x0b2cyOupu0FFK5hCr4zXg8KKcrm";
  options.embedCode = @"cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ";
  options.domain = [OOPlayerDomain domainWithString:@"http://www.ooyala.com"];
  options.embedTokenGenerator = [[BasicEmbedTokenGenerator alloc] initWithPcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                                                         apiKey:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm.-s6jH"
                                                                      apiSecret:@"ZCMQt2CCVqlHWce6dG5w2WA6fkAM_JaWgoI_yzQp"
                                                                      accountId:nil
                                                                  authorizeHost:@"http://player.ooyala.com"];
  self.downloadManager = [[OOAssetDownloadManager alloc] initWithOptions:options];
}

- (IBAction)download:(id)sender {
  [self.downloadManager startDownload];
}

@end
