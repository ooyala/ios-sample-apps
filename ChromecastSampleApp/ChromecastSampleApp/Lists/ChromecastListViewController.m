                                                                                                        //
//  ViewController.m
//  ChromecastSampleApp
//
//  Created by Liusha Huang on 9/18/14.
//  Copyright (c) 2014 Liusha Huang. All rights reserved.
//

#import "ChromecastListViewController.h"
#import "PlayerViewController.h"
#import "Utils.h"
#import "CustomizedMiniControllerView.h"
#import "ChromecastPlayerSelectionOption.h"
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaCastSDK/OOCastMiniControllerView.h>
#import <OoyalaCastSDK/OOCastPlayer.h>
#import <OoyalaCastSDK/OOCastMiniControllerView.h>
#import "OOCastManagerFetcher.h"

@interface ChromecastListViewController ()
@property(nonatomic, strong) IBOutlet UINavigationItem *navigationBar;
@property(nonatomic, strong) NSMutableArray *mediaList;
@property(nonatomic, strong) ChromecastPlayerSelectionOption *currentMediaInfo;
@property(nonatomic, strong) OOCastManager *castManager;

@property (strong, nonatomic) UIBarButtonItem *castButton;
@property (strong, nonatomic) OOCastMiniControllerView *miniControllerView;
@property (strong, nonatomic) OOCastMiniControllerView *bottomMiniControllerView;
@property (strong, nonatomic) NSMutableArray *cells;
@end

@implementation ChromecastListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  //[Utils cleanupLocalFiles];
  self.castManager = [OOCastManagerFetcher fetchCastManager];
  self.castManager.delegate = self;

  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:[self.castManager getCastButton]];
  self.navigationBar.rightBarButtonItem = rightButton;
  [self buildMediaDictionary];
  [self buildTableViewCells];
  
  [self.castManager disconnectFromOoyalaPlayer];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [self dismissMiniController];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissMiniController) name:OOCastManagerDidDisconnectNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(miniControllerClicked) name:OOCastMiniControllerClickedNotification object:nil];
  self.castManager.delegate = self;
  if ([self.castManager isInCastMode]) {
    [self displayMiniController];
  }
}

- (UIViewController *)currentTopUIViewController {
  return [Utils currentTopUIViewController];
}

- (void)initPlayerViewControllerwithEmbedcode {
  NSLog(@"Mini Controller click received");
  NSString *embedcode = self.castManager.castPlayer.embedCode;
  if (![self.navigationController.topViewController isKindOfClass:[PlayerViewController class]]) {
    for (ChromecastPlayerSelectionOption *mediaInfo in self.mediaList) {
      if ([mediaInfo.embedCode isEqualToString:embedcode]) {
        [self dismissMiniController];
        self.currentMediaInfo = mediaInfo;
        [self performSegueWithIdentifier:@"play" sender:self];
      }
    }
  }
}


- (void)displayMiniController {
  [self.navigationController setToolbarHidden:NO animated:YES];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(initPlayerViewControllerwithEmbedcode)];
  [tap setNumberOfTapsRequired:1];
  [self.navigationController.toolbar addGestureRecognizer:tap];

  self.bottomMiniControllerView = [[OOCastMiniControllerView alloc] initWithFrame:self.navigationController.toolbar.frame castManager:self.castManager];
  [self.castManager.castPlayer registerMiniController:self.bottomMiniControllerView];
  self.bottomMiniControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

  UIBarButtonItem *miniController = [[UIBarButtonItem alloc] initWithCustomView:self.bottomMiniControllerView];

  UIBarButtonItem *negativeSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
  negativeSeparator.width = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? -20 : -16;

  NSMutableArray *items = [[NSMutableArray alloc] init];
  [items addObject:negativeSeparator];
  [items addObject:miniController];
  self.toolbarItems = items;
}

- (void)dismissMiniController {
  [self.miniControllerView dismiss];
  [self.navigationController setToolbarHidden:YES animated:YES];
}

-(void)miniControllerClicked {
  [self initPlayerViewControllerwithEmbedcode];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.mediaList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [self.cells objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Display the media details view.
  self.currentMediaInfo = [self.mediaList objectAtIndex:indexPath.row];
  [self performSegueWithIdentifier:@"play" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  [[segue destinationViewController] setMediaInfo:self.currentMediaInfo];
}

- (void)buildMediaDictionary {
  self.mediaList = [[NSMutableArray alloc] init];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"HLS Asset"
                                                                          embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:[PlayerViewController class]]];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"VOD with CC Asset"
                                                                          embedCode:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:[PlayerViewController class]]];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"MP4 Video"
                                                                          embedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:[PlayerViewController class]]];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Encrypted HLS Asset"
                                                                          embedCode:@"ZtZmtmbjpLGohvF5zBLvDyWexJ70KsL-"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:[PlayerViewController class]]];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Playready Smooth with Clear HLS Backup"
                                                                          embedCode:@"pkMm1rdTqIAxx9DQ4-8Hyp9P_AHRe4pt"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:[PlayerViewController class]]];
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"2 Assets autoplayed"
                                                                          embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                          embedCode2:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:[PlayerViewController class]]];

  //This asset will not be configured correctly. To test your OPT-enabled assets, you need:
  // 1. an OPT-enabled embed code (set here)
  // 2. the correlating PCode (set here)
  // 3. an API Key and Secret for the provider to locally-sign the authorization (set in the PlayerViewController)
  [self.mediaList addObject: [[ChromecastPlayerSelectionOption alloc] initWithTitle:@"Ooyala Player Token Asset (unconfigured)"
                                                                          embedCode:@"0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52"
                                                                              pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                             domain:@"http://www.ooyala.com"
                                                                     viewController:[PlayerViewController class]]];
}

- (void)buildTableViewCells {
  if (self.cells == nil) {
    self.cells = [[NSMutableArray alloc] init];
  }
  for (int i = 0; i < self.mediaList.count; i++) {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    ChromecastPlayerSelectionOption *mediaInfo = [self.mediaList objectAtIndex:i];

    UILabel *mediaTitle = (UILabel *)[cell viewWithTag:1];
    mediaTitle.text = mediaInfo.title;

    [self.cells addObject:cell];
  }
}


@end
