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

@property IBOutlet UILabel *switchLabel1;
@property IBOutlet UILabel *switchLabel2;
@property IBOutlet UISwitch *switch1;
@property IBOutlet UISwitch *switch2;
@property IBOutlet UIButton *button;
@property IBOutlet UIView *playerView;

@property OOOoyalaPlayerViewController* playerViewController;

- (IBAction)onButton:(id)sender;

@end

@implementation OptionsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _switchLabel1.text = @"ShowPromoImage";
  _switchLabel2.text = @"Preload";
  [_button setTitle:@"Create" forState:UIControlStateNormal];
   _switch1.on = NO;
  _switch2.on = YES;
  self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)onButton:(id)sender {
  NSString *const PCODE        = @"BidTQxOqebpNk1rVsjs2sUJSTOZc";
  NSString *const PLAYERDOMAIN = @"http://www.ooyala.com";

  OOOptions *options = [OOOptions new];
  options.showPromoImage = _switch1.on;
  options.preloadContent = _switch2.on;

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

  [_playerViewController.player setEmbedCode:_embedCode];
  if (_initialTime > 0) {
    [_playerViewController.player playWithInitialTime:_initialTime];
  }
  
}

@end
