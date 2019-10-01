/**
 * @file       OOCallbacks.h
 * @headerfile OOCallbacks.h "OOCallbacks.h"
 * @brief      OOCallbacks
 * @details    OOCallbacks.h in OoyalaSDK
 * @date       2/2/12
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

@import Foundation;

#ifndef OoyalaSDK_Callbacks_h
#define OoyalaSDK_Callbacks_h

@class OOVideo;
@class OOOoyalaError;
@class OOContentTree;
@class OOAuthorization;
@class OOMetadata;
@class OOContentTreeEmbedCode;

/**
 The callback called when the current item is changed in an OOOoyalaPlayer

 @param currentItem the new current item
 */
typedef void(^OOCurrentItemChangedCallback)(OOVideo *currentItem);

/**
 The callback used for OOOoyalaAPIClient.contentTree:callback: calls

 @param contentTree an instance of @c OOContentTree fetched from the contentTree call
 @param error the OOOoyalaError if one occurreds
 */
// TODO: replace with OOContentTree
typedef void(^OOContentTreeCallback)(OOContentTree *contentTree, OOOoyalaError *error);

/**
 The callback used for OOOoyalaAPIClient.contentTreeNext:callback: calls

 @param tokenDict a @c OOContentTreeEmbedCode with new children
 @param error the OOOoyalaError if one occurred
 */
typedef void(^OOContentTreeNextCallback)(OOContentTreeEmbedCode *tokenDict, OOOoyalaError *error);

/**
 The callback used for authorization requests

 @param authorization an instance of @c OOAuthorization fetched from the authorization call
 @param error the OOOoyalaError if one occurred
 */
typedef void (^OOAuthorizeCallback)(OOAuthorization *authorization, OOOoyalaError *error);

/**
 The callback used for OOOoyalaAPIClient.metadata:params:callback: calls

 @param metadata an instance of @c OOMetadata fetched from the metadata call
 @param error the OOOoyalaError if one occurred
 */
typedef void(^OOMetadataCallback)(OOMetadata *metadata, OOOoyalaError *error);

/**
 The callback used for OOPaginatedParentItem.fetchMoreChildren: calls.

 @param error an OOOoyalaError denoting what error occurred (nil if no error)
 */
typedef void(^OOFetchMoreChildrenCallback)(OOOoyalaError *error);

/**
 The callback used for heartbeat requests

 @param error the OOOoyalaError if one occurred
 */
typedef void (^OOHeartbeatCallback)(OOOoyalaError *error);

/**
 The calback used for geoblocking check
 
 @param data the NSData returned by the server
 @param response the NSHTTPURLResponse object that provides response metadata, such as HTTP headers and status code
 @param error the NSError object that indicates why the request failed, or nil if the request was successful
 */
typedef void (^OOGeoblockingCallback)(NSData *data, NSHTTPURLResponse *response, NSError *error);

#endif
