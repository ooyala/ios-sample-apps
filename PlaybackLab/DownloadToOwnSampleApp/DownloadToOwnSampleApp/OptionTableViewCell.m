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

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgressView;

@end

@implementation OptionTableViewCell

- (void)setOption:(PlayerSelectionOption *)option {
  _option = option;
  
  [self updateWithState:@([[AssetPersistenceManager sharedManager] downloadStateForEmbedCode:_option.embedCode]) title:_option.title];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAssetStateChanged:) name:AssetPersistenceStateChangedNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleProgressChanged:) name:AssetDownloadProgressNotification object:nil];
}

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
      stateStr = @"downloading";
      self.downloadProgressView.hidden = false;
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

- (void)handleAssetStateChanged:(NSNotification *)notification {
  NSString *embedCode = notification.userInfo[AssetNameKey];
  NSNumber *state = notification.userInfo[AssetStateKey];
  
  if ([embedCode isEqualToString:self.option.embedCode]) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self updateWithState:state title:self.option.title];
      [self.delegate optionCell:self downloadStateDidChange:state];
    });
  }
}

- (void)handleProgressChanged:(NSNotification *)notification {
  NSString *embedCode = notification.userInfo[AssetNameKey];
  if ([embedCode isEqualToString:self.option.embedCode]) {
    NSNumber *percentage = notification.userInfo[AssetProgressKey];
    [self.downloadProgressView setProgress:[percentage floatValue] animated:YES];
  }
}

@end
