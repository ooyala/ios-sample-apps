//
//  DetailViewController.m
//  AdvancedPlaybackSampleApp
//
//  Created by Michael Len on 12/2/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "DetailViewController.h"
#import "OOOoyalaPlayerViewController.h"
#import "OOOoyalaPlayer.h"
#import "OOPlayerDomain.h"

@interface DetailViewController ()
@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@end

@implementation DetailViewController

NSString * const EMBED_CODE = @"M1eWpiNTpSMLcbWjYdAymIF-o7WCWQIo";
NSString * const PCODE = @"Z5Mm06XeZlcDlfU_1R9v_L2KwYG6";
NSString * const PLAYERDOMAIN = @"http://www.ooyala.com";

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
  if (_detailItem != newDetailItem) {
      _detailItem = newDetailItem;
          
      // Update the view.
      [self configureView];
  }
}

- (void)configureView {
  // Update the user interface for the detail item.
  if (self.detailItem) {
//      self.detailDescriptionLabel.text = [self.detailItem description];
    self.navigationItem.title = [self.detailItem description];
  }
}



- (void)viewDidLoad
{
  [super viewDidLoad];
  [self configureView];
  [[NSBundle bundleWithPath:@"shared"] loadNibNamed:@"PlayerSimpleLayout" owner:self options:nil];
  // Create Ooyala ViewController
  _ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPcode:PCODE domain:[[OOPlayerDomain alloc] initWithString:PLAYERDOMAIN]];

  // Attach it to current view
  [self addChildViewController:_ooyalaPlayerViewController];
  [_ooyalaPlayerViewController.view setFrame:self.view.bounds];
  [self addChildViewController:_ooyalaPlayerViewController];
  [self.view addSubview:_ooyalaPlayerViewController.view];

  // Load the video
  [_ooyalaPlayerViewController.player setEmbedCode:EMBED_CODE];


//  [[NSNotificationCenter defaultCenter] addObserver: self
//                                           selector:@selector(notificationHandler:)
//                                               name:nil
//                                             object:_ooyalaPlayerViewController.player];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
