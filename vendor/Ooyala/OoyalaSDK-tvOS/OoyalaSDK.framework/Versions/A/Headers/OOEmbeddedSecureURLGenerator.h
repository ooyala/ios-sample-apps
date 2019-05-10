/**
 @class      OOEmbeddedSecureURLGenerator OOEmbeddedSecureURLGenerator.h "OOEmbeddedSecureURLGenerator.h"
 @brief      OOEmbeddedSecureURLGenerator
 @details    OOEmbeddedSecureURLGenerator.h in OoyalaSDK
 @date       12/1/11
 @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOSecureURLGenerator.h"

@protocol OOSignatureGenerator;
/**
 Default implementation of OOSecureURLGenerator which will generate secured Ooyala API URLs using API key and secret

 Note that embedding your API key and secret into the app is not very secure.
 To minimize the risk, use read-only API keys if possible.
 Alternatively, implement your own OOSignatureGenerator and keep the API keys and secrets on server-side.
 */
@interface OOEmbeddedSecureURLGenerator : NSObject <OOSecureURLGenerator>

@property (nonatomic, nullable) NSString *apiKey; /**< The API Key to use */
@property (nonatomic, nullable) id<OOSignatureGenerator> signatureGenerator; /**< The OOSignatureGenerator to use */

/**
 Initialize an OOEmbeddedSecureURLGenerator
 @param theAPIKey the API Key to use (from Backlot)
 @param theSecret the Secret to use (from Backlot)
 @return the initialized OOEmbeddedSecureURLGenerator
 */
- (nonnull instancetype)initWithAPIKey:(nonnull NSString *)theAPIKey
                                secret:(nonnull NSString *)theSecret;

/**
 Initialize an OOEmbeddedSecureURLGenerator with custom OOSignatureGenerator implementation
 @param theAPIKey the API Key to use (from Backlot)
 @param theSignatureGenerator OOSignatureGenerator to use
 @return the initialized OOEmbeddedSecureURLGenerator
 */
- (nonnull instancetype)initWithAPIKey:(nonnull NSString *)theAPIKey
                    signatureGenerator:(nonnull id<OOSignatureGenerator>)theSignatureGenerator;

@end
