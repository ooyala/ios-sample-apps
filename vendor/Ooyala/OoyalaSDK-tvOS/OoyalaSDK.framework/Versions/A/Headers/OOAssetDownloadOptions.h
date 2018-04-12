//
//  OOAssetDownloadOptions.h
//  OoyalaSDK
//
//  Created on 8/9/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.

#import <Foundation/Foundation.h>
#import "OOEmbedTokenGenerator.h"
#import "OOAssetLoaderDelegate.h"

@class OOPlayerDomain;

/**
 Options object used to create an OOAssetDownloadManager.
 
 Here is an example on how to instantiate this class:
 @code
 OOAssetDownloadOptions *downloadOptions = [OOAssetDownloadOptions new];
 downloadOptions.pcode = @"MY_PCODE";
 downloadOptions.embedCode = @"MY_EMBED_CODE";
 downloadOptions.domain = [[OOPlayerDomain domainWithString:@"MY_DOMAIN"];
 downloadOptions.embedTokenGenerator = myEmbedTokenGeneratorInstance;
 downloadOptions.timeout = 10.0;
 downloadOptions.minimumBitrate = @(10000);
 @endcode

 You can then use the OOAssetDownloadOptions instance to create an OOAssetDownloadManager instance.
 
 \ingroup offline
 */
@interface OOAssetDownloadOptions : NSObject <NSCopying>

/**
 The Ooyala's account provider code
 */
@property (nonatomic) NSString *pcode;

/**
 Ooyala's video embed code (asset id)
 */
@property (nonatomic) NSString *embedCode;

/**
 Ooyala's whitelist domain, for example: "http://www.ooyala.com/"
 */
@property (nonatomic) OOPlayerDomain *domain;

/**
 Generates an embed token used for OPT (Ooyala Player Token), entitlements, and DRM assets
 */
@property (nonatomic, weak) id<OOEmbedTokenGenerator> embedTokenGenerator;

/**
 How long to wait, in seconds, for the authorization requests previous to downloading an asset.
 Note the timeout is applied to every authorization request that happens in the background, so you might wait longer than specified if something is going wrong.
 Default: 10.0
 */
@property (nonatomic) Float32 timeout;

/**
 The lowest media bitrate greater than or equal to this value will be selected.
 Value should be a NSNumber in bps. If no suitable media bitrate is found, the highest media bitrate will be selected. 
 A negative number or 0, will default to the highest media bitrate.
 */
@property (nonatomic) NSNumber *minimumBitrate;

/**
 When this property is enabled users will be able to download an asset using cellular data, e.g. 4G, LTE, 3G.
 Set it to false (NO) to only allow WiFi to be used.
 By default it is true (YES)
 */
@property (nonatomic) BOOL allowsCellularAccess;

/**
 This property can be used to pass Custom Implementation of AVAssetResourceLoaderDelegate from AVFoundation.
 This SHOULD always be used with fakeURLScheme property available in OOAssetDownloadOptions.
 Note : This only for special purposes. It's NOT recommend to use this property.
        When this property is in use, you CAN NOT use FairPlay.
 */
@property (nonatomic) OOAssetLoaderDelegate *assetLoaderDelegate;

/**
 This property can be used to set a fake URL scheme. For example, it changes "http" or "https" TO "fakeScheme" in the
 'assetLoaderDelegate' property. This SHOULD always be used with 'assetLoaderDelegate' property available in
 OOAssetDownloadOptions.
 Note: This is only for special purposes. It's not recommended to use this property.
 */
@property (nonatomic) NSString *fakeURLScheme;

@end
