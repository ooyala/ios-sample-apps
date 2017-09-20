#import <Foundation/Foundation.h>

/**
 * @brief A protocol which signs data based on Ooyala signature protocol
 */
@protocol OOSignatureGenerator <NSObject>

/**
 * Generate the APIv2/SAS style signature
 * @par
 * This method should do the following:
 * @li Prepend the secret key to data
 * @li Hash the resulting string using the SHA256 algorithm
 * @li Base64 encode the resulting hash
 * @li Convert the Base64 encoded hash to an NSString
 * @li Truncate the NSString to 43 characters
 * @li Strip any '=' characters from the end of the truncated NSString
 * @li Return the resulting NSString
 * @param[in] data the NSString to create the signature from (not prepended with the secret key)
 * @returns an NSString containing the signature
 */
- (NSString *)sign:(NSString *)data;

@end
