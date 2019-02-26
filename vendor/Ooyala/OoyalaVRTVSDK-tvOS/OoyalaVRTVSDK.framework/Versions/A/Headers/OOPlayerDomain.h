@import Foundation;

/**
 * Represents the domain under which Ooyala analytics will be recorded.
 * \ingroup key
 */
@interface OOPlayerDomain : NSObject

+ (instancetype)domainWithString:(NSString *)string;

- (instancetype)init __attribute__((unavailable("Use initWithString: instead")));
/**
 * domainStr must be parseable URL in the form of a string, starting with either http:// or https://.
 */
- (instancetype)initWithString:(NSString *)domainStr;

- (NSString *)asString;

- (NSURL *)asURL;

@end
