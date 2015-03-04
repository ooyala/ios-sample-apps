#import "ServerAPIVersion.h"
#import "ClientVersion.h"

#define SP_AUTH_PRODUCTION  @"sp.auth.adobe.com/adobe-services"
#define SP_AUTH_STAGING     @"sp.auth-staging.adobe.com/adobe-services"

#define DEFAULT_SP_URL SP_AUTH_PRODUCTION

#pragma mark - AdobePass web-service paths
#define SP_URL_DOMAIN_NAME                      @"adobe.com"
#define SP_URL_PATH_SET_REQUESTOR               @"/config/"
#define SP_URL_PATH_GET_AUTHENTICATION          @"/authenticate/saml"
#define SP_URL_PATH_GET_AUTHENTICATION_TOKEN    @"/sessionDevice"
#define SP_URL_PATH_GET_AUTHORIZATION_TOKEN     @"/authorizeDevice"
#define SP_URL_PATH_GET_SHORT_MEDIA_TOKEN       @"/deviceShortAuthorize"
#define SP_URL_PATH_LOGOUT                      @"/logout"
#define SP_URL_PATH_GET_DEVICEID_METADATA       @"/getMetadataDevice"
#define SP_URL_PATH_GET_ENCRYPTED_USER_METADATA @"/usermetadata"
#define SP_URL_IDENTIFIER_PASSIVE_AUTHN         @"/completePassiveAuthentication"

#define SP_URL_PATH_CHECK_PREAUTHZ_RESOURCES    @"/preauthorize"
#define ADOBEPASS_REDIRECT_URL                  @"http://adobepass.ios.app/"

#define CLIENT_TYPE_IOS @"iOS"
#define CLIENT_TYPE_AIR @"AIR_iOS"

#pragma mark - AccessEnabler status codes
#define ACCESS_ENABLER_STATUS_ERROR  0
#define ACCESS_ENABLER_STATUS_SUCCESS  1

#pragma mark - AccessEnabler error codes
#define USER_AUTHENTICATED              @""
#define USER_NOT_AUTHENTICATED_ERROR    @"User Not Authenticated Error"
#define USER_NOT_AUTHORIZED_ERROR       @"User Not Authorized Error"
#define PROVIDER_NOT_SELECTED_ERROR     @"Provider Not Selected Error"
#define GENERIC_AUTHENTICATION_ERROR    @"Generic Authentication Error"
#define GENERIC_AUTHORIZATION_ERROR     @"Generic Authorization Error"
#define SERVER_API_TOO_OLD				@"API Version too old. Please update your application."

#pragma mark - getMetadata operation codes
#define METADATA_AUTHENTICATION     0
#define METADATA_AUTHORIZATION      1
#define METADATA_DEVICE_ID          2
#define METADATA_USER_META          3
#define METADATA_KEY_INVALID        255
#define METADATA_OPCODE_KEY         @"opCode"
#define METADATA_RESOURCE_ID_KEY    @"resource_id"
#define METADATA_USER_META_KEY      @"user_metadata_name"

#pragma mark - sendTrackingData event types
#define TRACKING_AUTHENTICATION         0
#define TRACKING_AUTHORIZATION          1
#define TRACKING_MVPD_SELECTION         2

#pragma mark - sendTrackingData return values
#define TRACKING_NONE  @"None"
#define TRACKING_YES  @"YES"
#define TRACKING_NO   @"NO"
