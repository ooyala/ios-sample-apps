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

@interface OptionsViewController () <UITextFieldDelegate>

@property IBOutlet UILabel *label1;
@property IBOutlet UILabel *label2;
@property IBOutlet UISwitch *switch1;
@property IBOutlet UISwitch *switch2;
@property IBOutlet UITextField *text1;
@property IBOutlet UITextField *text2;
@property IBOutlet UIButton *button;
@property IBOutlet UIView *playerView;

@property OOOoyalaPlayerViewController* playerViewController;

- (IBAction)onButton:(id)sender;

@end

@implementation OptionsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  if (_switch1 != nil) {
    _label1.text = @"ShowPromoImage";
    _switch1.on = NO;
  }
  if (_switch2 != nil) {
    _label2.text = @"Preload";
    _switch2.on = YES;
  }

  if (_text1 != nil) {
    _label1.text = @"network timeout";
    _text1.text = @"60.0";
    _text1.delegate = self;
  }

  if (_text2 != nil) {
    _label2.text = @"";
    _label2.enabled = NO;
    _text2.enabled = NO;
  }

  [_button setTitle:@"Create" forState:UIControlStateNormal];
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

- (IBAction)onButton:(id)sender {
  NSString *const PCODE        = @"BidTQxOqebpNk1rVsjs2sUJSTOZc";
  NSString *const PLAYERDOMAIN = @"http://www.ooyala.com";

  OOOptions *options = [OOOptions new];
  if (_switch1 != nil) {
    options.showPromoImage = _switch1.on;
  }

  if (_switch2 != nil) {
    options.preloadContent = _switch2.on;
  }

  if (_text1 != nil) {
    NSTimeInterval timeout = [_text1.text floatValue];
    options.connectionTimeout = timeout;
  }

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

#pragma mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {

  [textField resignFirstResponder];
  return YES;
}
@end
