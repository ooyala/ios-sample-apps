                                                                                                        //
//  ViewController.m
//  ChromecastSampleApp
//
//  Created on 9/18/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import "ChromecastListViewController.h"
#import "PlayerViewController.h"
#import "Utils.h"
#import "ChromecastPlayerSelectionOption.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "OOCastManagerFetcher.h"

@interface ChromecastListViewController ()

@property (nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (nonatomic) NSArray *mediaList;
@property (nonatomic) OOCastManager *castManager;

@property (nonatomic) UIBarButtonItem *castButton;
@property (nonatomic) OOCastMiniControllerView *bottomMiniControllerView;

@property (nonatomic) NSIndexPath *lastSelected;

@end

@implementation ChromecastListViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];

  _castManager = [OOCastManagerFetcher fetchCastManager];
  _castManager.delegate = self;

  _mediaList = [self mediaArray];

  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:[self.castManager castButton]];
  self.navigationBar.rightBarButtonItem = rightButton;

  [_castManager disconnectFromOoyalaPlayer];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self dismissMiniController];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (self.castManager.isMiniControllerInteractionAvailable) {
    [self displayMiniController];
  }
}

#pragma mark - PlayerViewController

- (void)initPlayerViewControllerWithEmbedcode {
  if (self.lastSelected &&
      ![self.navigationController.topViewController isKindOfClass:PlayerViewController.class]) {
    [self dismissMiniController];
    [self performSegueWithIdentifier:@"play" sender:self];
  }
}

#pragma mark - Mini Controller

- (void)displayMiniController {
  [self.navigationController setToolbarHidden:NO animated:YES];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(initPlayerViewControllerWithEmbedcode)];
  [tap setNumberOfTapsRequired:1];
  [self.navigationController.toolbar addGestureRecognizer:tap];

  _bottomMiniControllerView = [[OOCastMiniControllerView alloc] initWithFrame:self.navigationController.toolbar.frame
                                                                  castManager:self.castManager
                                                                     delegate:self];
  [self.castManager registerMiniController:self.bottomMiniControllerView];
  self.bottomMiniControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

  UIBarButtonItem *miniController = [[UIBarButtonItem alloc] initWithCustomView:self.bottomMiniControllerView];
  UIBarButtonItem *negativeSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                     target:nil
                                                                                     action:nil];
  negativeSeparator.width = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? -20 : -16;
  self.toolbarItems = @[negativeSeparator, miniController];
}

- (void)dismissMiniController {
  [self.navigationController setToolbarHidden:YES animated:YES];
}

#pragma mark OOCastMiniControllerDelegate

- (void)miniControllerDidClickOn:(id<OOCastMiniControllerProtocol>)miniControllerView
                   withEmbedCode:(NSString *)embedCode {
  [self initPlayerViewControllerWithEmbedcode];
}

- (void)miniControllerDidDismiss:(id<OOCastMiniControllerProtocol>)miniControllerView {
  [self.navigationController setToolbarHidden:YES animated:YES];
}

#pragma mark - OOCastManagerDelegate

- (void)castManagerDidEnterCastMode:(OOCastManager *)manager {
}

- (void)castManagerDidExitCastMode:(OOCastManager *)manager {
  [self dismissMiniController];
}

- (void)castManagerDidDisconnect:(OOCastManager *)manager {
  [self dismissMiniController];
}

- (void)castManager:(OOCastManager *)manager
   didFailWithError:(NSError *)error
          andExtras:(NSDictionary *)extras {
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.mediaList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ChromecastPlayerSelectionOption *mediaInfo = self.mediaList[indexPath.row];

  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.text = mediaInfo.title;

  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Display the media details view.
  self.lastSelected = indexPath;
  [self performSegueWithIdentifier:@"play" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  [segue.destinationViewController setMediaInfo:self.mediaList[self.lastSelected.row]];
}

- (NSArray *)mediaArray {
  return @[
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"HLS Asset"
                                                        embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"VOD with CC Asset"
                                                        embedCode:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"MP4 Video"
                                                        embedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"DASH Live Channel"
                                                        embedCode:@"92Zm51ZjE6WiUvDqQ7JcqJ_yJK9e0cX4"
                                                            pcode:@"t5MGs6osydJR0KO0RRrDqi_PXSRM"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Encrypted HLS Asset"
                                                        embedCode:@"ZtZmtmbjpLGohvF5zBLvDyWexJ70KsL-"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Playready Smooth with Clear HLS Backup"
                                                        embedCode:@"pkMm1rdTqIAxx9DQ4-8Hyp9P_AHRe4pt"
                                                            pcode:@"FoeG863GnBL4IhhlFC1Q2jqbkH9m"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"2 Assets autoplayed"
                                                        embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                        embedCode2:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class],
           //This asset will not be configured correctly. To test your OPT-enabled assets, you need:
           // 1. an OPT-enabled embed code (set here)
           // 2. the correlating PCode (set here)
           // 3. an API Key and Secret for the provider to locally-sign the authorization (set in the PlayerViewController)
           [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Ooyala Player Token Asset (unconfigured)"
                                                        embedCode:@"0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52"
                                                            pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                           domain:@"http://www.ooyala.com"
                                                   viewController:PlayerViewController.class]
           ];
}

@end
