/**
 * @class      OOEmbeddedSignatureGenerator OOEmbeddedSignatureGenerator.h "OOEmbeddedSignatureGenerator.h"
 * @brief      OOEmbeddedSignatureGenerator
 * @details    OOEmbeddedSignatureGenerator.h in OoyalaSDK
 * @date       12/1/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOSignatureGenerator.h"

/**
 * Default implementation of OOSignatureGenerator which will generate Ooyala API signatures using API secret
 *
 * Note that embedding your API secret into the app is not very secure.
 * To minimize the risk, use read-only API keys if possible.
 * Alternatively, implement your own OOSignatureGenerator and keep the API keys and secrets on server-side.
 */
@interface OOEmbeddedSignatureGenerator : NSObject <OOSignatureGenerator>

/**
 * Initialize an OOEmbeddedSignatureGenerator using the specified secret
 * @param[in] theSecret the secret to generate the signature with
 * @returns the initialized OOEmbeddedSignatureGenerator
 */
- (id)initWithSecret:(NSString *)theSecret;

/**
 * Generate the APIv2/SAS style signature
 * @param[in] data the NSString to create the signature from
 * @returns an NSString containing the signature
 */
- (NSString *)sign:(NSString *)data;

@end
