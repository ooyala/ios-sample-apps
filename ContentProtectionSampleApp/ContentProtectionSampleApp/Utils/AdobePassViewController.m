//
//  AdobePassViewController.m
//  ContentProtectionSampleApp
//
//  Created on 5/16/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import "AdobePassViewController.h"
#import "AccessEnabler.h"
#import "EntitlementDelegate.h"
#import "AdobePassUiDelegate.h"
#import "Util.h"
#import "MvpdLoginViewController.h"
#import "MvpdTableViewController.h"

//Object to hold info for callback
@interface TokenRequest:NSObject

@property (nonatomic) NSString *embedCodes;
@property (nonatomic) OOEmbedTokenCallback callback;

- (instancetype)initWithEmbedCodes:(NSString *)theEmbedCodes
                          callback:(OOEmbedTokenCallback)theCallback;
+ (instancetype)tokenRequestWithEmbedCodes:(NSString *)theEmbedCodes
                                  callback:(OOEmbedTokenCallback)theCallback;

@end

@implementation TokenRequest

@synthesize embedCodes, callback;

- (instancetype)initWithEmbedCodes:(NSString *)theEmbedCodes
                          callback:(OOEmbedTokenCallback)theCallback {
  if (self = [super init]) {
    embedCodes = theEmbedCodes;
    callback = theCallback;
  }
  return self;
}

+ (instancetype)tokenRequestWithEmbedCodes:(NSString *)theEmbedCodes
                                  callback:(OOEmbedTokenCallback)theCallback {
  return [[TokenRequest alloc] initWithEmbedCodes:theEmbedCodes callback:theCallback];
}
@end

@interface AdobePassViewController () <EntitlementDelegate, AdobePassUiDelegate>

@property (nonatomic) AccessEnabler *accessEnabler;
@property (nonatomic) UINavigationController *master;
@property (nonatomic) NSString *requestor;
@property (nonatomic) NSString *keystore;
@property (nonatomic) NSString *keypass;
@property (nonatomic) NSMutableDictionary *embedTokenRequests;
@property (nonatomic) BOOL getAuthenticationWasCalled;

- (void)showErrorDialog:(NSString *)error;

@end

@implementation AdobePassViewController

int const PASS_SUCCESS = 1;
int const PASS_FAILURE = 0;

@synthesize accessEnabler, master, requestor, keystore, keypass, embedTokenRequests, delegate;
@synthesize getAuthenticationWasCalled;


- (id)initWithRequestor:(NSString *)_requestor keystore:(NSString *)_keystore keypass:(NSString *)_keypass delegate:_delegate {
  self = [super init];
  if(self) {
    self.getAuthenticationWasCalled = NO;
    requestor = _requestor;
    keystore = _keystore;
    keypass = _keypass;
    delegate = _delegate;
    accessEnabler = [AccessEnabler new];
    accessEnabler.delegate = self;
    embedTokenRequests = [NSMutableDictionary dictionary];
    master = [UINavigationController new];
    NSString *signedReqeustorId = [Util signRequestorId:requestor keystore:keystore pass:keypass];
    
    [accessEnabler setRequestor:requestor
           setSignedRequestorId:signedReqeustorId serviceProviders:@[SP_AUTH_STAGING]];

  }
  return self;
}

- (void)login {
  [accessEnabler getAuthentication];
}

- (void)logout {
  [accessEnabler logout];
  [accessEnabler checkAuthentication];
}

- (void)checkAuth {
  [accessEnabler checkAuthentication];
}

#pragma mark AdobePassUiDelegate methods
- (void)providerSelected:(NSString *)mvpdId {
  [accessEnabler setSelectedProvider:mvpdId];
}

- (void)navigatedBackToApp {
  if (!self.getAuthenticationWasCalled) {
    self.getAuthenticationWasCalled = YES;
    [accessEnabler getAuthenticationToken];
  }
}

#pragma mark AccessEnabler Callbacks

- (void)setRequestorComplete:(int)status {
  if (status == ACCESS_ENABLER_STATUS_ERROR) {
    [self showErrorDialog:@"Error setting requestor"];
  }
}

- (void)displayProviderDialog:(NSArray *)mvpds {
  MvpdTableViewController *mvpdTable = [[MvpdTableViewController alloc] initWithMvpds:mvpds delegate:self];
  [master pushViewController:mvpdTable animated:NO];
  [self presentViewController:master animated:YES completion:nil];
}

- (void)navigateToUrl:(NSString *)url {
  UIViewController *webViewController = [[MvpdLoginViewController alloc] initWithString:url delegate:self];
  [master pushViewController:webViewController animated:YES];
}

- (void) setAuthenticationStatus:(int)status errorCode:(NSString *)code {
  [self dismissViewControllerAnimated:YES completion:nil];
  if (status == ACCESS_ENABLER_STATUS_ERROR &&
      ![code isEqual:USER_NOT_AUTHENTICATED_ERROR] &&
      ![code isEqual:GENERIC_AUTHENTICATION_ERROR]) {
    [self showErrorDialog:@"Could not authenticate"];
  }
  [delegate authChanged:status == ACCESS_ENABLER_STATUS_SUCCESS ? PASS_SUCCESS : PASS_FAILURE];
  self.getAuthenticationWasCalled = NO;
}

- (void)setToken:(NSString *)token forResource:(NSString *)resource {
  TokenRequest *request = (TokenRequest *)[((NSMutableArray *)embedTokenRequests[resource]) lastObject];
  [((NSMutableArray *)embedTokenRequests[resource]) removeLastObject];
  NSString *embedToken = [NSString stringWithFormat:@"/sas/embed_token/pcode/%@?auth_type=adobepass&requestor=%@&token=%@&resource=%@",
                          request.embedCodes,
                          [Util urlEncode:requestor],
                          [Util urlEncode:token],
                          [Util urlEncode:resource]];
  request.callback(embedToken);
}

- (void)tokenRequestFailed:(NSString *)resource errorCode:(NSString *)code errorDescription:(NSString *)description {
  TokenRequest *request = (TokenRequest *)[((NSMutableArray *)embedTokenRequests[resource]) lastObject];
  [((NSMutableArray *)embedTokenRequests[resource]) removeLastObject];
  request.callback(@"");
}

- (void)selectedProvider:(MVPD *)mvpd {}
- (void)sendTrackingData:(NSArray *)data forEventType:(int)event {}
- (void)setMetadataStatus:(NSString *)metadata forKey:(int)key andArguments:(NSDictionary *)arguments {}
- (void)preauthorizedResources:(NSArray *)resources {}

#pragma mark - Ooyala Integration

- (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback {
  //Map embedcodes to actual resource ID here.
  //For now, just use embed code list
  NSString *resource = [embedCodes componentsJoinedByString:@","];

  TokenRequest *request = [TokenRequest tokenRequestWithEmbedCodes:[embedCodes componentsJoinedByString:@","]
                                                          callback:callback];

  if (!embedTokenRequests[resource]) {
    embedTokenRequests[resource] = [[NSMutableArray alloc] initWithArray:@[request]];
  } else {
    [((NSMutableArray *)embedTokenRequests[resource]) insertObject:request atIndex:0];
  }
  [accessEnabler getAuthorization:resource];
}

#pragma mark - Utility

- (void)showErrorDialog:(NSString *)error {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:error
                                                                    preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
    [alertController dismissViewControllerAnimated:YES completion:NULL];
                                                   }];
  [alertController addAction:okButton];
  [self presentViewController:alertController animated:YES completion:nil];
}

@end
