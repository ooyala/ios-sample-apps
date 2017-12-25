#import <Foundation/Foundation.h>

/**
 * @brief A protocol used to request a signed URL for Player API requests
 */
@protocol OOSecureURLGenerator <NSObject>

/**
 * Generate the secure URL
 * @par
 * This method should use one of the following security method to create a complete NSURL:
 * @li Create a signature from the parameters (including API Key and Domain, which are not guaranteed to be in params) and a secret
 * @param[in] host the hostname for the URL
 * @param[in] uri the URI for the URL
 * @param[in] params the URI params for the URL (not including any security params that the security method would use)
 * @returns a secure NSURL created from the parameters using one of the supported security methods
 */
- (NSURL *)secureURL:(NSString *)host uri:(NSString *)uri params:(NSDictionary *)params;

@end
