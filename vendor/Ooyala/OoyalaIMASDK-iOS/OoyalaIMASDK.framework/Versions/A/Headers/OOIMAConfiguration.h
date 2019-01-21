@import Foundation;

/**
 * Use this to provide configurations to the Ooyala IMA Integration
 *
 * Example:
 *
 * OOIMAConfiguration *config = [OOIMAConfiguration new];
 * config.localeOverride = @"es";
 * config.useDefaultBrowser = NO;
 * self.adsManager = [[OOIMAManager alloc] initWithOoyalaPlayer:player configuration:config];
 *
 */
@interface OOIMAConfiguration : NSObject

@property (nonatomic) NSString *localeOverride; /** Override the locale used in Google IMA.  If left unset, Google will use the first PreferredLanguage provided by iOS */
@property (nonatomic) BOOL useDefaultBrowser; /** Use the default browser like Safari on the mobile device instead of browsing in the native app. */

- (instancetype)init;

@end
