//
//  OptionsViewController.m
//  OptionsSampleApp
//
//  Created by Zhihui Chen on 12/18/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "TVRatingsPlayerViewController.h"
#import <OoyalaSDK/OOOptions.h>
#import <OoyalaSDK/OOFCCTVRatingConfiguration.h>
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOPlayerDomain.h>

@interface TVRatingsPlayerViewController () <UITextFieldDelegate>

@property IBOutlet UIButton *button;
@property IBOutlet UIView *playerView;

@property OOOoyalaPlayerViewController* playerViewController;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@property int tvRatingDuration;

@end

@implementation TVRatingsPlayerViewController

@synthesize switchLabel1 = _switchLabel1;
@synthesize switchLabel2 = _switchLabel2;
@synthesize switch1 = _switch1;
@synthesize switch2 = _switch2;
@synthesize button1 = _button1;

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  if (self = [super initWithPlayerSelectionOption: playerSelectionOption]) {
    _nib = @"PlayerDoubleSwitch";
    _pcode = @"BidTQxOqebpNk1rVsjs2sUJSTOZc";
    _playerDomain = @"http://www.ooyala.com";
    _tvRatingDuration = 5;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (OOFCCTvRatingsPosition) getTVRatingPosition {
  if (_switch1.on == YES && _switch2.on == YES) {
    return OOFCCTvRatingsPositionTopLeft;
  } else if (_switch1.on == YES && _switch2.on == NO) {
    return OOFCCTvRatingsPositionTopRight;
  } else if (_switch1.on == NO && _switch2.on == YES) {
    return OOFCCTvRatingsPositionBottomLeft;
  } else { // if (_switch1.on == NO && _switch2.on == NO)
    return OOFCCTvRatingsPositionBottomRight;
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  if (_switch1 != nil) {
    _switchLabel1.text = @"On = Top, Off = Bottom";
    _switch1.on = NO;
  }
  if (_switch2 != nil) {
    _switchLabel2.text = @"On = Left, Off = Right";
    _switch2.on = NO;
  }

  [_button1 setTitle:@"Set EC" forState:UIControlStateNormal];
}

- (IBAction)onButtonClick:(id)sender {
  OOOptions *options = [OOOptions new];
  if (_playerViewController) {
    [_playerViewController removeFromParentViewController];
    [_playerViewController.view removeFromSuperview];
  }

  OOFCCTVRatingConfiguration *tvRatingConfig = [[OOFCCTVRatingConfiguration alloc] initWithDurationSeconds:_tvRatingDuration
                                                                                                   position:[self getTVRatingPosition]
                                                                                                      scale:OOFCCTVRATINGCONFIGURATION_DEFAULT_SCALE
                                                                                                    opacity:OOFCCTVRATINGCONFIGURATION_DEFAULT_OPACITY];
  options.tvRatingConfiguration = tvRatingConfig;

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
  _playerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
