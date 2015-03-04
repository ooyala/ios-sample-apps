#import <Foundation/Foundation.h>

#import "AuthenticationToken.h"
#import "AuthorizationToken.h"
#import "UserMetadata.h"
#import "Requestor.h"

#define STORAGE_VERSION 5
#define PASTEBOARD_NAME @"AdobePassPasteboard"

#define PASSIVE_AUTHN_COOKIES_KEY @"passiveAuthnCookies"
#define REQUESTOR_BUCKET_KEY @"requestorBucket"
#define CURRENT_MVPD_ID_KEY @"currentMvpdId"
#define TOKEN_MVPD_ID_KEY @"mvpdId"
#define AUTHZ_TOKENS_KEY @"authzTokens"
#define AUTHN_TOKEN_KEY @"authnToken"
#define USER_METADATA_KEY @"userMeta"
#define PRE_AUTHORIZED_RESOURCES_KEY @"preAuthorizedResources"
#define CAN_AUTHENTICATE_KEY @"canAuthenticate"
#define PREVIOUSLY_IMPORTED @"previouslyImported"

@interface StorageManager : NSObject {

@public
    Requestor *currentRequestor;
}

@property (nonatomic, retain) Requestor *currentRequestor;

- (void)readDataFromStorage;

- (void)setCurrentProvider:(NSString *)newMvpdId;
- (NSString *)getCurrentProvider;

- (void)setCanAuthenticate:(BOOL)canAuthenticate;
- (BOOL)canAuthenticate;

- (void)addAuthorizationToken:(AuthorizationToken *)authzToken forResource:(NSString *)resourceId;
- (AuthorizationToken *)getAuthorizationTokenForResource:(NSString *)resourceId;

- (void)setAuthenticationToken:(AuthenticationToken *)authnToken;

- (AuthenticationToken *)getAuthenticationToken:(BOOL)null;
- (AuthenticationToken *)findValidAuthnTokenForRequestor:(Requestor *)requestor mvpd:(NSString *)preferredMvpdId
                                    useAuthnPerReq:(BOOL)authnPerReq searchCurrentBucket:(BOOL)search;

- (void)clearInvalidEntitlementDataAfterEnablingAuthnPerRequestor;

- (void)updateUserMetadata:(UserMetadata *)newUserMetadata;
- (UserMetadata *)getUserMetadata;

- (void)setPreAuthorizedResources:(NSDictionary *)preAuthorizedResourceList;
- (NSDictionary *)getPreAuthorizedResources;

- (void)setPassiveAuthnCookies:(NSArray *)cookies;
- (NSArray *)getPassiveAuthnCookies;

- (void)importPreviousStorageForRequestor:(Requestor *)requestor;

- (void)clearAllForCurrentStorage;
- (void)clearAllStorageVersions;
- (void)sanitizeStorage;

#ifdef UNIT_TEST_MODE
- (id)getPasteboardWithName:(NSString*)name create:(BOOL)create;
#endif

@end