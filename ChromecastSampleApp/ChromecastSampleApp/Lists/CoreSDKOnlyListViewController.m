                                                                                                        //
//  CoreSDKOnlyListViewController.m
//  ChromecastSampleApp
//
//  Created on 9/18/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import "CoreSDKOnlyListViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "PlayerViewController.h"
#import "Utils.h"
#import "ChromecastPlayerSelectionOption.h"
#import "OOCastManagerFetcher.h"
#import "OptionsDataSource.h"

@interface CoreSDKOnlyListViewController ()

@property (nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (nonatomic) OOCastManager *castManager;

@property (nonatomic) UIBarButtonItem *castButton;
@property (nonatomic) OOCastMiniControllerView *bottomMiniControllerView;

@property (nonatomic) NSIndexPath *lastSelected;

@end

@implementation CoreSDKOnlyListViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];

  _castManager = [OOCastManagerFetcher fetchCastManager];
  _castManager.delegate = self;

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
  } else {
    [self dismissMiniController];
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

  if (!self.bottomMiniControllerView) {
    _bottomMiniControllerView = [[OOCastMiniControllerView alloc] initWithFrame:self.navigationController.toolbar.frame
                                                                    castManager:self.castManager
                                                                       delegate:self];
  }
  
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

- (void)castManager:(nonnull OOCastManager *)manager
didFailToStartSessionWithError:(nonnull NSError *)error {
}

- (void)castManager:(nonnull OOCastManager *)manager
didEndSessionWithError:(nonnull NSError *)error {
}

- (void)castManager:(nonnull OOCastManager *)manager
 castRequestWithtId:(NSInteger)requestId
   didFailWithError:(nonnull GCKError *)error {
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return OptionsDataSource.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ChromecastPlayerSelectionOption *mediaInfo = OptionsDataSource.options[indexPath.row];

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
  [segue.destinationViewController setMediaInfo:OptionsDataSource.options[self.lastSelected.row]];
}

@end
