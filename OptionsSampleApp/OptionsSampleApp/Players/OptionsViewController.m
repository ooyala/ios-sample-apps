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

@property IBOutlet UIButton *button;
@property IBOutlet UIView *playerView;

@property OOOoyalaPlayerViewController* playerViewController;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@end

@implementation OptionsViewController

@synthesize switchLabel1 = _switchLabel1;
@synthesize switchLabel2 = _switchLabel2;
@synthesize switch1 = _switch1;
@synthesize switch2 = _switch2;
@synthesize text1 = _text1;
@synthesize text2 = _text2;

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  if (self = [super initWithPlayerSelectionOption: playerSelectionOption]) {

    if (playerSelectionOption.nib) {
      _nib = playerSelectionOption.nib;
    } else {
      _nib = @"PlayerDoubleSwitch";
    }
    _pcode =@"BidTQxOqebpNk1rVsjs2sUJSTOZc";
    _playerDomain = @"http://www.ooyala.com";
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  if (_switch1 != nil) {
    _switchLabel1.text = @"ShowPromoImage";
    _switch1.on = NO;
  }
  if (_switch2 != nil) {
    _switchLabel2.text = @"Preload";
    _switch2.on = YES;
  }

  if (_text1 != nil) {
    _switchLabel1.text = @"network timeout";
    _text1.text = @"60.0";
    _text1.delegate = self;
  }

  if (_text2 != nil) {
    _switchLabel2.text = @"";
    _switchLabel2.enabled = NO;
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

- (IBAction)onButtonClick:(id)sender {
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
    [[OOOoyalaPlayerViewController alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];

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

#pragma mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {

  [textField resignFirstResponder];
  return YES;
}
@end
