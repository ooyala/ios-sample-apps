/**
 * @class      OOPlayerAPIClient OOPlayerAPIClient.h "OOPlayerAPIClient.h"
 * @brief      OOPlayerAPIClient
 * @details    OOPlayerAPIClient.h in OoyalaSDK
 * @date       11/22/11
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOAuthorizableItem.h"
#import "OOPaginatedParentItem.h"
#import "OOCallbacks.h"
#import "OOEmbedTokenGenerator.h"
#import "OOUserInfo.h"

@class OOContentItem;
@class OOOoyalaAPIHelper;
@class OOOoyalaError;
@protocol OOPlayerInfo;
@class OOPlayerDomain;

typedef void (^OOAuthorizeCallback)(OOOoyalaError *error);
typedef void (^OOHeartbeatCallback)(OOOoyalaError *error);

@interface OOPlayerAPIClient : NSObject <NSURLConnectionDelegate> {
@protected
  NSString *pcode;
  NSInteger width;
  NSInteger height;
  NSInteger heartbeatInterval;
}

@property(nonatomic, strong) NSString *pcode; /**< the pcode to use */
@property(nonatomic, strong) OOPlayerDomain *domain; /**< The embed domain */
@property(nonatomic, assign) NSInteger width; /**< the width of the player this API serves */
@property(nonatomic, assign) NSInteger height; /**< the height of the player this API serves */
@property(nonatomic, strong) id<OOEmbedTokenGenerator> embedTokenGenerator;
@property(nonatomic) NSTimeInterval clockOffset;
@property(nonatomic, strong) NSString *authToken;
@property(nonatomic, assign) NSInteger heartbeatInterval;
@property(nonatomic) OOUserInfo *userInfo;
/**
 * Initialize a OOPlayerAPIClient
 * @param[in] thePcode the Partner Code to use (from Backlot)
 * @param[in] theDomain the embed domain
 * @param[in] theGenerator the initialized OOEmbedTokenGenerator to use
 * @returns the initialized OOPlayerAPIClient
 */
- (id)initWithPcode:(NSString *)thePcode
             domain:(OOPlayerDomain *)theDomain
embedTokenGenerator:(id<OOEmbedTokenGenerator>)theGenerator;

/**
 * Authorize an OOAuthorizableItem
 * @param[in,out] item the OOAuthorizableItem to authorize
 * @param[out] error the error if there was any
 * @returns YES if the authorize call succeded (not neccessarily authorized), NO if there were errors
 */
- (BOOL)authorize:(id<OOAuthorizableItem>)item error:(OOOoyalaError **)error;

/**
 * Authorize an OOAuthorizableItem
 * @param[in,out] item the OOAuthorizableItem to authorize
 * @param[in] playerInfo Player capabilities that the asset is being authorized for
 * @param[out] error the error if there was any
 * @returns YES if the authorize call succeded (not neccessarily authorized), NO if there were errors
 */
- (BOOL)authorize:(id<OOAuthorizableItem>)item withPlayerInfo:(id<OOPlayerInfo>)playerInfo error:(OOOoyalaError **)error;

/**
 * Authorize a set of embed codes
 * @param[in] embedCodes an NSArray containing the embed codes to authorize
 * @param[in,out] parent the parent OOAuthorizableItem of the embed codes that are being authorized (nil if you don't want to update the items)
 * @param[out] error the error if there was any
 * @returns YES if the authorize call succeded (not neccessarily authorized), NO if there were errors
 */
- (BOOL)authorizeEmbedCodes:(NSArray *)embedCodes parent:(id<OOAuthorizableItem>)parent error:(OOOoyalaError **)error;

/**
 * Fetch the content tree for a set of embed codes
 * @param[in] embedCodes an NSArray containing the embed codes to fetch the content tree for
 * @param[out] error the error if there was any
 * @returns the root OOContentItem if the content tree exists, nil if not or if there were errors
 */
- (OOContentItem *)contentTree:(NSArray *)embedCodes error:(OOOoyalaError **)error;

/**
 * Fetch the content tree for a set of embed codes
 * @param[in] embedCodes an NSArray containing the embed codes to fetch the content tree for
 * @param[in] adSetCode an NSString containing the ad set code for the ad set to dynamically assign
 * @param[out] error the error if there was any
 * @returns the root OOContentItem if the content tree exists, nil if not or if there were errors
 */
- (OOContentItem *)contentTree:(NSArray *)embedCodes adSetCode:(NSString *)adSetCode error:(OOOoyalaError **)error;

/**
 * Fetch the content tree for a set of external ids
 * @note: The external ids will not be in the resulting OOContentItem tree. All ContentItems are keyed based on embed code.
 * @param[in] externalIds an NSArray containing the external ids to fetch the content tree for
 * @param[out] error the error if there was any
 * @returns the root OOContentItem if the content tree exists, nil if not or if there were errors
 */
- (OOContentItem *)contentTreeByExternalIds:(NSArray *)externalIds error:(OOOoyalaError **)error;

/**
 * Update the content tree for a next token
 * @param[in,out] parent the OOPaginatedParentItem to fetch more children for
 * @param[out] error the error if there was any
 * @returns and NSRange denoting which children were updated. Will return NSNotFound, 0 if an error occurred. Check the error in that case.
 */
- (NSRange)contentTreeNext:(id<OOPaginatedParentItem>)parent error:(OOOoyalaError **)error;

/**
 * Fetch the metadata for a set of embed codes
 * @param[in] item a OOContentItem to update
 * @param[out] error the error if there was any
 * @returns the root dictionary containing the returned metadata response
 */
- (BOOL)fetchMetadataForEmbedCodes:(NSArray *)embedCodes parent:(id<OOAuthorizableItem>)parent error:(OOOoyalaError **)error;

/**
 * Fetch the metadata for an embed code
 * @param[in] item a OOContentItem to update
 * @param[out] error the error if there was any
 * @returns the root dictionary containing the returned metadata response
 */
- (BOOL)fetchMetadata:(OOContentItem *)item error:(OOOoyalaError **)error;

/**
 * Heartbeat an OOAuthorizableItem
 * @param[out] error the error if there was any
 * @returns YES if the heartbeat call succeded (not neccessarily authorized), NO if there were errors
 */
- (BOOL)authorizeHeartbeat:(OOOoyalaError **)error;

//async

/**
 * Asynchronously authorize an OOAuthorizableItem
 * @param[in] item the OOAuthorizableItem to authorize
 * @param[in] callback a block called on return
 * @returns an object that can be passed to OOPlayerAPIClient.cancel: to cancel this request
 */
- (id)authorize:(id<OOAuthorizableItem>)item callback:(OOAuthorizeCallback)callback;

/**
 * Asynchronously authorize an OOAuthorizableItem
 * @param[in] item the OOAuthorizableItem to authorize
 * @param[in] playerInfo Player capabilities that the asset is being authorized for
 * @param[in] callback a block called on return
 * @returns an object that can be passed to OOPlayerAPIClient.cancel: to cancel this request
 */
- (id)authorize:(id<OOAuthorizableItem>)item withPlayerInfo:(id<OOPlayerInfo>)playerInfo callback:(OOAuthorizeCallback)callback;

/**
 * Authorize a set of embed codes
 * @param[in] embedCodes an NSArray containing the embed codes to authorize
 * @param[in,out] parent the OOAuthorizableItem that is the parent of the embed codes to authorize
 * @param[in] callback a block called on return
 * @returns an object that can be passed to OOPlayerAPIClient.cancel: to cancel this request
 */
- (id)authorizeEmbedCodes:(NSArray *)embedCodes parent:(id<OOAuthorizableItem>)parent callback:(OOAuthorizeCallback)callback;

/**
 * Asynchronously fetch the content tree for a set of embed codes
 * @param[in] embedCodes an NSArray containing the embed codes to fetch the content tree for
 * @param[in] callback a block called on return
 * @returns an object that can be passed to OOPlayerAPIClient.cancel: to cancel this request
 */
- (id)contentTree:(NSArray *)embedCodes callback:(OOContentTreeCallback)callback;

/**
 * Asynchronously fetch the content tree for a set of embed codes
 * @param[in] embedCodes an NSArray containing the embed codes to fetch the content tree for
 * @param[in] adSetCode an NSString containing the ad set code for the ad set to dynamically assign
 * @param[in] callback a block called on return
 * @returns an object that can be passed to OOPlayerAPIClient.cancel: to cancel this request
 */
- (id)contentTree:(NSArray *)embedCodes adSetCode:(NSString *)adSetCode callback:(OOContentTreeCallback)callback;

/**
 * Asynchronously fetch the content tree for a set of external ids
 * @note: The external ids will not be in the resulting OOContentItem tree. All ContentItems are keyed based on embed code.
 * @param[in] externalIds an NSArray containing the external ids to fetch the content tree for
 * @param[in] callback a block called on return
 * @returns an object that can be passed to OOPlayerAPIClient.cancel: to cancel this request
 */
- (id)contentTreeByExternalIds:(NSArray *)externalIds callback:(OOContentTreeCallback)callback;

/**
 * Asynchronously update the content tree for a next token
 * @param[in,out] parent the OOPaginatedParentItem to fetch more children for
 * @param[in] callback a block called on return
 * @returns an object that can be passed to OOPlayerAPIClient.cancel: to cancel this request
 */
- (id)contentTreeNext:(id<OOPaginatedParentItem>)parent callback:(OOContentTreeNextCallback)callback;

/**
 * Asynchronously fetch the metadata dictionary for a set of embed codes
 * @param[in] item a OOContentItem to update
 * @param[in] callback a block called on return
 * @returns an object that can be passed to OOPlayerAPIClient.cancel: to cancel this request
 */
- (id)metadata:(OOContentItem *)item callback:(OOMetadataDictionaryFromAPICallback)callback;

/**
 * Cancel an asynchronous task using the Object returned from the asynchronous method
 * @param[in] task the id returned from the asynchronous method to cancel
 */
- (void)cancel:(id)task;

/**
 * Asynchronously authorize heartbeat
 * @param[in] callback a block called on return
 * @returns an object that can be passed to OOPlayerAPIClient.cancel: to cancel this request
 */
- (id) authorizeHeartbeatCallback:(OOHeartbeatCallback) callback;

@end
