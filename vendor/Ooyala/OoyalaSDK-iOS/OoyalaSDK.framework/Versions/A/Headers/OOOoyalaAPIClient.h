/**
 * @class      OOOoyalaAPIClient OOOoyalaAPIClient.h "OOOoyalaAPIClient.h"
 * @brief      OOOoyalaAPIClient
 * @details    OOOoyalaAPIClient.h in OoyalaSDK
 * @date       1/17/12
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

@import Foundation;

#import "OOCallbacks.h"

@protocol OOSecureURLGenerator;
@protocol OOPaginatedParentItem;
@protocol OOEmbedTokenGenerator;
@class OOPlayerAPIClient;
@class OOContentItem;
@class OOOoyalaError;
@class OOPlayerDomain;

/**
 * Ooyala API client implementation.
 * Used internally by the OOOoyalaPlayer to load content information and metadata.
 * Can be used by the customer app to query Backlot APIs
 */
@interface OOOoyalaAPIClient : NSObject

/**
 * Initialize an OOOoyalaAPIClient with pcode and embed domain
 * @param pcode the Partner Code to use (from Backlot)
 * @param domain the embed domain
 * @return the initialized OOOoyalaAPIClient
 */
- (instancetype)initWithPcode:(NSString *)pcode domain:(OOPlayerDomain *)domain;

/**
 * Initialize an OOOoyalaAPIClient with pcode, embed domain and OOEmbedTokenGenerator.
 *
 * Allows accessing content that is protected by Ooyala Player Tokens.
 *
 * @param pcode the Partner Code to use (from Backlot)
 * @param domain the embed domain
 * @param generator OOEmbedTokenGenerator for creating Ooyala Player Tokens
 * @return the initialized OOOoyalaAPIClient
 */
- (instancetype)initWithPcode:(NSString *)pcode
                       domain:(OOPlayerDomain *)domain
          embedTokenGenerator:(id<OOEmbedTokenGenerator>)generator;

/**
 * Initialize an OOOoyalaAPIClient with pcode, embed domain and OOSecureURLGenerator
 *
 * Allows accessing protected Backlot APIs
 *
 * @param pcode the Partner Code to use (from Backlot)
 * @param domain the embed domain
 * @param secureURLGenerator an initialized instance of OOSecureURLGenerator used for signing Backlot requests
 * @return the initialized OOOoyalaAPIClient
 */
- (instancetype)initWithPcode:(NSString *)pcode
                       domain:(OOPlayerDomain *)domain
           secureUrlGenerator:(id<OOSecureURLGenerator>)secureURLGenerator;

/**
 * Initialize an OOOoyalaAPIClient with pcode, embed domain, API key and secret
 *
 * Allows accessing protected Backlot APIs.
 * Use OOOoyalaAPIClient::initWithPcode:domain:secureUrlGenerator: if you don't want to embed API keys in the app.
 *
 * @param apiKey the API Key to use (from Backlot)
 * @param secret the Secret to use (from Backlot)
 * @param pcode the Partner Code to use (from Backlot)
 * @param domain the embed domain
 * @return the initialized OOOoyalaAPIClient
 */
- (instancetype)initWithAPIKey:(NSString *)apiKey
                        secret:(NSString *)secret
                         pcode:(NSString *)pcode
                        domain:(OOPlayerDomain *)domain;

/**
 * Initialize an OOOoyalaAPIClient with pcode, embed domain, API key and secret and OOEmbedTokenGenerator
 *
 * Allows accessing content that is protected by Ooyala Player Tokens.
 * Allows accessing protected Backlot APIs.
 * Use OOOoyalaAPIClient::initWithPcode:domain:embedTokenGenerator:secureUrlGenerator: if you don't want to embed API keys in the app.
 *
 * @param apiKey the API Key to use (from Backlot)
 * @param secret the Secret to use (from Backlot)
 * @param pcode the Partner Code to use (from Backlot)
 * @param domain the embed domain
 * @param generator the initialized OOEmbedTokenGenerator to use
 * @return the initialized OOOoyalaAPIClient
 */
- (instancetype)initWithAPIKey:(NSString *)apiKey
                        secret:(NSString *)secret
                         pcode:(NSString *)pcode
                        domain:(OOPlayerDomain *)domain
           embedTokenGenerator:(id<OOEmbedTokenGenerator>)generator;

/**
 * Initialize an OOOoyalaAPIClient with pcode, embed domain, OOEmbedTokenGenerator and OOSecureURLGenerator
 *
 * Allows accessing content that is protected by Ooyala Player Tokens.
 * Allows accessing protected Backlot APIs.
 *
 * @param pcode the Partner Code to use (from Backlot)
 * @param domain the embed domain
 * @param generator the initialized OOEmbedTokenGenerator to use
 * @param secureURLGenerator an initialized instance of OOSecureURLGenerator used for signing Backlot requests
 * @return the initialized OOOoyalaAPIClient
 */
- (instancetype)initWithPcode:(NSString *)pcode
                       domain:(OOPlayerDomain *)domain
          embedTokenGenerator:(id<OOEmbedTokenGenerator>)generator
           secureUrlGenerator:(id<OOSecureURLGenerator>)secureURLGenerator;


/** @internal
 * Initialize an OOOoyalaAPIClient, able to sign Backlot requests
 * @param playerAPI the initialized OOPlayerAPIClient to use
 * @param secureURLGenerator an initialized instance of OOSecureURLGenerator used for signing Backlot requests
 * @return the initialized OOOoyalaAPIClient
 */
- (instancetype)initWithPlayerAPIClient:(OOPlayerAPIClient *)playerAPI
                     secureUrlGenerator:(id<OOSecureURLGenerator>)secureURLGenerator;

/** @internal
 * Initialize an OOOoyalaAPIClient, able to sign Backlot requests
 * @param thePlayerAPIClient the initialized OOPlayerAPIClient to use
 * @return the initialized OOOoyalaAPIClient
 */
- (instancetype)initWithPlayerAPIClient:(OOPlayerAPIClient *)thePlayerAPIClient;

/**
 * Asynchronously fetch the content tree for a set of embed codes
 * @param embedCodes an NSArray containing the embed codes to fetch the content tree for
 * @param callback the OOContentTreeCallback to execute when the asynchronous fetch completes
 */
- (void)contentTree:(NSArray<NSString *> *)embedCodes
           callback:(OOContentTreeCallback)callback;

/**
 * Asynchronously fetch the content tree for a set of embed codes, with the specified ad set
 * @param embedCodes an NSArray containing the embed codes to fetch the content tree for
 * @param adSetCode an NSString containing the ad set code for the ad set to dynamically assign
 * @param callback the OOContentTreeCallback to execute when the asynchronous fetch completes
 */
- (void)contentTree:(NSArray<NSString *> *)embedCodes
          adSetCode:(NSString *)adSetCode
           callback:(OOContentTreeCallback)callback;

/**
 * Asynchronously fetch the content tree for a set of external ids
 * @note: The external ids will not be in the resulting OOContentItem tree. All ContentItems are keyed based on embed code.
 * @param externalIds an NSArray containing the external ids to fetch the content tree for
 * @param callback the OOContentTreeCallback to execute when the asynchronous fetch completes
 */
- (void)contentTreeByExternalIds:(NSArray *)externalIds
                        callback:(OOContentTreeCallback)callback;

/**
 * Asynchronously fetch next part of the content tree if content tree is too large
 * Use OOPaginatedParentItem::hasMoreChildren to check if this is needed.
 * @param[in,out] parent the OOPaginatedParentItem to fetch more children for
 * @param callback a block called on return
 */
- (void)contentTreeNext:(id<OOPaginatedParentItem>)parent
               callback:(OOContentTreeNextCallback)callback;

/** @internal
 * Get the provider code that this OOOoyalaAPIClient uses
 * @return the provider code this OOOoyalaAPIClient uses
 */
- (NSString *)pcode;

/** @internal
 * Get the embed domain that this OOOoyalaAPIClient uses
 * @return the embed domain this OOOoyalaAPIClient uses
 */
- (OOPlayerDomain *)domain;

@end
