//
//  OOAssetDownloadOptions.h
//  OoyalaSDK
//
//  Created on 8/9/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OOPlayerDomain;

@interface OOAssetDownloadOptions : NSObject <NSCopying>

/**
 * The Ooyala provider code
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

@end
