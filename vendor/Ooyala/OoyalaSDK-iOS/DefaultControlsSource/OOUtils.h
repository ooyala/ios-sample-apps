/**
 * @class      OOUtils OOUtils.h "OOUtils.h"
 * @brief      OOUtils
 * @details    OOUtils.h in OoyalaSDK
 * @date       11/22/11
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOTBXML.h"
#import "OOJSONKit.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

typedef enum {
  SIMULATOR,
  IPOD,
  IPOD2,
  IPOD3,
  IPOD4,
  IPHONE,
  IPHONE3G,
  IPHONE3GS,
  IPHONE4,
  IPHONE4S,
  IPAD,
  IPAD2,
  IPAD3,
  UNKNOWN
} OODevice;

@interface OOUtils : NSObject

/**
 * Fetch the full current device.
 * @returns an OODevice
 */
+ (OODevice)fullDevice;

/**
 * Check if the JSON object is nil or [NSNull null]
 * @param[in] object the object to check
 * @returns a YES if nil or [NSNull null], NO if not
 */
+ (BOOL)isJSONNil:(NSObject *)object;

/**
 * Check if the NSString is nil, NULL, or empty
 * @param[in] str the NSString to check
 * @returns YES if nil, NULL, or empty, NO if not
 */
+ (BOOL)isStringNilOrEmpty:(NSString *)str;

/**
 * Convert a string in the format HH:MM:SS.sss to milliseconds
 * @param[in] time the string in the format HH:MM:SS.sss
 * @returns a Float64 seconds (with resolution to the millisecond)
 */
+ (Float64)secondsFromTimeString:(NSString *)time;

/**
 * Generate an NSURL from the given parameters
 * @param[in] host the host to use
 * @param[in] uri the URI path to use
 * @param[in] params an NSDictionary containing the key/value pairs for the URI parameters to use
 * @returns an NSURL for the given parameters
 */
+ (NSURL *)urlFromHost:(NSString *)host uri:(NSString *)uri params:(NSDictionary *)params;

/**
 * URL Encode the input string with the given encoding
 * @param[in] str the NSString to URL encode
 * @param[in] encoding the encoding to use
 * @returns a URL Encoded NSString
 */
+ (NSString *)urlEncode:(NSString *)str encoding:(NSStringEncoding)encoding;

/**
 * Generate a string in the format "key1=value1[separator]key2=value2..." from an NSDictionary
 * @param[in] dict the NSDictionary to generate the string from
 * @param[in] separator the separator to use (replaces [separator] in the example)
 * @returns an NSString in the format "key1=value1[separator]key2=value2..."
 */
+ (NSString *)stringFromDictionary:(NSDictionary *)dict withSeparator:(NSString *)separator;

/**
 * Generate a string in the format "key1=value1[separator]key2=value2..." from an NSDictionary
 * @param[in] dict the NSDictionary to generate the string from
 * @param[in] separator the separator to use (replaces [separator] in the example)
 * @param[in] encode Whether or not the result string needs to be encoded
 * @returns an NSString in the format "key1=value1[separator]key2=value2..."
 */
+ (NSString *)stringFromDictionary:(NSDictionary *)dict withSeparator:(NSString *)separator andEncode:(BOOL)encode;

/**
 * Converts the raw json data to an object
 * @param[in] json the raw json data to convert
 * @returns an NSObject (NSDictionary or NSArray) based on the json specified
 */
+ (NSObject *)objectFromJSONData:(NSData *)json;

/**
 * Converts the raw xml to an NSDictionary
 * @param[in] xml the raw xml to convert
 * @returns an NSDictionary based on the xml specified
 */
+ (NSDictionary *)dictionaryFromTBXML:(OOTBXMLElement *)xml;

/**
 * Generate a SHA256 digest from the input string
 * @param[in] data the NSString to create the digest from
 * @param[in] encoding the encoding to use
 * @returns an NSData object containing the raw bytes of the digest
 */
+ (NSData *)sha256Digest:(NSString *)data encoding:(NSStringEncoding)encoding;

/**
 * Generate a base 64 encoded string from the input
 * @param[in] str the NSString to encode
 * @param[in] encoding the encoding to use
 * @returns an NSString containing the base 64 encoded version of the input
 */
+ (NSString *)encodeBase64WithString:(NSString *)str encoding:(NSStringEncoding)encoding;

/**
 * Generate a base 64 encoded string from the input
 * @param[in] data the NSData (raw bytes) to encode
 * @returns an NSString containing the base 64 encoded version of the input
 */
+ (NSString *)encodeBase64WithData:(NSData *)data;

/**
 * Decode a base 64 encoded string
 * @param[in] strBase64 the base 64 string to decode
 * @returns an NSData object containing the raw decoded bytes
 */
+ (NSData *)decodeBase64WithString:(NSString *)strBase64;

/**
 * Decode a base 64 encoded string to an NSString
 * @param[in] strBase64 the base 64 string to decode
 * @param[in] encoding the encoding to use
 * @returns an NSString containing the string representation of the raw decoded bytes
 */
+ (NSString *)decodeBase64ToStringWithString:(NSString *)strBase64 encoding:(NSStringEncoding)encoding;

/**
 * Get a SHA256 encrypted Guid as a Base64 string
 * @returns an NSString containing the base64 string of the SHA256 guid
 */
+ (NSString *)getEncryptedId;

@end
