#import <Foundation/Foundation.h>

typedef void(^OOEmbedTokenCallback)(NSString *);

/**
 * A protocol that defines how the Ooyala Player can creates Ooyala Player Tokens for OPT-enforced playback
 * \ingroup key
 */
@protocol OOEmbedTokenGenerator <NSObject>
  - (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback;
@end
