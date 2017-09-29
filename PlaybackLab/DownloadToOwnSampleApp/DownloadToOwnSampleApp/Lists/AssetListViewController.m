//
//  AssetListViewController.m
//  DownloadToOwnSampleApp
//
//  Created on 8/23/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "AssetListViewController.h"
#import "OptionTableViewCell.h"
#import "OptionsDataSource.h"
#import "PlayerSelectionOption.h"
#import "AssetPersistenceManager.h"

#import "PlayerViewController.h"

#import <OoyalaSDK/OoyalaSDK.h>

#define PLAYER_SEGUE @"videoSegue"

@interface AssetListViewController () <OptionTableViewCellDelegate>

@property (nonatomic) NSArray *options; //List of PlayerSelectionOption

@end

@implementation AssetListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 75.0;
}


/**
 Initializes the options when it is first requested.
 
 @return an Array of PlayerSelectionOption instances.
 */
- (NSArray *)options {
  if (!_options) {
    // OptionsDataSource contains the information of all the assets in the app.
    _options = [OptionsDataSource options];
  }
  return _options;
}

#pragma mark - OptionTableViewCellDelegate methods

- (void)optionCell:(OptionTableViewCell *)cell downloadStateDidChange:(NSNumber *)state {
  // the given cell is letting this delegate (table view) know that the download state of its asset changed. Refresh the UI for that given cell.
  NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
  if (indexPath) {
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
  }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  // OptionCellReusableIdentifier has to match the identifier set in the Storyboard for the cell.
  OptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OptionCellReusableIdentifier forIndexPath:indexPath];
  
  PlayerSelectionOption *option = self.options[indexPath.row];
  cell.option = option;
  // This class will be delegate of all of the created cells.
  cell.delegate = self;
  
  return cell;
}

// Called when the accessoryButton in the cell is tapped.
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  OptionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  PlayerSelectionOption *option = cell.option;
  
  AssetPersistenceState state = [[AssetPersistenceManager sharedManager] downloadStateForEmbedCode:option.embedCode];
  NSArray *alertActions = nil;
  //  UIAlertAction *alertAction = nil;
  
  switch (state) {
    case AssetNotDownloaded:
    {
      alertActions = [[NSArray alloc] initWithObjects:
                      [UIAlertAction actionWithTitle:@"Download" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[AssetPersistenceManager sharedManager] startDownloadForOption:option];
      }], nil];
      break;
    }
    case AssetAuthorizing:
    case AssetDownloading:
    case AssetResuming:
    {
      alertActions = [[NSArray alloc] initWithObjects:
                      [UIAlertAction actionWithTitle:@"Pause"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * _Nonnull action) {
                                               [[AssetPersistenceManager sharedManager] pauseDownloadForEmbedCode:option.embedCode];
                                             }],
                      [UIAlertAction actionWithTitle:@"Cancel"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * _Nonnull action) {
                                               [[AssetPersistenceManager sharedManager] cancelDownloadForEmbedCode:option.embedCode];
                                             }], nil];
      break;
    }
    case AssetPaused:
    {
      alertActions = [[NSArray alloc] initWithObjects:
                      [UIAlertAction actionWithTitle:@"Resume"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * _Nonnull action) {
                                               [[AssetPersistenceManager sharedManager] resumeDownloadForEmbedCode:option.embedCode];
                                             }], nil];
      break;
    }
    case AssetDownloaded:
    {
      alertActions = [[NSArray alloc] initWithObjects:
                      [UIAlertAction actionWithTitle:@"Delete"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * _Nonnull action) {
                                               [[AssetPersistenceManager sharedManager] deleteDownloadedFileForEmbedCode:option.embedCode];
                                             }], nil];
      break;
    }
  }
  
  // Show an UIAlertController with different options, the alert might show Download, Cancel or Delete, depending on the download state of the asset.
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:option.title
                                                                           message:@"Select an option"
                                                                    preferredStyle:UIAlertControllerStyleActionSheet];
  for (UIAlertAction *action in alertActions) {
    [alertController addAction:action];
  }
  [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    alertController.popoverPresentationController.sourceView = cell;
    alertController.popoverPresentationController.sourceRect = cell.bounds;
  }
  
  [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // When tapping on a cell, we'll transition to the PlayerViewController. If that's the case set the PlayerSelectionOption for the player.
  if ([sender isKindOfClass:[OptionTableViewCell class]] && [segue.identifier isEqualToString:PLAYER_SEGUE]) {
    PlayerViewController *playerViewController = segue.destinationViewController;
    OptionTableViewCell *cell = sender;
    playerViewController.option = cell.option;
  }
}

@end

