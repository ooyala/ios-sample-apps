//
//  BasicEmbedTokenGenerator.h
//  ContentProtectionSampleApp
//
//  Created on 9/1/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <OoyalaSDK/OOEmbedTokenGenerator.h>
/**
 Basic example of an OOEmbedTokenGenerator implementation.
 */
@interface BasicEmbedTokenGenerator : NSObject <OOEmbedTokenGenerator>

@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *apiSecret;
@property (nonatomic) NSString *accountId;
@property (nonatomic) NSString *authorizeHost;

- (instancetype)initWithPcode:(NSString *)pcode
                       apiKey:(NSString *)apiKey
                    apiSecret:(NSString *)apiSecret
                    accountId:(NSString *)accountId
                authorizeHost:(NSString *)authorizeHost;

@end
