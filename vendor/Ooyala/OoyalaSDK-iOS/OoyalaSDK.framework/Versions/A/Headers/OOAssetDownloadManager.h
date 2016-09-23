//
//  OOAssetDownloadManager.h
//  OoyalaSDK
//
//  Created on 8/2/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OOAssetDownloadOptions;
@class OOOoyalaError;
@class OOAssetDownloadManager;

/**
 * Implement this protocol and set it as the delegate to receive important information
 * about the download.
 */
@protocol OOAssetDownloadManagerDelegate <NSObject>

/**
 * This will be called when a download task was started.
 * @param manager the OOAssetDownloadManager that called this delegate's method.
 * @param error will be nil if the download task was started successfully. Error will have a value when something went wrong.
 */
- (void)downloadManager:(OOAssetDownloadManager *)manager downloadTaskStartedWithError:(OOOoyalaError *)error;

/**
 * This will be called when a file was downloaded.
 *
 * @param manager the OOAssetDownloadManager that called this delegate's method.
 * @param location where the asset was saved. This may be nil if an error ocurred.
 * @param error will be nil if the download was successful. Error will have a value when something went wrong.
 */
- (void)downloadManager:(OOAssetDownloadManager *)manager downloadCompletedAtLocation:(NSURL *)location withError:(OOOoyalaError *)error;

/**
 * Indicates the download progress.
 *
 * @param manager the OOAssetDownloadManager that called this delegate's method.
 * @param percentage value between 0.0 and 1.0, 1.0 being a completed download.
 */
- (void)downloadManager:(OOAssetDownloadManager *)manager downloadPercentage:(Float64)percentage;

@end

NS_CLASS_AVAILABLE_IOS(10.0)
@interface OOAssetDownloadManager : NSObject

/**
 * Responds YES if there's a download in progress.
 */
@property (nonatomic, readonly, getter=isDownloadActive) BOOL downloadActive;

/**
 * Embed code managed by this OOAssetDownloadManager instance.
 * It's first initialized when supplying the OOAssetDownloadOptions.
 */
@property (nonatomic, readonly) NSString *embedCode;

/**
 * Calls this delegete when something happened with a download.
 * Check the OOAssetDownloadManagerDelegate methods for more information.
 */
@property (nonatomic, weak) id<OOAssetDownloadManagerDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;

/**
 * Initialize a new OOAssetDownloadManager instance with the supplied OOAssetDownloadOptions.
 *
 * @param options Must not be null and all values are required.
 * @returns new OOAssetDownloadManager instance
 */
- (instancetype)initWithOptions:(OOAssetDownloadOptions *)options NS_DESIGNATED_INITIALIZER;

/**
 * Tries to initialize a download task.
 *
 * Calls the downloadTaskStartedWithError: method of OOAssetDownloadManagerDelegate,
 * so you know if the download started correctly.
 */
- (void)startDownload;

/**
 * Stops and deletes the contents of a download in progress.
 *
 * Calls the downloadCompletedAtLocation:withError: method of OOAssetDownloadManagerDelegate.
 */
- (void)cancelDownload;

/**
 * It is the responsability of the consumer of this class to save the location of a downloadable assets. 
 *
 * You should use the downloadManager:downloadCompletedAtLocation:withError: method of the delegate, to know where 
 * the asset was saved.
 *
 * This class method expects to receive a valid location of a download file and will delete the contents.
 *
 * @param location File to delete
 * @returns YES if the file was deleted, NO if an error ocurred or the file didn't exist.
 */
+ (BOOL)deleteAssetAtLocation:(NSURL *)location;

@end
