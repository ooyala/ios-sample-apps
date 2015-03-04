//
//  AdobePassViewController.m
//  AdobePassDemoApp
//
//  Created by Chris Leonavicius on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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
@property (nonatomic, strong) NSString *embedCodes;
@property (nonatomic, strong) OOEmbedTokenCallback callback;
- (id)initWithEmbedCodes:(NSString *)_embedCodes callback:(OOEmbedTokenCallback)_callback;
+ (id)tokenRequestWithEmbedCodes:(NSString *)_embedCodes callback:(OOEmbedTokenCallback)_callback;
@end

@implementation TokenRequest
@synthesize embedCodes, callback;
- (id)initWithEmbedCodes:(NSString *)_embedCodes callback:(OOEmbedTokenCallback)_callback {
  self = [super init];
  if (self) {
    embedCodes = _embedCodes;
    callback = _callback;
  }
  return self;
}

+ (id)tokenRequestWithEmbedCodes:(NSString *)_embedCodes callback:(OOEmbedTokenCallback)_callback {
  return [[TokenRequest alloc] initWithEmbedCodes:_embedCodes callback:_callback];
}
@end

@interface AdobePassViewController () <EntitlementDelegate, AdobePassUiDelegate>
@property (nonatomic, strong) AccessEnabler *accessEnabler;
@property (nonatomic, strong) UINavigationController *master;
@property (nonatomic, strong) NSString *requestor;
@property (nonatomic, strong) NSString *keystore;
@property (nonatomic, strong) NSString *keypass;
@property (nonatomic, strong) NSMutableDictionary *embedTokenRequests;
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
    accessEnabler = [[AccessEnabler alloc] init];
    accessEnabler.delegate = self;
    embedTokenRequests = [[NSMutableDictionary alloc] init];
    master = [[UINavigationController alloc] init];
    NSString *signedReqeustorId = [Util signRequestorId:requestor keystore:keystore pass:keypass];
    
    [accessEnabler setRequestor:requestor
           setSignedRequestorId:signedReqeustorId serviceProviders:[NSArray arrayWithObject:SP_AUTH_STAGING]];

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

- (void) setRequestorComplete:(int)status {
  if (status == ACCESS_ENABLER_STATUS_ERROR) {
    [self showErrorDialog:@"Error setting requestor"];
  }
}

- (void) displayProviderDialog:(NSArray *)mvpds {
  
  MvpdTableViewController *mvpdTable = [[MvpdTableViewController alloc] initWithMvpds:mvpds delegate:self];
  [master pushViewController:mvpdTable animated:NO];
  [self presentModalViewController:master animated:YES];
}

- (void) navigateToUrl:(NSString *)url {
  UIViewController *webViewController = [[MvpdLoginViewController alloc] initWithString:url delegate:self];
  [master pushViewController:webViewController animated:YES];
}

- (void) setAuthenticationStatus:(int)status errorCode:(NSString *)code {
  [self dismissModalViewControllerAnimated:YES];
  if (status == ACCESS_ENABLER_STATUS_ERROR && ![code isEqual:USER_NOT_AUTHENTICATED_ERROR] && ![code isEqual:GENERIC_AUTHENTICATION_ERROR]) {
    [self showErrorDialog:@"Could not authenticate"];
  }
  [delegate authChanged:status == ACCESS_ENABLER_STATUS_SUCCESS ? PASS_SUCCESS : PASS_FAILURE];
  self.getAuthenticationWasCalled = NO;
}

- (void) setToken:(NSString *)token forResource:(NSString *)resource {
  TokenRequest *request = (TokenRequest *)[((NSMutableArray *)[embedTokenRequests objectForKey:resource]) lastObject];
  [((NSMutableArray *)[embedTokenRequests objectForKey:resource]) removeLastObject];
  NSString *embedToken = [NSString stringWithFormat:@"/sas/embed_token/pcode/%@?auth_type=adobepass&requestor=%@&token=%@&resource=%@",
                          request.embedCodes,
                          [Util urlEncode:requestor],
                          [Util urlEncode:token],
                          [Util urlEncode:resource]];
  request.callback(embedToken);
}

- (void) tokenRequestFailed:(NSString *)resource errorCode:(NSString *)code errorDescription:(NSString *)description {
  TokenRequest *request = (TokenRequest *)[((NSMutableArray *)[embedTokenRequests objectForKey:resource]) lastObject];
  [((NSMutableArray *)[embedTokenRequests objectForKey:resource]) removeLastObject];
  request.callback(@"");
}

- (void) selectedProvider:(MVPD *)mvpd {
 //do nothing 
}

- (void) sendTrackingData:(NSArray *)data forEventType:(int)event {
  //do nothing
}

- (void) setMetadataStatus:(NSString *)metadata forKey:(int)key andArguments:(NSDictionary *)arguments {
  //do nothing
}

- (void) preauthorizedResources:(NSArray *)resources {
  //do nothing
}

#pragma mark - Ooyala Integration

- (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback {
  //Map embedcodes to actual resource ID here.
  //For now, just use embed code list
  NSString *resource = [embedCodes componentsJoinedByString:@","];

  TokenRequest *request = [TokenRequest tokenRequestWithEmbedCodes:[embedCodes componentsJoinedByString:@","]
                                                          callback:callback];

  if ([embedTokenRequests objectForKey:resource] == nil) {
    [embedTokenRequests setObject:[[NSMutableArray alloc] initWithObjects:request, nil] forKey:resource];
  } else {
    [((NSMutableArray *)[embedTokenRequests objectForKey:resource]) insertObject:request atIndex:0];
  }
  [accessEnabler getAuthorization:resource];
}

#pragma mark - Utility

- (void)showErrorDialog:(NSString *)error {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                  message:error
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
  [alert show];
}

@end
