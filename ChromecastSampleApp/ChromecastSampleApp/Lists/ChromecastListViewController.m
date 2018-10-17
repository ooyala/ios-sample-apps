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
#import <OoyalaCastSDK/OOCastPlayer.h>
#import "OOCastManagerFetcher.h"

@interface ChromecastListViewController ()

@property (nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (nonatomic) NSMutableArray *mediaList;
@property (nonatomic) ChromecastPlayerSelectionOption *currentMediaInfo;
@property (nonatomic) OOCastManager *castManager;

@property (nonatomic) UIBarButtonItem *castButton;
@property (nonatomic) OOCastMiniControllerView *bottomMiniControllerView;
@property (nonatomic) NSMutableArray *cells;

@property (nonatomic) NSIndexPath *lastSelected;

@end

@implementation ChromecastListViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  //[Utils cleanupLocalFiles];
  self.castManager = [OOCastManagerFetcher fetchCastManager];
  self.castManager.delegate = self;

  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:[self.castManager castButton]];
  self.navigationBar.rightBarButtonItem = rightButton;
  [self buildMediaDictionary];
  [self buildTableViewCells];
  
  [self.castManager disconnectFromOoyalaPlayer];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self dismissMiniController];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.castManager.delegate = self;
  if (self.castManager.isMiniControllerInteractionAvailable) {
    [self displayMiniController];
  }
}

#pragma mark - PlayerViewController

- (void)initPlayerViewControllerwithEmbedcode {
  if (self.lastSelected && ![self.navigationController.topViewController isKindOfClass:PlayerViewController.class]) {
    self.currentMediaInfo = self.mediaList[self.lastSelected.row];
    [self dismissMiniController];
    [self performSegueWithIdentifier:@"play" sender:self];
  }
}

#pragma mark - Mini Controller

- (void)displayMiniController {
  [self.navigationController setToolbarHidden:NO animated:YES];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(initPlayerViewControllerwithEmbedcode)];
  [tap setNumberOfTapsRequired:1];
  [self.navigationController.toolbar addGestureRecognizer:tap];

  self.bottomMiniControllerView = [[OOCastMiniControllerView alloc] initWithFrame:self.navigationController.toolbar.frame
                                                                      castManager:self.castManager
                                                                         delegate:self];
  [self.castManager.castPlayer registerMiniController:self.bottomMiniControllerView];
  self.bottomMiniControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

  UIBarButtonItem *miniController = [[UIBarButtonItem alloc] initWithCustomView:self.bottomMiniControllerView];

  UIBarButtonItem *negativeSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                     target:nil
                                                                                     action:nil];
  negativeSeparator.width = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? -20 : -16;

  NSArray *items = @[negativeSeparator, miniController];
  self.toolbarItems = items;
}

- (void)dismissMiniController {
  [self.navigationController setToolbarHidden:YES animated:YES];
}

#pragma mark OOCastMiniControllerDelegate

- (void)miniControllerDidClickOn:(id<OOCastMiniControllerProtocol>)miniControllerView
                   withEmbedCode:(NSString *)embedCode {
  [self initPlayerViewControllerwithEmbedcode];
}

- (void)miniControllerDidDismiss:(id<OOCastMiniControllerProtocol>)miniControllerView {
  [self.navigationController setToolbarHidden:YES animated:YES];
}

#pragma mark - OOCastManagerDelegate

- (void)castManagerDidEnterCastMode:(OOCastManager *)manager {
}

- (void)castManagerDidExitCastMode:(OOCastManager *)manager {
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
  return self.cells[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Display the media details view.
  self.lastSelected = indexPath;
  self.currentMediaInfo = self.mediaList[indexPath.row];
  [self performSegueWithIdentifier:@"play" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  [segue.destinationViewController setMediaInfo:self.currentMediaInfo];
}

- (void)buildMediaDictionary {
  self.mediaList = [NSMutableArray array];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"HLS Asset"
                                                                          embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:PlayerViewController.class]];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"VOD with CC Asset"
                                                                          embedCode:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:PlayerViewController.class]];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"MP4 Video"
                                                                          embedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:PlayerViewController.class]];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Encrypted HLS Asset"
                                                                          embedCode:@"ZtZmtmbjpLGohvF5zBLvDyWexJ70KsL-"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:PlayerViewController.class]];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Playready Smooth with Clear HLS Backup"
                                                                          embedCode:@"pkMm1rdTqIAxx9DQ4-8Hyp9P_AHRe4pt"
                                                                              pcode:@"FoeG863GnBL4IhhlFC1Q2jqbkH9m"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:PlayerViewController.class]];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"2 Assets autoplayed"
                                                                          embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                          embedCode2:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:PlayerViewController.class]];

  //This asset will not be configured correctly. To test your OPT-enabled assets, you need:
  // 1. an OPT-enabled embed code (set here)
  // 2. the correlating PCode (set here)
  // 3. an API Key and Secret for the provider to locally-sign the authorization (set in the PlayerViewController)
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Ooyala Player Token Asset (unconfigured)"
                                                                          embedCode:@"0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:PlayerViewController.class]];
}

- (void)buildTableViewCells {
  if (!self.cells) {
    self.cells = [NSMutableArray array];
  }
  for (int i = 0; i < self.mediaList.count; i++) {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    ChromecastPlayerSelectionOption *mediaInfo = self.mediaList[i];

    UILabel *mediaTitle = (UILabel *)[cell viewWithTag:1];
    mediaTitle.text = mediaInfo.title;

    [self.cells addObject:cell];
  }
}


@end
