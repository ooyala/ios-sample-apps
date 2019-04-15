/**
 * @class      NielsenPlayerViewcontroller NielsenPlayerViewcontroller.m "NielsenPlayerViewcontroller.m"
 * @brief      A player that demos how to send Nielsen analytics
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "NielsenPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaNielsenSDK/OONielsenPlugin.h>
#import <NielsenAppApi/NielsenAppApi.h>
#import "PlayerSelectionOption.h"

@interface NielsenPlayerViewController () <UIWebViewDelegate>

@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic) OONielsenPlugin *nielsenPlugin;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;

@end

@implementation NielsenPlayerViewController

NSString *const APPID = @"appid";
NSString *const SFCODE = @"sfcode";

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerSimple";
  self.pcode = self.playerSelectionOption.pcode;
  self.playerDomain = @"http://www.ooyala.com";

  if (self.playerSelectionOption) {
    _embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  // Do any additional setup after loading the view, typically from a nib.
  [super viewDidLoad];

  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Opt In/Out"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(onOptButton:)];
  self.navigationItem.rightBarButtonItem = rightButton;

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  _ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

  NSDictionary *parameters = @{@"longitude":@"37.783", @"latitude":@"122.417"};
  _nielsenPlugin = [[OONielsenPlugin alloc] initWithPlayer:self.ooyalaPlayerViewController.player
                                                     appId:APPID
                                                appVersion:@"0.1"
                                                   appName:@"OoyalaNielsenSampleApp"
                                                    sfcode:SFCODE
                                                parameters:parameters];

  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  self.ooyalaPlayerViewController.view.frame = self.playerView.bounds;

  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

- (void)onPlayerError:(NSNotification *)notification {
  NSLog(@"Error: %@", self.ooyalaPlayerViewController.player.error);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return YES;
  }
}

- (IBAction)onOptButton:(id)sender {
  UIViewController *webController = [UIViewController new];
  UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
  webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  webView.scalesPageToFit = YES;
  NielsenAppApi *api = [_nielsenPlugin getNielsenAppApi];
  NSString *optOutUrl = api.optOutURL;
  [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:optOutUrl]]];
  webView.delegate = self;
  [webController.view addSubview:webView];
  [self.navigationController pushViewController:webController animated:YES];
}

// UIWebViewDelegate method gets called every time when the web view is going to open a URL.
// If the URL is one of our defined commands we return NO and perform the command instead. If the URL
// is not a command we return YES and the view will continue opening the new page normally.
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  NSString *command = [NSString stringWithFormat:@"%@", request.URL];

  if ([command isEqualToString:kNielsenWebClose]) {
    // Close the web view
    [self performSelector:@selector(closeOptOutView) withObject:nil afterDelay:0];
    return NO;
  }
  return (![self.nielsenPlugin.getNielsenAppApi userOptOut:command]); // Retrieve next URL if reqeusted
}

- (void)closeOptOutView {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
