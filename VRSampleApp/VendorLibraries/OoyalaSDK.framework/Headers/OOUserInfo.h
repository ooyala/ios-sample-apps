//
//  OOUserInfo.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This is the UserInfo that is provided from SAS after authorization
 */
@interface OOUserInfo : NSObject

@property(readonly, nonatomic) NSString *accountId; /** The account ID of the authorized user */
@property(readonly, nonatomic) NSString *continent; /** The continent of origin for the authorization*/
@property(readonly, nonatomic) NSString *country; /** The country of origin for the authorization */
@property(readonly, nonatomic) NSString *device; /** The device provided to the Authorization*/
@property(readonly, nonatomic) NSString *domain; /** The domain provided to the Authorization*/
@property(readonly, nonatomic) NSString *ipAddress; /** The IP address of the Authorized user */
@property(readonly, nonatomic) NSString *language; /** The language provided to the Authorization */
@property(readonly, nonatomic) NSString *timezone; /** The Ttimezone of the authorized user */

/**
 * @internal
 * Initializes the userInfo object that is returned from SAS
 * @param[in] config a dictionary of information from SAS.
 * @returns the created OOUserInfo
 */
- (id) initWithDictionary: (NSDictionary *) config;
@end
