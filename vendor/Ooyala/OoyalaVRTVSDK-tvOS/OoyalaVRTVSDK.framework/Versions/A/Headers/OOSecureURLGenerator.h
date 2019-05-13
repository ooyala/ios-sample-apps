@import Foundation;

/**
 @brief A protocol used to request a signed URL for Player API requests
 */
@protocol OOSecureURLGenerator <NSObject>

/**
 Generate the secure URL
 @par
 This method should use one of the following security method to create a complete NSURL:
 @li Create a signature from the parameters (including API Key and Domain, which are not guaranteed to be in params) and a secret
 @param host the hostname for the URL
 @param uri the URI for the URL
 @param params the URI params for the URL (not including any security params that the security method would use)
 @return a secure NSURL created from the parameters using one of the supported security methods
 */
- (nullable NSURL *)secureURLForHost:(nonnull NSString *)host
                                 uri:(nonnull NSString *)uri
                              params:(nullable NSDictionary *)params;

@end
