//
//  OOIQConfiguration.h
//  OoyalaSDK
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "OODeviceInfo.h"

/**
 * \memberof OOOoyalaPlayer
 * The default player ID value: @"ooyala ios player"
 */
extern NSString* const OOIQCONFIGURATION_DEFAULT_PLAYER_ID;
/**
 * \memberof OOIQConfiguration
 * The default analytics.js URL: @"https://analytics.ooyala.com/static/v3/analytics.js"
 */
extern NSString* const OOIQCONFIGURATION_DEFAULT_ANALYTICS_JS_URL;

/**
 * \memberof OOIQConfiguration
 * The default analytics.js request timeout, in seconds: 10
 */
extern int const OOIQCONFIGURATION_DEFAULT_ANALYTICS_JS_TIMEOUT;
/**
 * \memberof OOIQConfiguration
 * The default domain value: nil, which will result in IQ using the domain provided in the OOOoyalaPlayer initializer.
 */
extern NSString* const OOIQCONFIGURATION_DEFAULT_DOMAIN;
/**
 * \memberof OOIQConfiguration
 * The default IQ Analytics endpoint for reporting: @"https://l.ooyala.com/v3/analytics/events"
 */
extern NSString* const OOIQCONFIGURATION_DEFAULT_BACKEND_ENDPOINT_URL;
/**
 * \memberof OOIQConfiguration
 * The default reporting timeout, in seconds: 10
 */
extern int const OOIQCONFIGURATION_DEFAULT_BACKEND_ENDPOINT_TIMEOUT;
/**
 * \memberof OOIQConfiguration
 * The default browser in device information
 */
extern NSString* const OOIQCONFIGURATION_DEFAULT_BROWSER;
/**
 * \memberof OOIQConfiguration
 * The default browser version in device information
 */
extern NSString* const OOIQCONFIGURATION_DEFAULT_BROWSER_VERSION;
/**
 * \memberof OOIQConfiguration
 * The default os in device information
 */
extern NSString* const OOIQCONFIGURATION_DEFAULT_OS;
/**
 * \memberof OOIQConfiguration
 * The default os version in device information
 */
extern NSString* const OOIQCONFIGURATION_DEFAULT_OS_VERSION;
/**
 * \memberof OOIQConfiguration
 * The default device brand in device information
 */
extern NSString* const OOIQCONFIGURATION_DEFAULT_DEVICE_BRAND;
/**
 * \memberof OOIQConfiguration
 * The default model in device information
 */
extern NSString* const OOIQCONFIGURATION_DEFAULT_MODEL;



/**
 * Configurable values for IQ Analytics.
 * Configure by using the default [OOIQConfiguration new], and manually setting any fields you need changed.
 * The default values are defined in the header.
 * \ingroup key
 */

@interface OOIQConfiguration : NSObject
@property (nonatomic) NSString *playerID;     /**< The PlayerID value used in IQ Analytics reporting */
@property (nonatomic) NSString *analyticsJSURL;     /**< The url where Ooyala SDK downloads analytics.js, the IQ Analytics reporting library. */
@property (nonatomic) int analyticsJSRequestTimeout;     /**< The timeout to use when requesting analytics.js, in seconds. */
@property (nonatomic) NSString *domain;     /**< The domain/traffic source url used for IQ Analytics reporting. If null, IQ will use the domain provided in the OOOoyalaPlayer initializer */
@property (nonatomic) NSString *backendEndpointURL;     /**< The analytics endpoint used for reporting. */
@property (nonatomic) int backendEndpointTimeout;     /**< The timeout to use when posting data to the analytics endpoint, in seconds.*/
@property (nonatomic) OODeviceInfo *deviceInfo;     /**< The device info that can be customized. */

@end
