//
//  OOAssetDownloadManager.h
//  OoyalaSDK
//
//  Created on 8/2/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.

#import <Foundation/Foundation.h>

@class OOAssetDownloadOptions;
@class OOOoyalaError;
@class OOAssetDownloadManager;

/**
 @protocol OOAssetDownloadManagerDelegate
 
 Implement this protocol and set it as the delegate of OOAssetDownloadManager to receive important information about the download.
 
 \ingroup offline
 */
@protocol OOAssetDownloadManagerDelegate

/**
 This will be called when a download task was started.
 @param manager the OOAssetDownloadManager that called this delegate's method.
 @param error will be nil if the download task was started successfully. Error will have a value when something went wrong.
 */
- (void)downloadManager:(OOAssetDownloadManager *)manager downloadTaskStartedWithError:(OOOoyalaError *)error;

/**
 This will be called when a file was downloaded.
 
 @param manager the OOAssetDownloadManager that called this delegate's method.
 @param location where the asset was saved. This may be nil if an error ocurred.
 @param error will be nil if the download was successful. Error will have a value when something went wrong.
 */
- (void)downloadManager:(OOAssetDownloadManager *)manager downloadCompletedAtLocation:(NSURL *)location withError:(OOOoyalaError *)error;

/**
 Indicates the download progress.
 
 @param manager the OOAssetDownloadManager that called this delegate's method.
 @param percentage value between 0.0 and 1.0, 1.0 being a completed download.
 */
- (void)downloadManager:(OOAssetDownloadManager *)manager downloadPercentage:(Float64)percentage;

/**
 Notifies where a persistent content key for a Fairplay protected asset was saved.
 
 @param manager the OOAssetDownloadManager that called this delegate's method.
 @param location where the key is stored. You should store it yourself so you can delete it later when you want
 to delete the downloaded asset.
 */
- (void)downloadManager:(OOAssetDownloadManager *)manager persistedContentKeyAtLocation:(NSURL *)location;

@end


/**
 Use this class to manage a download for an asset.
 
 @since iOS 10
 
 Here is an example on how to use this class:
 @code
 OOAssetDownloadOptions *options = [OOAssetDownloadOptions new]; 
 // set required properties for this options object
 OOAssetDownloadManager *manager = [[OOAssetDownloadManager alloc] initWithOptions:options];
 downloadManager.delegate = self;
 [downloadManager startDownload];
 @endcode

 The delegate is an implementation of OOAssetDownloadManagerDelegate.
 
 \ingroup offline
 */
NS_CLASS_AVAILABLE_IOS(10.0)
@interface OOAssetDownloadManager : NSObject

/**
 Responds YES if there's a download in progress.
 */
@property (nonatomic, readonly, getter=isDownloadActive) BOOL downloadActive;

/**
 Embed code managed by this OOAssetDownloadManager instance.
 It's first initialized when supplying the OOAssetDownloadOptions.
 */
@property (nonatomic, readonly) NSString *embedCode;

/**
 Calls this delegete when something happened with a download.
 Check the OOAssetDownloadManagerDelegate methods for more information.
 */
@property (nonatomic, weak) id<OOAssetDownloadManagerDelegate> delegate;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
/// @endcond

/**
 Initialize a new OOAssetDownloadManager instance with the supplied OOAssetDownloadOptions.
 
 @param options Must not be null and all values are required.
 @returns new OOAssetDownloadManager instance
 */
- (instancetype)initWithOptions:(OOAssetDownloadOptions *)options NS_DESIGNATED_INITIALIZER;

/**
 Tries to initialize a download task.
 
 Calls the OOAssetDownloadManagerDelegate::downloadTaskStartedWithError: method of OOAssetDownloadManagerDelegate, so you know if the download started correctly.
 */
- (void)startDownload;

/**
 Stops and deletes the contents of a download in progress.
 
 Calls the downloadCompletedAtLocation:withError: method of OOAssetDownloadManagerDelegate.
 */
- (void)cancelDownload;

/**
 It is the responsability of the consumer of this class to save the location of both downloadable assets and it persistent key, in case it is a Fairplay asset.
 
 You should use the downloadManager:downloadCompletedAtLocation:withError: method of the delegate, to know where the asset was saved.
 
 Also, use the downloadManager:persistedContentKeyAtLocation: method of the delegate to know where the Fairplay persistent key was saved.
 
 This class method expects to receive a valid location of a download file and will delete the contents.
 
 @param location NSURL of the file to delete
 @returns YES if the file was deleted, NO if an error ocurred or the file didn't exist.
 */
+ (BOOL)deleteFileAtLocation:(NSURL *)location;

@end
