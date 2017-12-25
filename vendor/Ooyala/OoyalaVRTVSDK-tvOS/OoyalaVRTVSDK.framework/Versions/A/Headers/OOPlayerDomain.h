#import <Foundation/Foundation.h>

/**
 * Represents the domain under which Ooyala analytics will be recorded.
 * \ingroup key
 */
@interface OOPlayerDomain : NSObject
+ (id) domainWithString:(NSString*)string;
- (id) init __attribute__((unavailable("Use initWithString: instead")));
/**
 * domainStr must be parseable URL in the form of a string, starting with either http:// or https://.
 */
- (id) initWithString:(NSString*)domainStr;
- (NSString*)asString;
- (NSURL*)asURL;
@end
