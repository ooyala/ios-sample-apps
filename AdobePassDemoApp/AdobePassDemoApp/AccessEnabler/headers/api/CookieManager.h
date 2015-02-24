#import <Foundation/Foundation.h>

@interface CookieManager : NSObject
    
- (NSString *)getCookiesString:(NSString *)url;
- (NSMutableArray *)serializeCookies;
- (void)updateCookiesBeforeAuthn;

- (NSArray *)extractPassiveAuthnCookies;
- (void)injectPassiveAuthnCookies:(NSArray *)cookies;
- (void)removePassiveAuthnCookies;

- (void)clearCache;

- (NSString *)retrieveAuthnCookiesFromStorage;
- (void)persistAuthnCookiesToStorage;
- (void)removeAuthnCookiesFromStorage;

@end
