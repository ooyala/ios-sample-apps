//
//  AssetPersistenceManager.m
//  DownloadToOwnSampleApp
//
//  Created on 8/29/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "AssetPersistenceManager.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "PlayerSelectionOption.h"

NSNotificationName const AssetPersistenceStateChangedNotification = @"AssetPersistenceStateChangedNotification";
NSNotificationName const AssetDownloadProgressNotification = @"AssetDownloadProgressNotification";

NSString * const AssetNameKey = @"name";
NSString * const AssetStateKey = @"downloadState";
NSString * const AssetProgressKey = @"percentage";

@interface AssetPersistenceManager () <OOAssetDownloadManagerDelegate>

@property (nonatomic) NSMutableArray *activeDownloads; // List of OOAssetDownloadManager

@end

@implementation AssetPersistenceManager

+ (AssetPersistenceManager *)sharedManager {
  static AssetPersistenceManager *manager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [[self alloc] init];
  });
  return manager;
}

- (AssetPersistenceState)downloadStateForEmbedCode:(NSString *)embedCode {
  NSURL *fileURL = [[NSUserDefaults standardUserDefaults] URLForKey:embedCode];
  if ([[NSFileManager defaultManager] fileExistsAtPath:fileURL.path]) {
    return AssetDownloaded;
  } else {
    for (OOAssetDownloadManager *downloadManager in self.activeDownloads) {
      if ([downloadManager.embedCode isEqualToString:embedCode]) {
        return AssetDownloading;
      }
    }
    
    return AssetNotDownloaded;
  }
}

- (void)startDownloadForOption:(PlayerSelectionOption *)option {
  OOAssetDownloadManager *downloadManager = [self buildDownloadManagerForOption:option];
  downloadManager.delegate = self;
  [downloadManager startDownload];
}

- (void)cancelDownloadForEmbedCode:(NSString *)embedCode {
  for (OOAssetDownloadManager *downloadManager in self.activeDownloads) {
    if ([downloadManager.embedCode isEqualToString:embedCode]) {
      [downloadManager cancelDownload];
      
      NSDictionary *userInfo = @{AssetNameKey: embedCode,
                                 AssetStateKey: @(AssetNotDownloaded)};
      [[NSNotificationCenter defaultCenter] postNotificationName:AssetPersistenceStateChangedNotification object:nil userInfo:userInfo];
      break;
    }
  }
}

- (void)deleteDownloadedFileForEmbedCode:(NSString *)embedCode {
  [OOAssetDownloadManager deleteAssetAtLocation:[[NSUserDefaults standardUserDefaults] URLForKey:embedCode]];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:embedCode];
  
  NSDictionary *userInfo = @{AssetNameKey: embedCode,
                             AssetStateKey: @(AssetNotDownloaded)};
  [[NSNotificationCenter defaultCenter] postNotificationName:AssetPersistenceStateChangedNotification object:nil userInfo:userInfo];
}

- (NSURL *)downloadLocationForEmbedCode:(NSString *)embedCode {
  return [[NSUserDefaults standardUserDefaults] URLForKey:embedCode];
}

- (NSMutableArray *)activeDownloads {
  if (!_activeDownloads) {
    _activeDownloads = [NSMutableArray new];
  }
  return _activeDownloads;
}

- (OOAssetDownloadManager *)buildDownloadManagerForOption:(PlayerSelectionOption *)option {
  OOAssetDownloadOptions *options = [OOAssetDownloadOptions new];
  options.pcode = option.pcode;
  options.embedCode = option.embedCode;
  options.domain = [OOPlayerDomain domainWithString:option.domain];
  options.embedTokenGenerator = option.embedTokenGenerator;
  return [[OOAssetDownloadManager alloc] initWithOptions:options];
}

#pragma mark - OOAssetDownloadManagerDelegate methods

- (void)downloadManager:(OOAssetDownloadManager *)manager downloadTaskStartedWithError:(OOOoyalaError *)error {
  AssetPersistenceState downloadState = AssetDownloading;
  if (error) {
    downloadState = AssetNotDownloaded;
  } else {
    [self.activeDownloads addObject:manager];
  }
  
  NSDictionary *userInfo = @{AssetNameKey: manager.embedCode,
                             AssetStateKey: @(downloadState)};
  [[NSNotificationCenter defaultCenter] postNotificationName:AssetPersistenceStateChangedNotification object:nil userInfo:userInfo];
}

- (void)downloadManager:(OOAssetDownloadManager *)manager downloadCompletedAtLocation:(NSURL *)location withError:(OOOoyalaError *)error {
  AssetPersistenceState downloadState = AssetDownloaded;
  if (error) {
    downloadState = AssetNotDownloaded;
  } else {
    [[NSUserDefaults standardUserDefaults] setURL:location forKey:manager.embedCode];
  }
  
  [self.activeDownloads removeObject:manager];
  
  NSDictionary *userInfo = @{AssetNameKey: manager.embedCode,
                             AssetStateKey: @(downloadState)};
  [[NSNotificationCenter defaultCenter] postNotificationName:AssetPersistenceStateChangedNotification object:nil userInfo:userInfo];
}

- (void)downloadManager:(OOAssetDownloadManager *)manager downloadPercentage:(Float64)percentage {
  NSDictionary *userInfo = @{AssetNameKey: manager.embedCode,
                             AssetProgressKey: @(percentage)};
  [[NSNotificationCenter defaultCenter] postNotificationName:AssetDownloadProgressNotification object:nil userInfo:userInfo];
}

@end
