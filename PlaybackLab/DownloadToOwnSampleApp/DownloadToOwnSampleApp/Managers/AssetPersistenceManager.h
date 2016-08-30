//
//  AssetPersistenceManager.h
//  DownloadToOwnSampleApp
//
//  Created on 8/29/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlayerSelectionOption;

typedef NS_ENUM(NSInteger, AssetPersistenceState) {
  AssetNotDownloaded,
  AssetDownloading,
  AssetDownloaded,
};

FOUNDATION_EXPORT NSNotificationName const AssetPersistenceStateChangedNotification;
FOUNDATION_EXPORT NSNotificationName const AssetDownloadProgressNotification;

FOUNDATION_EXPORT NSString * const AssetNameKey;
FOUNDATION_EXPORT NSString * const AssetStateKey;
FOUNDATION_EXPORT NSString * const AssetProgressKey;

@interface AssetPersistenceManager : NSObject

+ (AssetPersistenceManager *)sharedManager;
- (instancetype)init NS_UNAVAILABLE;

- (AssetPersistenceState)downloadStateForEmbedCode:(NSString *)embedCode;
- (void)startDownloadForOption:(PlayerSelectionOption *)option;
- (void)cancelDownloadForEmbedCode:(NSString *)embedCode;
- (void)deleteDownloadedFileForEmbedCode:(NSString *)embedCode;
- (NSURL *)downloadLocationForEmbedCode:(NSString *)embedCode;

@end
