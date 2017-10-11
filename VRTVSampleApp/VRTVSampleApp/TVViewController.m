//
//  ViewController.m
//  VRTVSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "TVViewController.h"
#import <OoyalaTVSDK/OoyalaSDK.h>
#import <OoyalaTVSkinSDK/OOOoyalaTVPlayerViewController.h>


@interface TVViewController ()

@property(weak, nonatomic) IBOutlet UIView *skinContainerView;
@property(nonatomic, retain) OOOoyalaTVPlayerViewController *skinController;

@end


@implementation TVViewController

#pragma mark - Constants

NSString *TV_PCODE_TEST        = @"NsaGsyOsKcRsCFZkHnYdKEw7vFn-";
NSString *TV_PLAYERDOMAIN_TEST = @"http://www.ooyala.com";

NSString *TV_EMBEDCODE_TEST0 = @"9lOTNoYzE6p28uUxpsf2LdgrpqCvfewx"; // ---> bridge
NSString *TV_EMBEDCODE_TEST1 = @"9nOTNoYzE60OwgWokmaM8UtEkWLnwcmP"; // ---> london
NSString *TV_EMBEDCODE_TEST2 = @"BkcDU4YzE6DN1Be7WsrUyXgD_4N6pCI-"; // ---> beach hight quality
NSString *TV_EMBEDCODE_TEST4 = @"xvdnJtYzE6AGavqHz4NicycL2LcZyVX4"; // ---> London hight quality. No Ad

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  OOOptions *options = [OOOptions new];
  
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:TV_PCODE_TEST
                                                                domain:[[OOPlayerDomain alloc] initWithString:TV_PLAYERDOMAIN_TEST]
                                                               options:options];
  
  _skinController = [[OOOoyalaTVPlayerViewController alloc] initWithPlayer:ooyalaPlayer];

  _skinController.view.frame = _skinContainerView.bounds;
  _skinController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  
  [_skinContainerView addSubview:_skinController.view];
  
  [self addChildViewController:_skinController];
  
  [ooyalaPlayer setEmbedCode:TV_EMBEDCODE_TEST0];
}

@end
