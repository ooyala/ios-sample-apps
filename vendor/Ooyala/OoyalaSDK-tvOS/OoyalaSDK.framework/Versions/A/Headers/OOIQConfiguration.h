//
//  OOIQConfiguration.h
//  OoyalaSDK
//

@import Foundation;
@class OODeviceInfo;

/** The default player ID value is @c"ooyala ios player" */
extern NSString *const OOIQCONFIGURATION_DEFAULT_PLAYER_ID;
/** The default @c analytics.js URL is @c"https://analytics.ooyala.com/static/v3/analytics.js" */
extern NSString *const OOIQCONFIGURATION_DEFAULT_ANALYTICS_JS_URL;
/** The default @c analytics.js request timeout in seconds, default is @c 10 */
extern int const OOIQCONFIGURATION_DEFAULT_ANALYTICS_JS_TIMEOUT;
/** The default domain value @c nil, which will result in IQ using the domain provided in the OOOoyalaPlayer initializer. */
extern NSString *const OOIQCONFIGURATION_DEFAULT_DOMAIN;
/**
 The default IQ Analytics endpoint for reporting, default value is
 @c"https://l.ooyala.com/v3/analytics/events"
 */
extern NSString *const OOIQCONFIGURATION_DEFAULT_BACKEND_ENDPOINT_URL;
/** The default reporting timeout in seconds, default is @c 10 */
extern int const OOIQCONFIGURATION_DEFAULT_BACKEND_ENDPOINT_TIMEOUT;
/** The default browser in device information */
extern NSString *const OOIQCONFIGURATION_DEFAULT_BROWSER;
/** The default browser version in device information */
extern NSString *const OOIQCONFIGURATION_DEFAULT_BROWSER_VERSION;
/** The default os in device information */
extern NSString *const OOIQCONFIGURATION_DEFAULT_OS;
/** The default os version in device information */
extern NSString *const OOIQCONFIGURATION_DEFAULT_OS_VERSION;
/** The default device brand in device information */
extern NSString *const OOIQCONFIGURATION_DEFAULT_DEVICE_BRAND;
/** The default model in device information */
extern NSString *const OOIQCONFIGURATION_DEFAULT_MODEL;
/**
 The default network to send analytics data

 @c NO is the default and will use any available (local or wifi)

 @c YES to use wifi network only for sending data
 */
extern BOOL const OOIQCONFIGURATION_DEFAULT_NETWORK_WIFI;

/**
 Configurable values for IQ Analytics.

 Configure by using the default
 @code
 [OOIQConfiguration new]
 @endcode
 and manually setting any fields you need changed.
 The default values are defined in the header.
 */
@interface OOIQConfiguration : NSObject

/** The PlayerID value used in IQ Analytics reporting */
@property (nonatomic) NSString *playerID;
/** The url where Ooyala SDK downloads analytics.js, the IQ Analytics reporting library. */
@property (nonatomic) NSString *analyticsJSURL;
/** The timeout to use when requesting analytics.js, in seconds. */
@property (nonatomic) int analyticsJSRequestTimeout;
/**
 The domain/traffic source url used for IQ Analytics reporting.
 If null, IQ will use the domain provided in the OOOoyalaPlayer initializer
 */
@property (nonatomic) NSString *domain;
/** The analytics endpoint used for reporting. */
@property (nonatomic) NSString *backendEndpointURL;
/** The timeout to use when posting data to the analytics endpoint, in seconds. */
@property (nonatomic) int backendEndpointTimeout;
/** The device info that can be customized. */
@property (nonatomic) OODeviceInfo *deviceInfo;
/** The default network to send analytics data is any available */
@property (nonatomic) BOOL useWifiOnly;

@end
