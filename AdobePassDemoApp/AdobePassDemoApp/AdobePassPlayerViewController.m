//
//  ViewController.m
//  AdobePassDemoApp
//
//  Created by Chris Leonavicius on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AdobePassPlayerViewController.h"
#import "AdobePassViewController.h"
#import "OOOoyalaPlayerViewController.h"
#import "OOPlayerDomain.h"

@interface AdobePassPlayerViewController () <AdobePassViewControllerDelegate>
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation AdobePassPlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerDoubleButton";
  self.pcode =@"pqdHc6rN2_wYW2z-pOmDqkUmMnI1";
  self.playerDomain = @"http://www.ooyala.com";

  if (self.playerSelectionOption) {
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
  }
  return self;
}

- (void)authChanged:(int)status {
  if (status == PASS_SUCCESS) {
    [self.button1 setTitle:@"Logout" forState:UIControlStateNormal];
    [self.button1 removeTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.button1 addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    self.ooyalaPlayerViewController.view.hidden = NO;

  } else {
    [self.button1 setTitle:@"Login" forState:UIControlStateNormal];
    [self.button1 removeTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.button1 addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.ooyalaPlayerViewController.player setEmbedCode:@"none"]; //set to dummy embed code
    self.ooyalaPlayerViewController.view.hidden = YES;
  }
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  self.passController = [[AdobePassViewController alloc] initWithRequestor:@"AdobeBEAST"
                                                             keystore:@"adobepass"
                                                              keypass:@"adobepass"
                                                             delegate:self];
  [self addChildViewController:self.passController];

  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];

  [self.playerView addSubview:_ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];

  [self addChildViewController:self.ooyalaPlayerViewController];
  self.ooyalaPlayerViewController.view.hidden = YES;

  [self.button2 setTitle:@"SetEmbedCode" forState:UIControlStateNormal];
  
  [self.passController checkAuth];
}

- (void)onRightBtnClick:(id)sender {
  //[ooController.player setEmbedCode:@"5icXRvNDrl9kxzF_58oV79ApUNRffoLR"];
  [self.ooyalaPlayerViewController.player setEmbedCode:@"VybW5lODrJ0uM9FBo7XTT6TNjTJfr_7G"];
  [self.ooyalaPlayerViewController.player play];
}

- (void)login {
  [self.passController login];
}

- (void)logout {
  [self.passController logout];
}

@end
