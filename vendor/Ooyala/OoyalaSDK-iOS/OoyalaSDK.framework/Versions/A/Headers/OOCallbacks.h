/**
 * @file       OOCallbacks.h
 * @headerfile OOCallbacks.h "OOCallbacks.h"
 * @brief      OOCallbacks
 * @details    OOCallbacks.h in OoyalaSDK
 * @date       2/2/12
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#ifndef OoyalaSDK_Callbacks_h
#define OoyalaSDK_Callbacks_h

@class OOVideo;
@class OOContentItem;
@class OOOoyalaError;

/**
 The callback called when the current item is changed in an OOOoyalaPlayer

 @param currentItem the new current item
 */
typedef void(^OOCurrentItemChangedCallback)(OOVideo *currentItem);

/**
 The callback used for OOOoyalaAPIClient.contentTree:callback: calls

 @param contentItem the root content item fetched in the contentTree call
 @param error the OOOoyalaError if one occurreds
 */
typedef void(^OOContentTreeCallback)(OOContentItem *contentItem, OOOoyalaError *error);

/**
 The callback used for OOOoyalaAPIClient.authorizeDownloadForEmbedCode:withPlayerInfo:callback calls

 @param video OOVideo if authorized for offline use
 @param error error if present
 */
typedef void(^OOVideoAuthCallback)(OOVideo *video, OOOoyalaError *error);

/**
 The callback used for OOOoyalaAPIClient.contentTreeNext:callback: calls

 @param range the NSRange denoting the new children added
 @param error the OOOoyalaError if one occurred
 */
typedef void(^OOContentTreeNextCallback)(NSRange range, OOOoyalaError *error);

/**
 The callback used for OOOoyalaAPIClient.metadata:params:callback: calls

 @param error the OOOoyalaError if one occurred
 */
typedef void(^OOMetadataDictionaryFromAPICallback)(OOOoyalaError *error);

/**
 The callback used for OOPaginatedParentItem.fetchMoreChildren: calls.

 @param range the NSRange denoting the start index of the new children and the number of new children fetched
 @param error an OOOoyalaError denoting what error occurred (nil if no error)
 */
typedef void(^OOFetchMoreChildrenCallback)(NSRange range, OOOoyalaError *error);

/**
 The callback used for OOOoyalaAPIClient.objectFromBacklotAPI:params:callback: calls

 @param object the NSArray or NSDictionary returned from the backlot API
 */
typedef void(^OOObjectFromBacklotAPICallback)(NSObject *object);

/**
 The callback used for authorization requests

 @param error the OOOoyalaError if one occurred
 */
typedef void (^OOAuthorizeCallback)(OOOoyalaError *error);

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
