//
//  OOAssetDownloadOptions.h
//  OoyalaSDK
//
//  Created on 8/9/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//
//  TODO: Ask or figure out how the doc scripts create the docs
//
//  Here is an example on how to instantiate this class:
//  OOAssetDownloadOptions *downloadOptions = [OOAssetDownloadOptions new];
//  downloadOptions.pcode = @"MY_PCODE";
//  downloadOptions.embedCode = @"MY_EMBED_CODE";
//  downloadOptions.domain = [[OOPlayerDomain domainWithString:@"MY_DOMAIN"];
//  downloadOptions.embedTokenGenerator = myEmbedTokenGeneratorInstance;
//  downloadOptions.timeout = 10.0;
//
//  You can then use the OOAssetDownloadOptions instance to create an
//  OOAssetDownloadManager instance.
//

#import <Foundation/Foundation.h>
#import "OOEmbedTokenGenerator.h"

@class OOPlayerDomain;

@interface OOAssetDownloadOptions : NSObject <NSCopying>

/**
 * The Ooyala's account provider code
 */
@property (nonatomic) NSString *pcode;

/**
 * Ooyala's video embed code (asset id)
 */
@property (nonatomic) NSString *embedCode;

/**
 * Ooyala's whitelist domain, e.g. "http://www.ooyala.com/"
 */
@property (nonatomic) OOPlayerDomain *domain;

@property (nonatomic, weak) id<OOEmbedTokenGenerator> embedTokenGenerator;

/**
 * How long to wait, in seconds, for the authorization requests previous to downloading an asset.
 * Note the timeout is applied to every authorization request that happens in the background, so you might
 * wait longer than specified if something is going wrong.
 * Default: 10.0
 */
@property (nonatomic) Float32 timeout;

@end
