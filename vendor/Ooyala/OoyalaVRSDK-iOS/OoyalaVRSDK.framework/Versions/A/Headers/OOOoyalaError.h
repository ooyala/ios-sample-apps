/**
 * @file       OOOoyalaError.h
 * @class      OOOoyalaError OOOoyalaError.h "OOOoyalaError.h"
 * @brief      OOOoyalaError
 * @details    OOOoyalaError.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

@import Foundation;

#import "OOOoyalaErrorCode.h"

/**
 * Represents an error in the Ooyala SDK
 * \ingroup key
 */
@interface OOOoyalaError : NSObject

@property (readonly, nonatomic) OOOoyalaErrorCode code; /**< The OOOoyalaError's code */
@property (readonly, nonatomic) NSString *message; /**< The OOOoyalaError's description */
@property (readonly, nonatomic) NSError *error; /**< The underlying NSError if it exists */
@property (readonly, nonatomic) NSDictionary *userInfo; /**< An optional NSDictionary that has more info about the error */
@property (nonatomic) NSString *failingUrl; /**< A failing URL if present */

/** @internal
 * Initialize an OOOoyalaError
 * @param code the error's code
 * @return the initialized OOOoyalaError
 */
- (instancetype)initWithCode:(OOOoyalaErrorCode)code;

/** @internal
 * Initialize an OOOoyalaError
 * @param error the NSError to initialize the OOOoyalaError from
 * @return the initialized OOOoyalaError
 */
- (instancetype)initWithNSError:(NSError *)error;

/** @internal
 * Initialize an OOOoyalaError
 * @param error the NSError to initialize the OOOoyalaError from
 * @param code the OOOoyalaErrorCode to use
 * @return the initialized OOOoyalaError
 */
- (instancetype)initWithNSError:(NSError *)error
                           code:(OOOoyalaErrorCode)code;

/** @internal
 * Initialize an OOOoyalaError
 * @param code the error's code
 * @param description the error's description
 * @return the initialized OOOoyalaError
 */
- (instancetype)initWithCode:(OOOoyalaErrorCode)code
                 description:(NSString *)description;

/** @internal
 * Initialize an OOOoyalaError
 * @param code the error's code
 * @param description the error's description
 * @param userInfo a dictionary with more information about the error
 * @return the initialized OOOoyalaError
 */
- (instancetype)initWithCode:(OOOoyalaErrorCode)code
                 description:(NSString *)description
                    userInfo:(NSDictionary *)userInfo;

/** @internal
 * Create an OOOoyalaError from the given data
 * @param code the OOOoyalaErrorCode of the error
 * @param description the description of the error
 * @return the created OOOoyalaError
 */
+ (OOOoyalaError *)errorWithCode:(OOOoyalaErrorCode)code
                     description:(NSString *)description;

/** @internal
 * Create an OOOoyalaError from the given NSError
 * @param error the NSError to create the OOOoyalaError from
 * @return the created OOOoyalaError
 */
+ (OOOoyalaError *)errorWithNSError:(NSError *)error;

/** @internal
 * Create an OOOoyalaError from the given NSError
 * @param error the NSError to create the OOOoyalaError from
 * @param code the OOOoyalaErrorCode to use
 * @return the created OOOoyalaError
 */
+ (OOOoyalaError *)errorWithNSError:(NSError *)error
                               code:(OOOoyalaErrorCode)code;

/** @internal
 * Create an OOOoyalaError from the given data
 * @param code the OOOoyalaErrorCode of the error
 * @param description the description of the error
 * @param userInfo a dictionary with more information about the error
 * @return the created OOOoyalaError
 */
+ (OOOoyalaError *)errorWithCode:(OOOoyalaErrorCode)code
                     description:(NSString *)description
                        userInfo:(NSDictionary *)userInfo;

@end
