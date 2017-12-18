//
//  OOConstants.h
//  Pulse
//
//  Created by Joao Sampaio on 30/06/17.
//  Copyright (c) 2017 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const OOCoreVersion;

extern NSString * const OOCoreErrorDomain;
extern NSString * const OOCoreRequestErrorDomain;

enum {
  OOCoreErrorRequestedPassbackBeforeThirdPartyReady      = 1,
  OOCoreErrorRequestedPassbackAfterError                 = 2,
  OOCoreErrorRequestedPassbackAfterImpression            = 3,
  OOCoreErrorRequestedPassbackWhenNoneAvailable          = 4,
  
  OOCoreErrorRequestedExistingInsertionPointTypes        = 5,
  OOCoreErrorRequestedExistingPlaybackPositions          = 6,

  OOCoreErrorInvalidTrackingError                        = 7,
  OOCoreErrorAlreadyTrackedEvent                         = 8,
  OOCoreErrorCannotTrackAfterError                       = 9,
  OOCoreErrorReportedErrorAfterTrackingImpression        = 10,

  OOCoreErrorInvalidTrackable                            = 12,

  OOCoreErrorReceivedInvalidResponse                     = 13,
  OOCoreErrorReceivedInvalidValue                        = 14,
  OOCoreErrorReceivedInvalidAttributeValue               = 15,
  OOCoreErrorReceivedMalformedXML                        = 16,
  OOCoreErrorReceivedInvalidURL                          = 40,
  
  OOCoreErrorMismatchingTags                             = 88,

  OOCoreErrorInvalidValue                                = 17,
  OOCoreErrorLinearPlaybackPositionsIgnored              = 18,
  OOCoreErrorNonLinearPlaybackPositionsIgnored           = 19,

  OOCoreErrorNoAdResponse                                = 20,
  
  // The object is already waiting for a response from a third party
  OOCoreErrorObjectPartOfOngoingRequest                  = 21,
  OOCoreErrorAdNotReady                                  = 22,
  
  OOCoreErrorIllegalOperation                            = 30
};

enum {
  OOCoreRequestErrorUnknown  = -1,
  OOCoreRequestErrorTimedOut = -1001,
  
  // Positive error values correspond to HTTP status codes
};

extern NSString * const OOCoreInvalidURLKey;

extern NSString * const OOCoreExcludedInsertionPointsKey;
extern NSString * const OOCoreExcludedPlaybackPositionsKey;

extern NSString * const OOCoreTrackerEventTypeKey;
extern NSString * const OOCoreTrackerCustomEventNameKey;
extern NSString * const OOCoreTrackerTrackingErrorKey;

extern NSString * const OOCoreValidationInvalidFieldKey;

extern NSString * const OOCoreInternalErrorException;
extern NSString * const OOCoreIllegalOperationException;
