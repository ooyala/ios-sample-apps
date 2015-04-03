/**
 * @class      DeviceManagementPlayerViewController DeviceManagementPlayerViewController.m "DeviceManagementPlayerViewController.m"
 * @brief      A Player that demonstrates how to respond to Device Management errors when using DRM-protected content
 * @details    This is a non-runnable sample ViewController that demonstrates how to respond to Device Management notifications
 *  such as when new devices are registered.
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "DeviceManagementPlayerViewController.h"
#import "AdobePassViewController.h"
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OOooyalaError.h>
#import <OoyalaSDK/OOEmbeddedSecureURLGenerator.h>

@interface DeviceManagementPlayerViewController () <OOEmbedTokenGenerator>
@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@property NSString *apiKey;
@property NSString *secret;
@property NSString *accountId;
@property NSString *authorizeHost;

@property(nonatomic, strong) UIAlertView *nicknameDialog;
@property(nonatomic) NSString *publicDeviceId;
@end

/**
 * This Player will not work without a proper provider configuration which requires DRM-protected content
 * and Device Management.
 */
@implementation DeviceManagementPlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerSimple";
  self.pcode = @"pqdHc6rN2_wYW2z-pOmDqkUmMnI1";
  self.playerDomain = @"http://www.ooyala.com";
  self.apiKey = @"Fill me in";
  self.secret = @"Fill me in";
  self.accountId = @"Fill me in";
  self.authorizeHost = @"http://player.ooyala.com";

  if (self.playerSelectionOption) {
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] embedTokenGenerator:self];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationReceived:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];

  [self.playerView addSubview:_ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];

  [self addChildViewController:self.ooyalaPlayerViewController];
  self.ooyalaPlayerViewController.view.hidden = YES;


  [self.ooyalaPlayerViewController.player setEmbedCode:@"h0NGNxczpVZm5WeI-iwEHGgGcCoipQJy"];
  [self.ooyalaPlayerViewController.player play];

}

- (void) notificationReceived:(NSNotification *)notification {
  CMTimeRange r = [self.ooyalaPlayerViewController.player seekableTimeRange];
  NSLog(@"Notification Received: %@ - state: %@ -- playhead: %f, duration: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime],
        [self.ooyalaPlayerViewController.player duration]);
  CMTimeRangeShow(r);

  // listen to error notifications
  if ([notification.name isEqualToString:OOOoyalaPlayerErrorNotification]) {
    // Widevine-related errors
    if ([self.ooyalaPlayerViewController.player.error.description isEqualToString: @"Widevine EMM Failed"] ||
        [self.ooyalaPlayerViewController.player.error.description isEqualToString: @"Widevine Play Failed"] ||
        [self.ooyalaPlayerViewController.player.error.description isEqualToString: @"Widevine Initialize Failed"]) {
      NSLog(@"Widevine Error: %@", self.ooyalaPlayerViewController.player.error.description);
    } else {
      NSLog(@"Error: %@", self.ooyalaPlayerViewController.player.error.description);
      [self asyncErrorCheckLastResult];

    }
  }
  // listen to a successful license acquisition notification
  if ([notification.name isEqualToString:OOOoyalaplayerLicenseAcquisitionNotification]) {
    // generate a last_result request to check if current device is a new device
    [self asyncSuccessCheckLastResult];
  }
}

-(void) asyncErrorCheckLastResult {
  // generate a last_result request to check if the error is a device management error
  NSMutableURLRequest *request = [self generateGetLastResultRequest];
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  // send an asynchronous request and check for the reason of the error
  [NSURLConnection sendAsynchronousRequest:request
                                     queue:queue
                         completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
                           NSLog(@"Response from last_result to check reason for error: %@",
                                 [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding]);

                           if (error == nil && [(NSHTTPURLResponse *)response statusCode] == 200) {
                             NSDictionary *responseDictionary =
                             [NSJSONSerialization JSONObjectWithData:responseData
                                                             options:NSJSONReadingMutableContainers error:nil];
                             NSString *result = [responseDictionary objectForKey:@"result"];

                             NSLog(@"Reason for registration failure:%@", result);
                           } else if (error == nil && [(NSHTTPURLResponse *)response statusCode] == 404) {
                             NSLog(@"Device registration last result not found");
                           } else {
                             NSLog(@"Other errors");
                           }
                         }];
}


-(void) asyncSuccessCheckLastResult {
  NSMutableURLRequest *request = [self generateGetLastResultRequest];
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  // send an asynchronous request and check the response
  [NSURLConnection sendAsynchronousRequest:request
                                     queue:queue
                         completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
                           NSLog(@"Response from last_result: %@",
                                 [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding]);

                           if (error == nil && [(NSHTTPURLResponse *)response statusCode] == 200) {
                             NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                                options:NSJSONReadingMutableContainers error:nil];
                             NSString *result = [responseDictionary objectForKey:@"result"];
                             self.publicDeviceId = [responseDictionary objectForKey:@"public_device_id"];

                             // if this is a new device, prompt for a nickname
                             if ([result isEqualToString:@"new device registered"]) {
                               // use main thread to show a popup for the nickname
                               dispatch_async(dispatch_get_main_queue(), ^{
                                 self.nicknameDialog = [[UIAlertView alloc]initWithTitle:@"Nickname"
                                                                                 message:@"Please enter a nickname for your new device:"
                                                                                delegate:self
                                                                       cancelButtonTitle:@"Cancel"
                                                                       otherButtonTitles:@"OK", nil];
                                 [self.nicknameDialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
                                 [self.nicknameDialog show];
                               });
                             }
                           }
                           else {
                             NSLog(@"Last result did not return correctly");
                           }
                         }];

}

-(NSMutableURLRequest *)generateGetLastResultRequest {
  NSURL *url = [NSURL URLWithString:[NSString
                                     stringWithFormat:@"http://player.ooyala.com/sas/api/v1/device_management/auth_token/%@/last_result",
                                     self.ooyalaPlayerViewController.player.authToken]];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                         cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                     timeoutInterval:60.0];
  [request setHTTPMethod:@"GET"];
  return request;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  // respond to user's click on nicknameDialog
  NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
  if (alertView == self.nicknameDialog && [buttonTitle isEqualToString:@"OK"]) {
    NSString *nickname = [[alertView textFieldAtIndex:0] text];
    NSLog(@"Nickname Entered: %@", nickname);
    NSLog(@"Public Device Id: %@", self.publicDeviceId);
    NSLog(@"AuthToken: %@", self.ooyalaPlayerViewController.player.authToken);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:
                                       @"http://player.ooyala.com/sas/api/v1/device_management/auth_token/%@/devices/%@",
                                       self.ooyalaPlayerViewController.player.authToken, self.publicDeviceId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"PUT"];
    NSString *params = [NSString stringWithFormat:@"\{\"nickname\":\"%@\"}", nickname];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {}];
  }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
  // textField validation: enable "OK" button only when user enters a nickname
  if (alertView == self.nicknameDialog) {
    NSString *inputText = [[alertView textFieldAtIndex:0] text];
    if( [inputText length] > 0 ) {
      return YES;
    }
    return NO;
  }
  return YES;
}

// to use, add embedTokenGenerator:self to our ViewController alloc above
- (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback {
  NSMutableDictionary* params = [NSMutableDictionary dictionary];
  params[@"account_id"] = self.accountId;  // only used for concurrent streams
  NSString* uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", self.pcode, [embedCodes componentsJoinedByString:@","]];
  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.secret];
  NSURL* embedTokenUrl = [urlGen secureURL:self.authorizeHost uri:uri params:params];
  callback([embedTokenUrl absoluteString]);
}


@end
