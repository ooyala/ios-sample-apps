//
//  OptionTableViewCell.m
//  DownloadToOwnSampleApp
//
//  Created on 8/23/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "OptionTableViewCell.h"
#import "AssetPersistenceManager.h"
#import "PlayerSelectionOption.h"

NSString *const OptionCellReusableIdentifier = @"option cell";

@interface OptionTableViewCell ()

/**
 Shows the title of the asset
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 Shows the download state of the asset
 */
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

/**
 Shows the percentage progress of an active download.
 */
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgressView;

@end

@implementation OptionTableViewCell

/**
 When we set the option for a cell, each cell becomes a notification observer of the AssetPersistenceStateChangedNotification and AssetDownloadProgressNotification notifications.
 
 @param option with the title and embed code info that this cell can use to render its UI.
 */
- (void)setOption:(PlayerSelectionOption *)option {
  _option = option;
  
  [self updateWithState:@([[AssetPersistenceManager sharedManager] downloadStateForEmbedCode:_option.embedCode]) title:_option.title];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleAssetStateChanged:) name:AssetPersistenceStateChangedNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleProgressChanged:)
                                               name:AssetDownloadProgressNotification object:nil];
}


/**
 Updates the cell's UI given a download state and asset title.
 
 @param state of the download process for this asset.
 @param title of the asset.
 */
- (void)updateWithState:(NSNumber *)state title:(NSString *)title {
  NSString *stateStr = @"not downloaded";
  switch ([state intValue]) {
    case AssetNotDownloaded:
      self.downloadProgressView.hidden = true;
      break;
    case AssetAuthorizing:
      stateStr = @"authorizing";
      self.downloadProgressView.hidden = true;
      break;
    case AssetDownloading:
      stateStr = @"download starting";
      [self.downloadProgressView setProgress:0.0f animated:YES];
      self.downloadProgressView.hidden = false;
      break;
    case AssetPaused:
      stateStr = @"paused download";
      self.downloadProgressView.hidden = true;
      break;
    case AssetDownloaded:
      stateStr = @"downloaded";
      self.downloadProgressView.hidden = true;
      break;
    default:
      break;
  }
  
  self.titleLabel.text = title;
  self.subtitleLabel.text = stateStr;
}


/**
 When there's a download state change, this method gets called. It will update the cell's UI if the given notification has the same embed code as this cell's embed code.
 
 @param notification containing information about which embed code has a state change and what is the state.
 */
- (void)handleAssetStateChanged:(NSNotification *)notification {
  NSString *embedCode = notification.userInfo[AssetNameKey];
  NSNumber *state = notification.userInfo[AssetStateKey];
  
  // we only care if the notification's embed code is the same as the one we have in this cell.
  if ([embedCode isEqualToString:self.option.embedCode]) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self updateWithState:state title:self.option.title];
      [self.delegate optionCell:self downloadStateDidChange:state];
    });
  }
}

/**
 We'll get this notification when there's an active download in progress. This lets us know about the percentage progress.
 
 @param notification containing information about the download progress of a given embed code.
 */
- (void)handleProgressChanged:(NSNotification *)notification {
  NSString *embedCode = notification.userInfo[AssetNameKey];
  AssetPersistenceState state = [[AssetPersistenceManager sharedManager] downloadStateForEmbedCode:self.option.embedCode];
  if ([embedCode isEqualToString:self.option.embedCode] && state == AssetDownloading) {
    // Update progressView with the percentage progress of the notification. We assume it has a value between 0.0 and 1.0.
    dispatch_async(dispatch_get_main_queue(), ^{
      NSNumber *percentage = notification.userInfo[AssetProgressKey];
      self.subtitleLabel.text = [NSString stringWithFormat:@"downloading: %.0f%%", [percentage floatValue] * 100];
      [self.downloadProgressView setProgress:[percentage floatValue] animated:YES];
    });
  }
}

@end

