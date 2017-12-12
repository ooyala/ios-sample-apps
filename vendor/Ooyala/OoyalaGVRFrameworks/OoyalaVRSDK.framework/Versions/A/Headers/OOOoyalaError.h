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
  OOOoyalaErrorCodeAuthorizationFailed = 0, /**< Authorization Failed */
  OOOoyalaErrorCodeAuthorizationInvalid = 1, /**< Authorization Response invalid */
  OOOoyalaErrorCodeHeartbeatFailed = 2, /**< Heartbeat failed */
  OOOoyalaErrorCodeContentTreeInvalid = 3, /**< Content Tree Response invalid */
  OOOoyalaErrorCodeAuthorizationSignatureInvalid = 4, /**< The signature of the Authorization Response is invalid */
  OOOoyalaErrorCodeContentTreeNextFailed = 5, /**< Content Tree Next failed */
  OOOoyalaErrorCodePlaybackFailed = 6, /**< AVPlayer Failed */
  OOOoyalaErrorCodeAssetNotEncodedForIOS = 7, /**< The asset is not encoded for iOS */
  OOOoyalaErrorCodeInternalIOS = 8, /**< An Internal iOS Error. Check the error property. */
  OOOoyalaErrorCodeMetadataInvalid = 9, /**< Metadata Response invalid */
  OOOoyalaErrorCodeDeviceInvalidAuthToken = 10, /**< During DRM Rights Acquisition, the rights server reported an invalid token */
  OOOoyalaErrorCodeDeviceLimitReached = 11, /**<  During DRM Rights Acquisition, the server reported that the device limit has been reached*/
  OOOoyalaErrorCodeDeviceBindingFailed = 12, /**<  During DRM Rights Acquisition, the server reported that device binding failed */
  OOOoyalaErrorCodeDeviceIdTooLong = 13, /**<  During DRM Rights Acquisition, the server reported the device id was too long */
  OOOoyalaErrorCodeDeviceGenericDrmError = 14, /**< There was some unknown error during the DRM workflow */
  OOOoyalaErrorCodeDrmDownloadFailedError = 15, /**< Failed to download a required file during the DRM workflow */
  OOOoyalaErrorCodeDrmPersonalizationFailedError = 16, /**< Failed to complete device personalization during the DRM workflow */
  OOOoyalaErrorCodeDrmAcquireRightsFailedError = 17, /**< Failed to get rights for asset during the DRM workflow */
  OOOoyalaErrorCodeDiscoveryInvalidParameter = 18, /**< The expected discovery parameters are not provided */
  OOOoyalaErrorCodeDiscoveryNetworkError = 19, /**< The discovery response is not received due to network errors */
  OOOoyalaErrorCodeDiscoveryFailedResponse = 20, /**< The discovery reponse is received and an error occured on server side */
  OOOoyalaErrorCodeNoAvailableStreams = 21, /**< There were no streams available to play */
  OOOoyalaErrorCodePcodeMismatch = 22, /**< Provided PCode does not match embed code owner */
  OOOoyalaErrorCodeDownloadFailed = 23, /**< Download Failed for any reason */
  OOOoyalaErrorCodeDeviceConcurrentStreams = 24, /**< Concurrent streams limit reached */
  OOOoyalaErrorCodeAdvertistingIdFailure = 25, /**< Failed to obtain advertising Id */
  OOOoyalaErrorCodeDiscoveryGetFailure = 26, /**< Failed to get discovery results */
  OOOoyalaErrorCodeDiscoveryPostFailure = 27, /**< Failed to post discovery pins */
  OOOoyalaErrorCodeUnknownError = 28, /**< Unknown error */
  
} OOOoyalaErrorCode;


/**
 * Represents an error in the Ooyala SDK
 * \ingroup key
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
