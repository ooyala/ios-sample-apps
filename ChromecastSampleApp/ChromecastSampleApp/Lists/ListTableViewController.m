 //
//  ListTableViewController.m
//  ChromecastSampleApp
//
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import "ListTableViewController.h"
#import "OOCastManagerFetcher.h"
#import "ChromecastPlayerSelectionOption.h"
#import "OptionsDataSource.h"
#import "PlayerViewController.h"

@interface ListTableViewController ()

@property (nonatomic) UINavigationItem *navigationBar;

@end

@implementation ListTableViewController

NSString *segueName = @"play";

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  self.castManager = [OOCastManagerFetcher fetchCastManager];
  self.castManager.delegate = self;
  
  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:[self.castManager castButton]];
  self.navigationBar.rightBarButtonItem = rightButton;
  
  [self.castManager disconnectFromOoyalaPlayer];
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
  [self performSegueWithIdentifier:segueName sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                               style:UIBarButtonItemStylePlain
                                                              target:nil
                                                              action:nil];
  self.navigationItem.backBarButtonItem = backItem;
  
}

#pragma mark - OOCastManagerDelegate

- (void)castManagerDidEnterCastMode:(OOCastManager *)manager {
}

- (void)castManagerDidExitCastMode:(OOCastManager *)manager {
}

- (void)castManagerDidDisconnect:(OOCastManager *)manager {
}

- (void)castManager:(nonnull OOCastManager *)manager didFailToStartSessionWithError:(nonnull NSError *)error {
}

- (void)castManager:(nonnull OOCastManager *)manager didEndSessionWithError:(nonnull NSError *)error {
}

- (void)castManager:(nonnull OOCastManager *)manager castRequestWithtId:(NSInteger)requestId didFailWithError:(nonnull GCKError *)error {
}

@end

