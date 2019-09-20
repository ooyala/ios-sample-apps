@import Foundation;

/**
 * Authorize response codes
 */
typedef NS_ENUM(NSInteger, OOAuthCode) {
  OOAuthCodeUnknown                     = -2, /**< The authorization code was invalid */
  OOAuthCodeNotRequested                = -1, /**< The authorization has not been requested for this item */
  OOAuthCodeMin                         = 0,  /**< The minimum value for auth codes from the server */
  OOAuthCodeAuthorized                  = 0,  /**< The item is authorized */
  OOAuthCodeUnauthorizedParent          = 1,  /**< The item's parent is unauthorized */
  OOAuthCodeUnauthorizedDomain          = 2,  /**< The item is not authorized for this domain */
  OOAuthCodeUnauthorizedLocation        = 3,  /**< The item is not authorized for this location */
  OOAuthCodeBeforeFlightTime            = 4,  /**< The item has been requested before its flight time */
  OOAuthCodeAfterFlightTime             = 5,  /**< The item has been requested after its flight time */
  OOAuthCodeOutsideRecurringFlightTimes = 6,  /**< The item has been requested outside of its recurring flight time */
  OOAuthCodeBadEmbedCode                = 7,  /**< The item's embed code is invalid */
  OOAuthCodeInvalidSignature            = 8,  /**< The signature of the request is invalid */
  OOAuthCodeMissingParams               = 9,  /**< The request had missing params */
  OOAuthCodeMissingRuleSet              = 10, /**< The server is missing its rule set */
  OOAuthCodeUnauthorized                = 11, /**< The item is unauthorized */
  OOAuthCodeMissingPcode                = 12, /**< The request was missing the pcode */
  OOAuthCodeUnauthorizedDevice          = 13, /**< The item is not authorized for this device */
  OOAuthCodeInvalidToken                = 14, /**< The request's token was invalid */
  OOAuthCodeTokenExpired                = 15, /**< The request's token was expired */
  OOAuthCodeUnauthorizedMultiSyndGroup  = 16,
  OOAuthCodeProviderDeleted             = 17,
  OOAuthCodeTooManyActiveStreams        = 18,
  OOAuthCodeMissingAccountId            = 19,
  OOAuthCodeNoEntitlementsFound         = 20,
  OOAuthCodeNonEntitledDevice           = 21,
  OOAuthCodeNonRegisteredDevice         = 22,
  OOAuthCodeProviderOverCapTrial        = 23,
  OOAuthCodeProxyDetected               = 24,
  OOAuthCodeMax                         = 24  /**< The maximum value for auth codes from the server */
};
extern NSString *OOAuthCodeMessage(OOAuthCode authCode);
