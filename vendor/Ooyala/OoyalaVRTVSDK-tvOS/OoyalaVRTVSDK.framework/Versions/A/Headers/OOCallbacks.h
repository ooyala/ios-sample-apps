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
 * The callback called when the current item is changed in an OOOoyalaPlayer
 * @param[in] currentItem the new current item
 */
typedef void(^OOCurrentItemChangedCallback)(OOVideo *currentItem);

/**
 * The callback used for OOOoyalaAPIClient.contentTree:callback: calls
 * @param[in] contentItem the root content item fetched in the contentTree call
 * @param[in] error the OOOoyalaError if one occurreds
 */
typedef void(^OOContentTreeCallback)(OOContentItem *contentItem, OOOoyalaError *error);

/**
 * The callback used for OOOoyalaAPIClient.contentTreeNext:callback: calls
 * @param[in] range the NSRange denoting the new children added
 * @param[in] error the OOOoyalaError if one occurred
 */
typedef void(^OOContentTreeNextCallback)(NSRange range, OOOoyalaError *error);

/**
 * The callback used for OOOoyalaAPIClient.metadata:params:callback: calls
 * @param[in] error the OOOoyalaError if one occurred
 */
typedef void(^OOMetadataDictionaryFromAPICallback)(OOOoyalaError *error);

/**
 * The callback used for OOPaginatedParentItem.fetchMoreChildren: calls.
 * @param[in] range the NSRange denoting the start index of the new children and the number of new children fetched
 * @param[in] error an OOOoyalaError denoting what error occurred (nil if no error)
 */
typedef void(^OOFetchMoreChildrenCallback)(NSRange range, OOOoyalaError *error);

/**
 * The callback used for OOOoyalaAPIClient.objectFromBacklotAPI:params:callback: calls
 * @param[in] object the NSArray or NSDictionary returned from the backlot API
 */
typedef void(^OOObjectFromBacklotAPICallback)(NSObject *object);

/**
 * The callback used for authorization requests
 * @param[in] error the OOOoyalaError if one occurred
 */
typedef void (^OOAuthorizeCallback)(OOOoyalaError *error);

/**
 * The callback used for heartbeat requests
 * @param[in] error the OOOoyalaError if one occurred
 */
typedef void (^OOHeartbeatCallback)(OOOoyalaError *error);

#endif
