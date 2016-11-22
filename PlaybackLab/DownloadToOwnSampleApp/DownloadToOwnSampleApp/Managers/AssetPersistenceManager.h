//
//  AssetPersistenceManager.h
//  DownloadToOwnSampleApp
//
//  Created on 8/29/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//
//  Use this class as an example on how to deal with multiple downloads at the same time and manages the state of each download.
//  This class broadcasts notifications about all the download tasks.
//  This class also manages the location of the downloaded videos. It saves the video URL and Fairplay license URL in the NSUserDefaults of the app.

#import <Foundation/Foundation.h>

@class PlayerSelectionOption;
@class OOOfflineVideo;


/**
 Identifies the different states for a download process. All the states are mutually exclusive for a single download task.

 - AssetNotDownloaded
 - AssetAuthorizing
 - AssetDownloading
 - AssetDownloaded
 */
typedef NS_ENUM(NSInteger, AssetPersistenceState) {
  AssetNotDownloaded,
  AssetAuthorizing,
  AssetDownloading,
  AssetDownloaded,
};

/**
 Notification sent when there's a change of state for any download.
 */
FOUNDATION_EXPORT NSNotificationName const AssetPersistenceStateChangedNotification;

/**
 Notification sent when there's an update in the download progress of any active download.
 */
FOUNDATION_EXPORT NSNotificationName const AssetDownloadProgressNotification;

/**
 Key used to find the asset name (embed code) in a notification's userInfo.
 */
FOUNDATION_EXPORT NSString * const AssetNameKey;

/**
 Key used to find the download state in a notification's userInfo.
 */
FOUNDATION_EXPORT NSString * const AssetStateKey;

/**
 Key used to find the download percentage progress in a notification's userInfo.
 */
FOUNDATION_EXPORT NSString * const AssetProgressKey;


/**
 This class works as a singleton. It manages multiple downloads, meaning it manages multiple OOAssetDownloadManager instances. Each OOAssetDownloadManager deals with one download task at the same time.
 */
@interface AssetPersistenceManager : NSObject

/**
 Get the singleton instance of this class.

 @return AssetPersistenceManager singleton instance.
 */
+ (AssetPersistenceManager *)sharedManager;


/**
 Disables creating new instances. You can only access an instance of this class by calling + (AssetPersistenceManager *)sharedManager;
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 Asks for the download state for a given embed code.

 @param embedCode to retrieve state from.
 @return AssetPersistenceState value.
 */
- (AssetPersistenceState)downloadStateForEmbedCode:(NSString *)embedCode;

/**
 Starts a download task with the given parameter options. If a download successfully starts, an AssetPersistenceStateChangedNotification notification will be sent with the new state of the download.

 @param option PlayerSelectionOption having the information about the asset to download.
 */
- (void)startDownloadForOption:(PlayerSelectionOption *)option;

/**
 If a download is in progress, this will cancel it and broadcasts a AssetPersistenceStateChangedNotification notification with the new download state of the asset.

 @param embedCode about which asset to cancel.
 */
- (void)cancelDownloadForEmbedCode:(NSString *)embedCode;


/**
 Deletes the downloaded contents of an asset, including the Fairplay license if it is a DRM protected video.

 @param embedCode of the asset to delete.
 */
- (void)deleteDownloadedFileForEmbedCode:(NSString *)embedCode;


/**
 After an asset is downloaded, calling this method builds an OOOfflineVideo instance that you can send to an OOOoyalaPlayer to play a downloaded video.

 @param embedCode of the local asset that you want to play.
 @return a valid OOOfflineVideo instance if the downloaded asset was found, or nil otherwise.
 */
- (OOOfflineVideo *)videoForEmbedCode:(NSString *)embedCode;

@end
