#import <Foundation/Foundation.h>
#import "NSURLConnectionWithTag.h"
#import "AccessEnablerConstants.h"
#import "Requestor.h"
#import "StorageManager.h"
#import "CookieManager.h"
#import "Context.h"

#pragma mark - Connection tags
#define GET_REQUESTOR_TAG 1
#define GET_AUTHENTICATION_TOKEN_TAG 2
#define GET_AUTHORIZATION_TOKEN_TAG 3
#define GET_SHORT_MEDIA_TOKEN_TAG 4
#define GET_DEVICEID_METADATA_TAG 5
#define GET_ENCRYPTED_USER_METADATA_TAG 6
#define GET_STORED_MVPD_TAG 7
#define CHECK_PREAUTHORIZATION_TOKEN_TAG 8

#define MOCK_URL_CONNECTION_WITH_TAG     @"mockUrlConnectionWithTag"

#pragma mark - Callbacks into AccessEnabler
@protocol ConnectionsManagerDelegate <NSObject>

- (void) processSuccessfulInSetRequestor:(Requestor*)localRequestor                           
                            andDeviceInfo:(NSMutableDictionary*)localDeviceInfo;

- (void) processFailInSetRequestor;

- (void) processSuccessGetAuthToken:(AuthenticationToken *)token;
- (void) processFailGetAuthTokenWithErrorCode:(NSString *)errorCode;
- (void) processFailGetAuthToken;

- (void) processSuccessGetAuthorizationToken:(AuthorizationToken *)token andResource:(NSString *)resourceId;
- (void) processFailGetAuthorizationTokenForResource:(NSString *)resourceId withErrorCode:(NSString*)code andDetails:(NSString *)details;

- (void) processSuccessGetShortMediaTokenForResource:(NSString *)resourceId withToken:(NSString*)shortMediaToken;

- (void) processFailGetMetadataDeviceID;
- (void) processSuccessGetMetadataDeviceID:(NSString *)metadata;

- (void) processSuccessGetUserMetadata:(UserMetadata *)metadata;

- (void) processFailGetEncryptedUserMetadata:(NSDictionary*)key;
- (void) processSuccessGetEncryptedUserMetadata:(NSString *)metadata withMetadataInfo:(NSDictionary*)key;

- (void) processSuccessCheckPreauthorization:(NSMutableDictionary *)resourceDic;
- (void) processFailCheckPreauthorization;

@end

@class Context;

@interface ConnectionsManager : NSObject {   
    
    NSMutableDictionary *dataFromConnectionsByID;
    
@private
    Context *context;
    id <ConnectionsManagerDelegate> delegate;
    NSURLConnectionWithTag *urlConnectionWithTag;
    int nrSpUrls;
    NSString *authenticationXML;
    NSMutableData *responseData;
    NSMutableDictionary *httpResposeCodeByID;
    Requestor *requestor;
    NSMutableDictionary *deviceInfo;
    BOOL configDataReceived;
    NSString *airSdkVersion;
    
}

@property (assign) id<ConnectionsManagerDelegate> delegate;
@property (nonatomic, assign) int nrSpUrls;
@property (nonatomic, retain) NSString* airSdkVersion;

- (id) initWithContext:(Context*)aeContext;

#ifdef UNIT_TEST_MODE
- (void)installMockComponents:(NSDictionary *)components;
#endif

#pragma mark - Start connection functions
- (void)startGETConnectionWithTag:(NSNumber *)connectionTag andURL:(NSURL *)url andSpUrl:(NSString *)spUrl;
- (void)startPOSTConnectionForGetAuthenticationWithTag:(NSNumber *)connectionTag andURL:(NSURL *)url withData:(NSDictionary*)data passiveAuthn:(BOOL)passive andCookies:(NSString *)cookies;
- (void)startPOSTConnectionForGetAuthorizationWithTag:(NSNumber *)connectionTag andURL:(NSURL *)url withData:(NSDictionary*)data andCookies:(NSString *)cookies;
- (void)startPOSTConnectionForCheckPreauthorizationWithTag:(NSNumber *)connectionTag andURL:(NSURL *)url withData:(NSDictionary*)data andCookies:(NSString *)cookies;
- (void)startPOSTConnectionForShortMediaTokenWithTag:(NSNumber *)connectionTag andURL:(NSURL *)url withData:(NSDictionary*)data andCookies:(NSString *)cookies;
- (void)startPOSTConnectionForDeviceIdWithTag:(NSNumber *)connectionTag andURL:(NSURL *)url withData:(NSDictionary *)data;
- (void)startPOSTConnectionForEncryptedUserMetadataWithTag:(NSNumber *)connectionTag andURL:(NSURL *)url withData:(NSDictionary *)data metadataInfo:(NSDictionary*)key;

#pragma mark - Parsing methods

@end
