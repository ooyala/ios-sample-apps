/**
 * @file       OOOoyalaError.h
 * @class      OOOoyalaError OOOoyalaError.h "OOOoyalaError.h"
 * @brief      OOOoyalaError
 * @details    OOOoyalaError.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * Error Codes
 */
typedef enum {
  OOOoyalaErrorCodeAuthorizationFailed, /**< Authorization Failed */
  OOOoyalaErrorCodeAuthorizationInvalid, /**< Authorization Response invalid */
  OOOoyalaErrorCodeHeartbeatFailed, /**< Heartbeat failed */
  OOOoyalaErrorCodeContentTreeInvalid, /**< Content Tree Response invalid */
  OOOoyalaErrorCodeAuthorizationSignatureInvalid, /**< The signature of the Authorization Response is invalid */
  OOOoyalaErrorCodeContentTreeNextFailed, /**< Content Tree Next failed */
  OOOoyalaErrorCodePlaybackFailed, /**< AVPlayer Failed */
  OOOoyalaErrorCodeAssetNotEncodedForIOS, /**< The asset is not encoded for iOS */
  OOOoyalaErrorCodeInternalIOS, /**< An Internal iOS Error. Check the error property. */
  OOOoyalaErrorCodeMetadataInvalid, /**< Metadata Response invalid */
  OOOoyalaErrorCodeDeviceInvalidAuthToken, /**< During DRM Rights Acquisition, the rights server reported an invalid token */
  OOOoyalaErrorCodeDeviceLimitReached, /**<  During DRM Rights Acquisition, the server reported that the device limit has been reached*/
  OOOoyalaErrorCodeDeviceBindingFailed, /**<  During DRM Rights Acquisition, the server reported that device binding failed */
  OOOoyalaErrorCodeDeviceIdTooLong, /**<  During DRM Rights Acquisition, the server reported the device id was too long */
  OOOoyalaErrorCodeDeviceGenericDrmError, /** < There was some unknown error during the DRM workflow */
} OOOoyalaErrorCode;


/**
 * Represents an error in the Ooyala SDK
 */
@interface OOOoyalaError : NSObject {
@protected
  OOOoyalaErrorCode code;
  NSString *description;
  NSError *error;
}

@property(readonly, nonatomic) OOOoyalaErrorCode code; /**< The OOOoyalaError's code */
@property(readonly, nonatomic, strong) NSString *description; /**< The OOOoyalaError's description */
@property(readonly, nonatomic, strong) NSError *error; /**< The underlying NSError if it exists */

/** @internal
 * Initialize an OOOoyalaError
 * @param[in] theCode the error's code
 * @returns the initialized OOOoyalaError
 */
- (id)initWithCode:(OOOoyalaErrorCode)theCode;

/** @internal
 * Initialize an OOOoyalaError
 * @param[in] theError the NSError to initialize the OOOoyalaError from
 * @returns the initialized OOOoyalaError
 */
- (id)initWithNSError:(NSError *)theError;

/** @internal
 * Initialize an OOOoyalaError
 * @param[in] theError the NSError to initialize the OOOoyalaError from
 * @param[in] theCode the OOOoyalaErrorCode to use
 * @returns the initialized OOOoyalaError
 */
- (id)initWithNSError:(NSError *)theError code:(OOOoyalaErrorCode)theCode;

/** @internal
 * Initialize an OOOoyalaError
 * @param[in] theCode the error's code
 * @param[in] theDescription the error's description
 * @returns the initialized OOOoyalaError
 */
- (id)initWithCode:(OOOoyalaErrorCode)theCode description:(NSString *)theDescription;

/** @internal
 * Create an OOOoyalaError from the given data
 * @param[in] code the OOOoyalaErrorCode of the error
 * @param[in] description the description of the error
 * @returns the created OOOoyalaError
 */
+ (OOOoyalaError *)errorWithCode:(OOOoyalaErrorCode)code description:(NSString *)description;

/** @internal
 * Create an OOOoyalaError from the given NSError
 * @param[in] error the NSError to create the OOOoyalaError from
 * @returns the created OOOoyalaError
 */
+ (OOOoyalaError *)errorWithNSError:(NSError *)error;

/** @internal
 * Create an OOOoyalaError from the given NSError
 * @param[in] error the NSError to create the OOOoyalaError from
 * @param[in] theCode the OOOoyalaErrorCode to use
 * @returns the created OOOoyalaError
 */
+ (OOOoyalaError *)errorWithNSError:(NSError *)error code:(OOOoyalaErrorCode)theCode;

@end
