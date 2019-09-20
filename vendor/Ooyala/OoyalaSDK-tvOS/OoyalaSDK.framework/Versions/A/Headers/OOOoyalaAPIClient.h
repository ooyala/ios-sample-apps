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
- (nonnull instancetype)initWithPcode:(nonnull NSString *)pcode
                               domain:(nonnull OOPlayerDomain *)domain;

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
- (nonnull instancetype)initWithPcode:(nonnull NSString *)pcode
                               domain:(nonnull OOPlayerDomain *)domain
                  embedTokenGenerator:(nullable id<OOEmbedTokenGenerator>)generator;

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
- (nonnull instancetype)initWithPcode:(nonnull NSString *)pcode
                               domain:(nonnull OOPlayerDomain *)domain
                   secureUrlGenerator:(nullable id<OOSecureURLGenerator>)secureURLGenerator;

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
- (nonnull instancetype)initWithAPIKey:(nonnull NSString *)apiKey
                                secret:(nonnull NSString *)secret
                                 pcode:(nonnull NSString *)pcode
                                domain:(nonnull OOPlayerDomain *)domain;

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
- (nonnull instancetype)initWithAPIKey:(nonnull NSString *)apiKey
                                secret:(nonnull NSString *)secret
                                 pcode:(nonnull NSString *)pcode
                                domain:(nonnull OOPlayerDomain *)domain
                   embedTokenGenerator:(nullable id<OOEmbedTokenGenerator>)generator;

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
- (nonnull instancetype)initWithPcode:(nonnull NSString *)pcode
                               domain:(nonnull OOPlayerDomain *)domain
                  embedTokenGenerator:(nullable id<OOEmbedTokenGenerator>)generator
                   secureUrlGenerator:(nullable id<OOSecureURLGenerator>)secureURLGenerator;


/** @internal
 * Initialize an OOOoyalaAPIClient, able to sign Backlot requests
 * @param playerAPI the initialized OOPlayerAPIClient to use
 * @param secureURLGenerator an initialized instance of OOSecureURLGenerator used for signing Backlot requests
 * @return the initialized OOOoyalaAPIClient
 */
- (nonnull instancetype)initWithPlayerAPIClient:(nonnull OOPlayerAPIClient *)playerAPI
                             secureUrlGenerator:(nullable id<OOSecureURLGenerator>)secureURLGenerator;

/** @internal
 * Initialize an OOOoyalaAPIClient, able to sign Backlot requests
 * @param thePlayerAPIClient the initialized OOPlayerAPIClient to use
 * @return the initialized OOOoyalaAPIClient
 */
- (nonnull instancetype)initWithPlayerAPIClient:(nonnull OOPlayerAPIClient *)thePlayerAPIClient;

/**
 * Asynchronously fetch the content tree for a set of embed codes
 * @param embedCodes an NSArray containing the embed codes to fetch the content tree for
 * @param callback the OOContentTreeCallback to execute when the asynchronous fetch completes
 */
- (void)contentTree:(nonnull NSArray<NSString *> *)embedCodes
           callback:(nonnull OOContentTreeCallback)callback;

/**
 * Asynchronously fetch the content tree for a set of embed codes, with the specified ad set
 * @param embedCodes an NSArray containing the embed codes to fetch the content tree for
 * @param adSetCode an NSString containing the ad set code for the ad set to dynamically assign
 * @param callback the OOContentTreeCallback to execute when the asynchronous fetch completes
 */
- (void)contentTree:(nonnull NSArray<NSString *> *)embedCodes
          adSetCode:(nullable NSString *)adSetCode
           callback:(nonnull OOContentTreeCallback)callback;

/**
 * Asynchronously fetch the content tree for a set of external ids
 * @note: The external ids will not be in the resulting OOContentItem tree. All ContentItems are keyed based on embed code.
 * @param externalIds an NSArray containing the external ids to fetch the content tree for
 * @param callback the OOContentTreeCallback to execute when the asynchronous fetch completes
 */
- (void)contentTreeByExternalIds:(nonnull NSArray *)externalIds
                        callback:(nonnull OOContentTreeCallback)callback;

/**
 * Asynchronously fetch next part of the content tree if content tree is too large
 * Use OOPaginatedParentItem::hasMoreChildren to check if this is needed.
 * @param[in,out] parent the OOPaginatedParentItem to fetch more children for
 * @param callback a block called on return
 */
- (void)contentTreeNext:(nonnull id<OOPaginatedParentItem>)parent
               callback:(nonnull OOContentTreeNextCallback)callback;

/** @internal
 * Get the provider code that this OOOoyalaAPIClient uses
 * @return the provider code this OOOoyalaAPIClient uses
 */
- (nonnull NSString *)pcode;

/** @internal
 * Get the embed domain that this OOOoyalaAPIClient uses
 * @return the embed domain this OOOoyalaAPIClient uses
 */
- (nonnull OOPlayerDomain *)domain;

@end
