@import Foundation;

typedef void(^OOEmbedTokenCallback)(NSString * _Nullable token);

/**
 A protocol that defines how the Ooyala Player can creates Ooyala Player Tokens for OPT-enforced playback
 */
@protocol OOEmbedTokenGenerator <NSObject>

- (void)tokenForEmbedCodes:(nonnull NSArray<NSString *> *)embedCodes
                  callback:(nonnull OOEmbedTokenCallback)callback;

@end
