//
//  OptionsViewController.m
//  OptionsSampleApp
//
//  Created by Zhihui Chen on 12/18/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "OptionsViewController.h"
#import "OOOptions.h"
#import "OOOoyalaPlayerViewController.h"
#import "OOPlayerDomain.h"

@interface OptionsViewController ()
@property OOOoyalaPlayerViewController* playerViewController;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel1;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel2;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation OptionsViewController
NSString * const NIB_NAME = @"PlayerDoubleSwitch";
NSString *const PCODE        = @"BidTQxOqebpNk1rVsjs2sUJSTOZc";
NSString *const PLAYERDOMAIN = @"http://www.ooyala.com";

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:NIB_NAME owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.switchLabel1.text = @"ShowPromoImage";
  self.switchLabel2.text = @"Preload";
  [self.button1 setTitle:@"Create" forState:UIControlStateNormal];
  self.switch1.on = NO;
  self.switch2.on = YES;
  self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onButtonClick:(id)sender {

  OOOptions *options = [OOOptions new];
  options.showPromoImage = self.switch1.on;
  options.preloadContent = self.switch2.on;

  if (_playerViewController) {
    [_playerViewController removeFromParentViewController];
    [_playerViewController.view removeFromSuperview];
  }
  
  _playerViewController =
    [[OOOoyalaPlayerViewController alloc] initWithPcode:PCODE domain:[[OOPlayerDomain alloc] initWithString:PLAYERDOMAIN] options:options];

  //Setup video view
  CGRect rect = self.playerView.bounds;
  [_playerViewController.view setFrame:rect];
  [self addChildViewController:_playerViewController];
  [self.playerView addSubview:_playerViewController.view];

  [_playerViewController.player setEmbedCode:self.playerSelectionOption.embedCode];
  if (_initialTime > 0) {
    [_playerViewController.player playWithInitialTime:_initialTime];
  }
  
}

@end
