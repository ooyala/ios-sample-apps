//
//  OOOoyalaErrorCode.h
//  OoyalaSDK
//
//  Created on 7/4/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#ifndef OOOoyalaErrorCode_h
#define OOOoyalaErrorCode_h

@import Foundation;

/**
 Error Codes
 */
typedef NS_ENUM(NSInteger, OOOoyalaErrorCode) {
  OOOoyalaErrorCodeAuthorizationFailed           = 0,   /**< Authorization Failed */
  OOOoyalaErrorCodeAuthorizationInvalid          = 1,   /**< Authorization Response invalid */
  OOOoyalaErrorCodeHeartbeatFailed               = 2,   /**< Heartbeat failed */
  OOOoyalaErrorCodeContentTreeInvalid            = 3,   /**< Content Tree Response invalid */
  OOOoyalaErrorCodeAuthorizationSignatureInvalid = 4,   /**< The signature of the Authorization Response is invalid */
  OOOoyalaErrorCodeContentTreeNextFailed         = 5,   /**< Content Tree Next failed */
  OOOoyalaErrorCodePlaybackFailed                = 6,   /**< AVPlayer Failed */
  OOOoyalaErrorCodeAssetNotEncodedForIOS         = 7,   /**< The asset is not encoded for iOS */
  OOOoyalaErrorCodeInternalIOS                   = 8,   /**< An Internal iOS Error. Check the error property. */
  OOOoyalaErrorCodeMetadataInvalid               = 9,   /**< Metadata Response invalid */
  OOOoyalaErrorCodeDeviceInvalidAuthToken        = 10,  /**< During DRM Rights Acquisition, the rights server reported an invalid token */
  OOOoyalaErrorCodeDeviceLimitReached            = 11,  /**<  During DRM Rights Acquisition, the server reported that the device limit has been reached*/
  OOOoyalaErrorCodeDeviceBindingFailed           = 12,  /**<  During DRM Rights Acquisition, the server reported that device binding failed */
  OOOoyalaErrorCodeDeviceIdTooLong               = 13,  /**<  During DRM Rights Acquisition, the server reported the device id was too long */
  OOOoyalaErrorCodeDeviceGenericDrmError         = 14,  /**< There was some unknown error during the DRM workflow */
  OOOoyalaErrorCodeDrmDownloadFailedError        = 15,  /**< Failed to download a required file during the DRM workflow */
  OOOoyalaErrorCodeDrmPersonalizationFailedError = 16,  /**< Failed to complete device personalization during the DRM workflow */
  OOOoyalaErrorCodeDrmAcquireRightsFailedError   = 17,  /**< Failed to get rights for asset during the DRM workflow */
  OOOoyalaErrorCodeDiscoveryInvalidParameter     = 18,  /**< The expected discovery parameters are not provided */
  OOOoyalaErrorCodeDiscoveryNetworkError         = 19,  /**< The discovery response is not received due to network errors */
  OOOoyalaErrorCodeDiscoveryFailedResponse       = 20,  /**< The discovery reponse is received and an error occured on server side */
  OOOoyalaErrorCodeNoAvailableStreams            = 21,  /**< There were no streams available to play */
  OOOoyalaErrorCodePcodeMismatch                 = 22,  /**< Provided PCode does not match embed code owner */
  OOOoyalaErrorCodeDownloadFailed                = 23,  /**< Download Failed for any reason */
  OOOoyalaErrorCodeDeviceConcurrentStreams       = 24,  /**< Concurrent streams limit reached */
  OOOoyalaErrorCodeAdvertistingIdFailure         = 25,  /**< Failed to obtain advertising Id */
  OOOoyalaErrorCodeDiscoveryGetFailure           = 26,  /**< Failed to get discovery results */
  OOOoyalaErrorCodeDiscoveryPostFailure          = 27,  /**< Failed to post discovery pins */
  OOOoyalaErrorCodePlayerFormatMismatch          = 28,  /**< Player and player content do not correspond */
  OOOoyalaErrorCodeCreateVRPlayerFailed          = 29,  /**< Failed to create VR player. */
  OOOoyalaErrorCodeUnknownError                  = 30,  /**< Unknown error */
  OOOoyalaErrorCodeGeoBlockingError              = 31,  /**< Geo blocking error */
  OOOoyalaErrorCodeEmbedCodeMetadataError        = 32,  /**< Embed Code Metadata error */
  OOOoyalaErrorCodeAdContentError                = 33,  /**< Ad mode content error */
};

// Text
extern NSString *const ooErrorTextDiscoveryMissingPcode;
extern NSString *const ooErrorTextDiscoveryMissingEmbedCode;

extern NSString *const ooErrorTextDRMGeneric;
extern NSString *const ooErrorTextGeoBlocking;

extern NSString *const ooErrorTextHeartbeatNil;
extern NSString *const ooErrorTextHeartbeatInvalid;
extern NSString *const ooErrorTextHeartbeatException;

extern NSString *const ooErrorTextAuthorizationNil;
extern NSString *const ooErrorTextAuthorizationInvalid;
extern NSString *const ooErrorTextAuthorizationDoesNotExist;
extern NSString *const ooErrorTextAuthorizationException;
extern NSString *const ooErrorTextAuthorizationNoDownloadableStreams;
extern NSString *const ooErrorTextAuthorizationUnsupportedDRM;

extern NSString *const ooErrorTextContentTreeNil;
extern NSString *const ooErrorTextContentTreeInvalid;
extern NSString *const ooErrorTextContentTreeInvalidNoKey;
extern NSString *const ooErrorTextContentTreeInvalidUnknownContentType;
extern NSString *const ooErrorTextContentTreeException;
extern NSString *const ooErrorTextContentTreeNoValuesForAllExtIds;
extern NSString *const ooErrorTextContentTreeNoToken;
extern NSString *const ooErrorTextContentTreeNoAdditionalChildren;

extern NSString *const ooErrorTextMetadataFailed;
extern NSString *const ooErrorTextMetadataInvalid;
extern NSString *const ooErrorTextMetadataNonZeroErrorCode;
extern NSString *const ooErrorTextMetadataNil;
extern NSString *const ooErrorTextMetadataEmbedCodeNil;
extern NSString *const ooErrorTextPlaybackUnknownError;
extern NSString *const ooErrorTextPlaybackInvalidUrl;
extern NSString *const ooErrorTextPlaybackAssetNotPlayable;
extern NSString *const ooErrorTextPlaybackFailed;
extern NSString *const ooErrorTextPlaybackItemFailed;
extern NSString *const ooErrorTextPlaybackFailedToPlayToEnd;
extern NSString *const ooErrorTextPlaybackCouldNotFetchPlaybackInfo;

extern NSString *const ooErrorTextDTOTaskInitFailed;
extern NSString *const ooErrorTextDTOTaskCancelled;
extern NSString *const ooErrorTextDTOSimulatorNotSupported;
extern NSString *const ooErrorTextDTOMissingEXTXKey;

extern NSString *const ooErrorTextNoAvailableStreams;
extern NSString *const ooErrorTextPcodeMismatch;
extern NSString *const ooErrorTextNotEncodedForIos;

extern NSString *const ooErrorTextSecureNotSuccessful;
extern NSString *const ooErrorTextSecureDRMWorkflowError;
extern NSString *const ooErrorTextSecureRightsAcquisitionUnknownError;
extern NSString *const ooErrorTextSecureRightsAcquisitionInvalidToken;
extern NSString *const ooErrorTextSecureRightsAcquisitionDeviceLimitReached;
extern NSString *const ooErrorTextSecureRightsAcquisitionDeviceBindingFailed;
extern NSString *const ooErrorTextSecureRightsAcquisitionDeviceTooLongID;

#endif /* OOOoyalaErrorCode_h */
