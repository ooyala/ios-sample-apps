@import Foundation;

/**
 Represents the domain under which Ooyala analytics will be recorded.
 */
@interface OOPlayerDomain : NSObject

@property (nonatomic, readonly, nonnull) NSString *domainString;
@property (nonatomic, readonly, nullable) NSURL *domainURL;

- (nonnull instancetype)init __attribute__((unavailable("Use initWithString: instead")));

+ (nonnull instancetype)domainWithString:(nonnull NSString *)string;
/**
 domainStr must be parseable URL in the form of a string, starting with either http:// or https://.
 */
- (nonnull instancetype)initWithString:(nonnull NSString *)domainStr;

@end
