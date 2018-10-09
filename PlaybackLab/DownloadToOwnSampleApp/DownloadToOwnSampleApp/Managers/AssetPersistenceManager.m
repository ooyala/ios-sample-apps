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

#define FAIRPLAY_KEY_NAME @"OO_DTO_%@.key"

NSNotificationName const AssetPersistenceStateChangedNotification = @"AssetPersistenceStateChangedNotification";
NSNotificationName const AssetDownloadProgressNotification = @"AssetDownloadProgressNotification";

NSString * const AssetNameKey = @"name";
NSString * const AssetStateKey = @"downloadState";
NSString * const AssetProgressKey = @"percentage";

@interface AssetPersistenceManager () <OOAssetDownloadManagerDelegate>

@property (nonatomic) NSMutableSet *downloadsPendingAuth;         // Set of OOAssetDownloadManager
@property (nonatomic) NSMutableSet *activeDownloads;              // Set of OOAssetDownloadManager
@property (nonatomic) NSMutableSet *pausedDownloads;              // Set of OOAssetDownloadManager

@end

@implementation AssetPersistenceManager

#pragma mark - private methods

/**
 Initializes the activeDownloads Set when it is first used.
 
 @return NSMutableSet instance.
 */
- (NSMutableSet *)activeDownloads {
  if (!_activeDownloads) {
    _activeDownloads = [NSMutableSet new];
  }
  return _activeDownloads;
}

/**
 Initializes the downloadsPendingAuth Set when it is first used.
 
 @return NSMutableSet instance.
 */
- (NSMutableSet *)downloadsPendingAuth {
  if (!_downloadsPendingAuth) {
    _downloadsPendingAuth = [NSMutableSet new];
  }
  return _downloadsPendingAuth;
}

/**
 Initializes the pausedDownloads Set when it is first used.
 
 @return NSMutableSet instance.
 */
- (NSMutableSet *)pausedDownloads {
  if (!_pausedDownloads) {
    _pausedDownloads = [NSMutableSet new];
  }
  return _pausedDownloads;
}


/**
 Builds an OOAssetDownloadManager with the given options.
 
 @param option PlayerSelectionOption with the asset information.
 @return new OOAssetDownloadManager instance.
 */
- (OOAssetDownloadManager *)buildDownloadManagerForOption:(PlayerSelectionOption *)option {
  OOAssetDownloadOptions *options = [OOAssetDownloadOptions new];
  options.pcode = option.pcode;
  options.embedCode = option.embedCode;
  options.domain = [OOPlayerDomain domainWithString:option.domain];
  options.embedTokenGenerator = option.embedTokenGenerator;
  return [[OOAssetDownloadManager alloc] initWithOptions:options];
}

#pragma mark - public methods

+ (AssetPersistenceManager *)sharedManager {
  static AssetPersistenceManager *manager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [[self alloc] init];
  });
  return manager;
}

- (AssetPersistenceState)downloadStateForEmbedCode:(NSString *)embedCode {
  // search if the asset exists in NSUserDefaults, meaning we already downloaded it.
  NSURL *fileURL = [[NSUserDefaults standardUserDefaults] URLForKey:embedCode];
  if ([[NSFileManager defaultManager] fileExistsAtPath:fileURL.path]) {
    return AssetDownloaded;
  } else {
    // if the asset is in the downloadsPendingAuth Set, then the asset is waiting to be authorized for download.
    for (OOAssetDownloadManager *downloadManager in self.downloadsPendingAuth) {
      if ([downloadManager.embedCode isEqualToString:embedCode]) {
        return AssetAuthorizing;
      }
    }
    
    // if the asset is in the activeDownloads Set, then the asset is downloading the video.
    for (OOAssetDownloadManager *downloadManager in self.activeDownloads) {
      if ([downloadManager.embedCode isEqualToString:embedCode]) {
        return AssetDownloading;
      }
    }
    
    for (OOAssetDownloadManager *downloadManager in self.pausedDownloads) {
      if ([downloadManager.embedCode isEqualToString:embedCode]) {
        return AssetPaused;
      }
    }
    
    // if nothing else applies then the asset is not downloaded.
    return AssetNotDownloaded;
  }
}

- (void)startDownloadForOption:(PlayerSelectionOption *)option {
  OOAssetDownloadManager *downloadManager = [self buildDownloadManagerForOption:option];
  // this class becomes the delegate of the newly created OOAssetDownloadManager instance.
  // After starting a download, we'll be notified about it in the OOAssetDownloadManagerDelegate methods.
  downloadManager.delegate = self;
  [downloadManager startDownload];
  
  // We started a download, so we can say we're waiting to be authorized.
  [self.downloadsPendingAuth addObject:downloadManager];
  NSDictionary *userInfo = @{AssetNameKey: downloadManager.embedCode,
                             AssetStateKey: @(AssetAuthorizing)};
  [[NSNotificationCenter defaultCenter] postNotificationName:AssetPersistenceStateChangedNotification object:nil userInfo:userInfo];
  NSLog(@"[AssetPersistenceManager] download intent started for embed code: %@, current download state:  Authorizing", downloadManager.embedCode);
}

- (void)pauseDownloadForEmbedCode:(NSString *)embedCode {
  // find a download in progress for the given embed code, pause the download.
  NSLog(@"[AssetPersistenceManager] Attempting to pause a download for embed code: %@", embedCode);
  
  NSSet *downloadsPendingAuthCopy = self.downloadsPendingAuth.copy;
  
  for (OOAssetDownloadManager *downloadManager in downloadsPendingAuthCopy) {
    if ([downloadManager.embedCode isEqualToString:embedCode]) {
      [downloadManager pauseDownload];
      [self.downloadsPendingAuth removeObject:downloadManager];
      [self.pausedDownloads addObject:downloadManager];
      
      NSDictionary *userInfo = @{AssetNameKey: downloadManager.embedCode,
                                 AssetStateKey: @(AssetPaused)};
      [[NSNotificationCenter defaultCenter] postNotificationName:AssetPersistenceStateChangedNotification
                                                          object:nil
                                                        userInfo:userInfo];
      return;
    }
  }
  
  NSSet *activeDownloadsCopy = self.activeDownloads.copy;
  
  for (OOAssetDownloadManager *downloadManager in activeDownloadsCopy) {
    if ([downloadManager.embedCode isEqualToString:embedCode]) {
      [downloadManager pauseDownload];
      
      [self.activeDownloads removeObject:downloadManager];
      [self.pausedDownloads addObject:downloadManager];
      
      NSDictionary *userInfo = @{AssetNameKey: downloadManager.embedCode,
                                 AssetStateKey: @(AssetPaused)};
      [[NSNotificationCenter defaultCenter] postNotificationName:AssetPersistenceStateChangedNotification
                                                          object:nil
                                                        userInfo:userInfo];
      break;
    }
  }
}

- (void)resumeDownloadForEmbedCode:(NSString *)embedCode {
  // find a paused download for the given embed code, resume the download.
  NSLog(@"[AssetPersistenceManager] Attempting to resume a download for embed code: %@", embedCode);
  
  NSSet *pausedDownloadsCopy = self.pausedDownloads.copy;
  
  for (OOAssetDownloadManager *downloadManager in pausedDownloadsCopy) {
    if ([downloadManager.embedCode isEqualToString:embedCode]) {
      [downloadManager resumeDownload];
      
      [self.pausedDownloads removeObject:downloadManager];
      [self.activeDownloads addObject:downloadManager];
      
      NSDictionary *userInfo = @{AssetNameKey: downloadManager.embedCode,
                                 AssetStateKey: @(AssetDownloading)};
      [[NSNotificationCenter defaultCenter] postNotificationName:AssetPersistenceStateChangedNotification
                                                          object:nil
                                                        userInfo:userInfo];
      break;
    }
  }
}

- (void)cancelDownloadForEmbedCode:(NSString *)embedCode {
  // find a download in progress for the given embed code, cancel the download and remove the remaining contents if something was downloaded already.
  NSLog(@"[AssetPersistenceManager] Attempting to cancel a download for embed code: %@", embedCode);
  
  NSSet *downloadsPendingAuthCopy = self.downloadsPendingAuth.copy;
  
  for (OOAssetDownloadManager *downloadManager in downloadsPendingAuthCopy) {
    if ([downloadManager.embedCode isEqualToString:embedCode]) {
      [downloadManager cancelDownload];
      [self.downloadsPendingAuth removeObject:downloadManager];
      return;
    }
  }
  
  NSSet *activeDownloadsCopy = self.activeDownloads.copy;
  
  for (OOAssetDownloadManager *downloadManager in activeDownloadsCopy) {
    if ([downloadManager.embedCode isEqualToString:embedCode]) {
      [downloadManager cancelDownload];
      [self.activeDownloads removeObject:downloadManager];
      return;
    }
  }
}

- (void)deleteDownloadedFileForEmbedCode:(NSString *)embedCode {
  // Delete the contents of a downloaded video and the reference to the URL in NSUSeerDefaults
  [OOAssetDownloadManager deleteFileAtLocation:[[NSUserDefaults standardUserDefaults] URLForKey:embedCode]];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:embedCode];
  
  // Delete a Fairplay license and the reference to the URL in NSUSeerDefaults
  [OOAssetDownloadManager deleteFileAtLocation:[[NSUserDefaults standardUserDefaults] URLForKey:[NSString stringWithFormat:FAIRPLAY_KEY_NAME, embedCode]]];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:FAIRPLAY_KEY_NAME, embedCode]];
  
  // Notify about the state of this asset to be NotDownloaded.
  NSDictionary *userInfo = @{AssetNameKey: embedCode,
                             AssetStateKey: @(AssetNotDownloaded)};
  [[NSNotificationCenter defaultCenter] postNotificationName:AssetPersistenceStateChangedNotification object:nil userInfo:userInfo];
  NSLog(@"[AssetPersistenceManager] Cancelled a download in progress for embed code: %@, current download state: Not Downloaded", embedCode);
}

- (OOOfflineVideo *)videoForEmbedCode:(NSString *)embedCode {
  // Search for the location of the video and fairplay license.
  NSURL *location = [[NSUserDefaults standardUserDefaults] URLForKey:embedCode];
  NSURL *keyLocation = [[NSUserDefaults standardUserDefaults] URLForKey:[NSString stringWithFormat:FAIRPLAY_KEY_NAME, embedCode]];
  return [OOOfflineVideo videoWithVideoLocation:location fairplayKeyLocation:keyLocation];
}

#pragma mark - OOAssetDownloadManagerDelegate methods

- (void)downloadManager:(OOAssetDownloadManager *)manager downloadTaskStartedWithError:(OOOoyalaError *)error {
  AssetPersistenceState downloadState = AssetDownloading;
  
  // the download task either started or failed to be authorized, either way we must remove it from the downloadsPendingAuth Set.
  [self.downloadsPendingAuth removeObject:manager];
  
  if (error) {
    NSLog(@"[AssetPersistenceManager] error starting a download for embed code: %@, current download state: Not Downloaded, error object: %@", manager.embedCode, error);
    downloadState = AssetNotDownloaded;
  } else {
    // If a download was started successfuly, then we add it to the activeDownloads Set.
    [self.activeDownloads addObject:manager];
    NSLog(@"[AssetPersistenceManager] download started successfuly for embed code: %@, current download state: Downloading", manager.embedCode);
  }
  
  // Notify the download state of the asset, either Downloading or NotDownloaded.
  NSDictionary *userInfo = @{AssetNameKey: manager.embedCode,
                             AssetStateKey: @(downloadState)};
  [[NSNotificationCenter defaultCenter] postNotificationName:AssetPersistenceStateChangedNotification object:nil userInfo:userInfo];
}

// This method will only be called for Fairplay assets.
- (void)downloadManager:(OOAssetDownloadManager *)manager persistedContentKeyAtLocation:(NSURL *)location {
  // Store the location of the Fairplay Key in NSUserDefaults, we'll need it to playback the DRM video offline.
  [[NSUserDefaults standardUserDefaults] setURL:location forKey:[NSString stringWithFormat:FAIRPLAY_KEY_NAME, manager.embedCode]];
  NSLog(@"[AssetPersistenceManager] Saving Fairplay license location in NSUserDefaults using key: %@", [NSString stringWithFormat:FAIRPLAY_KEY_NAME, manager.embedCode]);
}

- (void)downloadManager:(OOAssetDownloadManager *)manager downloadPercentage:(Float64)percentage {
  NSDictionary *userInfo = @{AssetNameKey: manager.embedCode,
                             AssetProgressKey: @(percentage)};
  [[NSNotificationCenter defaultCenter] postNotificationName:AssetDownloadProgressNotification object:nil userInfo:userInfo];
}

- (void)downloadManager:(OOAssetDownloadManager *)manager downloadCompletedAtLocation:(NSURL *)location withError:(OOOoyalaError *)error {
  AssetPersistenceState downloadState = AssetDownloading;
  
  // Save the location in NSUserDefaults. The location is needed it if we want to delete the file after an error.
  [[NSUserDefaults standardUserDefaults] setURL:location forKey:manager.embedCode];
  
  if (error) {
    NSLog(@"[AssetPersistenceManager] error completing a download for embed code: %@, current download state: Not Downloaded, error object: %@", manager.embedCode, error);
    downloadState = AssetNotDownloaded;
    
    [self deleteDownloadedFileForEmbedCode:manager.embedCode];
  } else {
    NSLog(@"[AssetPersistenceManager] download completed successfuly for embed code: %@ current download state: Downloaded.", manager.embedCode);
    downloadState = AssetDownloaded;
  }
  
  // At this point the download completed successfuly or not, either way we must remove the manager from the activeDownloads Set.
  [self.activeDownloads removeObject:manager];
  
  // Notify the download state of the asset, either Downloaded or NotDownloaded.
  NSDictionary *userInfo = @{AssetNameKey: manager.embedCode,
                             AssetStateKey: @(downloadState)};
  [[NSNotificationCenter defaultCenter] postNotificationName:AssetPersistenceStateChangedNotification object:nil userInfo:userInfo];
}

@end
