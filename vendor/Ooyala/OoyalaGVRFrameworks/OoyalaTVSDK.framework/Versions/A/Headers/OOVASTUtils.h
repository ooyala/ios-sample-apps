#import <Foundation/Foundation.h>
#import "OOTBXML.h"

/**
 * Various VAST-related utilities
 * \ingroup vast
 */
@interface OOVASTUtils : NSObject
+ (void)setAdvertisingId:(NSString*)adId;
+ (NSString*)advertisingId;
+ (NSURL *)urlFromAdUrlString:(NSString *)url;
+ (void)logErrorCodes: (NSArray *)errorCodes;

+ (BOOL)boolValueForAttribute:(NSString *)attribute
                      element:(OOTBXMLElement *)element
                      default:(BOOL)defaultValue;

+ (NSInteger)intValueForAttribute:(NSString *)attribute
                          element:(OOTBXMLElement *)element
                          default:(NSInteger)defaultValue;

+ (void)parseTrackingEventsWithElement:(OOTBXMLElement *)element
                                  dict:(NSMutableDictionary *)dict;
@end
