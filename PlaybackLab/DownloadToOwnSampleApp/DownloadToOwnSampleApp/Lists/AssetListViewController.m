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

#import "PlayerViewController.h"

#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSDK/OODtoAsset.h>

#define PLAYER_SEGUE @"videoSegue"

@interface AssetListViewController ()

@property (nonatomic) NSMutableArray<OODtoAsset *> *dtoAssets;

@end

@implementation AssetListViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.tableFooterView = [UIView new];

  _dtoAssets = [NSMutableArray array];
  NSArray *options = [OptionsDataSource options];
  for (PlayerSelectionOption *oneOption in options) {
    [_dtoAssets addObject:[self buildDownloadManagerForOption:oneOption]];
  }
}

/**
 Builds an OODtoAsset with the given options.

 @param option PlayerSelectionOption with the asset information.
 @return new OODtoAsset instance.
 */
- (OODtoAsset *)buildDownloadManagerForOption:(PlayerSelectionOption *)option {
  OOAssetDownloadOptions *options = [OOAssetDownloadOptions new];
  options.pcode = option.pcode;
  options.embedCode = option.embedCode;
  options.domain = [OOPlayerDomain domainWithString:option.domain];
  options.embedTokenGenerator = option.embedTokenGenerator;
  return [[OODtoAsset alloc] initWithOptions:options andName:option.title];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.dtoAssets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  // OptionCellReusableIdentifier has to match the identifier set in the Storyboard for the cell.
  OptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OptionCellReusableIdentifier
                                                              forIndexPath:indexPath];
  OODtoAsset *dtoAsset = self.dtoAssets[indexPath.row];

  cell.downloadProgressView.hidden = YES;
  cell.titleLabel.text = dtoAsset.name;
  cell.subtitleLabel.text = dtoAsset.stateText;

  return cell;
}

// Called when the accessoryButton in the cell is tapped.
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  OptionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  OODtoAsset *dtoAsset = self.dtoAssets[indexPath.row];

  NSArray *alertActions = nil;
  
  switch (dtoAsset.state) {
    case OODtoAssetStateNotDownloaded:
    {
      alertActions = @[[UIAlertAction actionWithTitle:@"Download"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
        cell.downloadProgressView.hidden = NO;
        cell.downloadProgressView.progress = 0;
        [dtoAsset downloadWithProgressClosure:^(double progress) {
          dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"progress %f", progress);
            cell.subtitleLabel.text = [NSString stringWithFormat:@"%@ %.02f%%", dtoAsset.stateText, progress*100];
            cell.downloadProgressView.progress = (float)progress;
          });
        }];
        [dtoAsset finishWithRelativePath:^(NSString *relativePath) {
          dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            NSLog(@"%@", relativePath);
          });
        }];
        [dtoAsset onErrorWithErrorClosure:^(OOOoyalaError *error) {
          NSLog(@"LOGLOG error");
        }];
                      }]
                      ];
      break;
    }
    case OODtoAssetStateAuthorizing:
    case OODtoAssetStateDownloading:
    {
      alertActions = @[[UIAlertAction actionWithTitle:@"Pause"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
        [dtoAsset pauseDownload];
                                             }],
                      [UIAlertAction actionWithTitle:@"Cancel"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
        [dtoAsset cancelDownload];
                                             }]
                      ];
      break;
    }
    case OODtoAssetStatePaused:
    {
      alertActions = @[[UIAlertAction actionWithTitle:@"Resume"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
       [dtoAsset resumeDownload];
                                             }]
                       ];
      break;
    }
    case OODtoAssetStateDownloaded:
    {
      alertActions = @[[UIAlertAction actionWithTitle:@"Delete"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
       [dtoAsset deleteAsset];
       [self.tableView reloadData];
                                             }]
                       ];
      break;
    }
  }
  
  // Show an UIAlertController with different options, the alert might show Download, Cancel or Delete, depending on the download state of the asset.
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:dtoAsset.name
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  OODtoAsset *dtoAsset = self.dtoAssets[indexPath.row];
  [self performSegueWithIdentifier:PLAYER_SEGUE sender:dtoAsset];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // When tapping on a cell, we'll transition to the PlayerViewController. If that's the case set the PlayerSelectionOption for the player.
  if ([sender isKindOfClass:OODtoAsset.class] && [segue.identifier isEqualToString:PLAYER_SEGUE]) {
    PlayerViewController *playerViewController = segue.destinationViewController;
    OODtoAsset *dtoAsset = sender;
    playerViewController.dtoAsset = dtoAsset;
//    playerViewController.option = cell.option;
  }
}

@end

