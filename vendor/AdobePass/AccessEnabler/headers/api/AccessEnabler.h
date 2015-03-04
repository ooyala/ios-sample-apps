#import <Foundation/Foundation.h>
#import "AccessEnablerConstants.h"
#import "EntitlementDelegate.h"

#define MOCK_CONTEXT_COMPONENTS @"mockContextComponents"
#define MOCK_WEB_VIEW @"mockWebView"

@interface AccessEnabler : NSObject {
    id <EntitlementDelegate> delegate;
    
@private
    NSMutableArray *pendingCalls;
    NSMutableArray *pendingAuthorizationsRequests;
    NSMutableDictionary *authorizationRequestCachedStatuses;
    BOOL isAuthenticationTokenCached;
    BOOL isAuthenticatingFlag;
}
 
@property (assign) id <EntitlementDelegate> delegate;

// use this method to initialize the AccessEnabler
- (id) init;

// this initializer is reserved for internal usage only
- (id) initWithAir:(NSString *)sdkVersion;
    
- (void) setRequestor:(NSString *)requestorID setSignedRequestorId:(NSString *)signedRequestorId;
- (void) setRequestor:(NSString *)requestorID setSignedRequestorId:(NSString *)signedRequestorId serviceProviders:(NSArray *)urls;
- (void) checkAuthentication;
- (void) getAuthentication;
- (void) getAuthenticationToken;
- (void) checkAuthorization:(NSString *)resource;
- (void) getAuthorization:(NSString *)resource;
- (void) checkPreauthorizedResources:(NSArray *)resources;
- (void) setSelectedProvider:(NSString *)mvpdID;
- (void) getSelectedProvider;
- (void) getMetadata:(NSDictionary *)key;
- (void) logout;
    

#ifdef UNIT_TEST_MODE
- (void) installMockComponents:(NSDictionary *)components;
- (id) getContext;
- (void) setPassiveAuthenticationTimeout:(double)timeout;
#endif
    
@end
