//
//  OODtoAsset.h
//  OoyalaSDK
//
//  Created on 10/9/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

@import AVFoundation;
@class AVURLAsset;
@class AVMediaSelection;
@class OOAssetDownloadOptions;
@class OOAssetDownloadStream;
@class OOOoyalaError;
@class OOVideo;
@class OOOfflineVideo;

typedef void (^ProgressParameter)(double progress);
typedef void (^FinishParameter)(NSString * _Nonnull relativePath);
typedef void (^ErrorParameter)(OOOoyalaError * _Nullable error);

typedef NS_ENUM(NSInteger, OODtoAssetState) {
  OODtoAssetStateNotDownloaded,
  OODtoAssetStateAuthorizing,
  OODtoAssetStateDownloading,
  OODtoAssetStatePaused,
  OODtoAssetStateDownloaded
};

NS_CLASS_AVAILABLE_IOS(10.0)
/**
 Use this class to manage an offline-downloadable asset.

 @since iOS 10

 \ingroup offline
 */
@interface OODtoAsset : NSObject

/**
 Embed code managed by this OODtoAsset instance.
 It's first initialized when supplying the OOAssetDownloadOptions.
 */
@property (nonatomic, readonly, nonnull) NSString *embedCode;
/**
 Human readable asset name displayed in UI
 */
@property (nonatomic, readonly, nullable) NSString *name;
/**
 OOAssetDownloadOptions set for a specific asset
 */
@property (nonatomic, readonly, nonnull) OOAssetDownloadOptions *options;

@property (nonatomic, nonnull) AVURLAsset *urlAsset;

/**
 AVMediaSelection set for a specific asset (e.g. closed captions).
 */
@property (nonatomic, nullable) AVMediaSelection *mediaSelection;

@property (nonatomic, nullable) NSString *currentDownload;

/**
 NSURL pointing to a local resource with the downloaded asset
 */
@property (nonatomic, readonly, nullable) NSURL *localUrl;
/**
 NSURL pointing to a local resource with the Fairplay key
 */
@property (nonatomic, readonly, nullable) NSURL *fairplayKey;

/**
 State of the asset
 */
@property (nonatomic, readonly) OODtoAssetState state;
/**
 String text of the asset's state
 */
@property (nonatomic, readonly, nonnull) NSString *stateText;

/**
 An instance of OOOfflineVideo for the specific asset if downloaded
 */
@property (nonatomic, readonly, nullable) OOOfflineVideo *offlineVideo;

@property ProgressParameter _Nullable progressClosure;
@property FinishParameter _Nullable finishClosure;
@property ErrorParameter _Nullable errorClosure;

/**
 Flag indicating if download was successful
 */
@property BOOL success;
/**
 Error if exists
 */
@property OOOoyalaError * _Nullable error;

- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Initializes a new OODtoAsset instance with the supplied OOAssetDownloadOptions.

 @param options Must not be null and all values are required.
 @param name Human readable name for the asset
 @return new OODtoAsset instance
 */
- (nonnull instancetype)initWithOptions:(nonnull OOAssetDownloadOptions *)options
                                andName:(nonnull NSString *)name NS_DESIGNATED_INITIALIZER;

/**
 Starts a download of an asset with the progress closure

 @param closure A progress-handling closure
 */
- (void)downloadWithProgressClosure:(nullable ProgressParameter)closure;

/**
 Sets a progress closure for the existing asset

 @param closure A progress-handling closure
 */
- (void)progressWithProgressClosure:(nonnull ProgressParameter)closure;

/**
 Sets a finish closure

 @param closure A relative-path handling closure
 */
- (void)finishWithRelativePath:(nonnull FinishParameter)closure;

/**
 Sets an error closure

 @param closure An error-handling closure
 */
- (void)onErrorWithErrorClosure:(nonnull ErrorParameter)closure;

/**
 Cancels a download of the asset
 */
- (void)cancelDownload;

/**
 Deletes the asset
 */
- (void)deleteAsset;

/**
 Pauses the download of the asset
 */
- (void)pauseDownload;

/**
 Resumes the download of the asset
 */
- (void)resumeDownload;

/**
 Returns an array with the available streams and their information if it is available for the embed code.
 */
- (nullable NSArray<OOAssetDownloadStream *> *)streams;

@end
