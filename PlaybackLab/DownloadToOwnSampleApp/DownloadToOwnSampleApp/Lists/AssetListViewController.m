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

- (NSArray *)options {
  if (!_options) {
    _options = [OptionsDataSource options];
  }
  return _options;
}

#pragma mark - OptionTableViewCellDelegate methods

- (void)optionCell:(OptionTableViewCell *)cell downloadStateDidChange:(NSNumber *)state {
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
  OptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OptionCellReusableIdentifier forIndexPath:indexPath];
  
  PlayerSelectionOption *option = self.options[indexPath.row];
  cell.option = option;
  cell.delegate = self;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  OptionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  PlayerSelectionOption *option = cell.option;
  
  AssetPersistenceState state = [[AssetPersistenceManager sharedManager] downloadStateForEmbedCode:option.embedCode];
  UIAlertAction *alertAction = nil;
  
  switch (state) {
    case AssetNotDownloaded:
    {
      alertAction = [UIAlertAction actionWithTitle:@"Download" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[AssetPersistenceManager sharedManager] startDownloadForOption:option];
      }];
      break;
    }
    case AssetDownloading:
    {
      alertAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[AssetPersistenceManager sharedManager] cancelDownloadForEmbedCode:option.embedCode];
      }];
      break;
    }
    case AssetDownloaded:
    {
      alertAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[AssetPersistenceManager sharedManager] deleteDownloadedFileForEmbedCode:option.embedCode];
      }];
      break;
    }
  }
  
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:option.title
                                                                           message:@"Select an option"
                                                                    preferredStyle:UIAlertControllerStyleActionSheet];
  [alertController addAction:alertAction];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    alertController.popoverPresentationController.sourceView = cell;
    alertController.popoverPresentationController.sourceRect = cell.bounds;
  }
  
  [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([sender isKindOfClass:[OptionTableViewCell class]] && [segue.identifier isEqualToString:PLAYER_SEGUE]) {
    PlayerViewController *playerViewController = segue.destinationViewController;
    OptionTableViewCell *cell = sender;
    playerViewController.option = cell.option;
  }
}

@end
