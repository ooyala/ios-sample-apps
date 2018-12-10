/**
 * @class      DeviceManagementPlayerViewController DeviceManagementPlayerViewController.m "DeviceManagementPlayerViewController.m"
 * @brief      A Player that demonstrates how to respond to Device Management errors when using DRM-protected content
 * @details    This is a non-runnable sample ViewController that demonstrates how to respond to Device Management notifications
 *  such as when new devices are registered.
 * @date       12/12/14
 * @copyright  Copyright © 2014 Ooyala Inc. All rights reserved.
 */

#import "DeviceManagementPlayerViewController.h"
#import "AdobePassViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>

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

@property (nonatomic) NSString *publicDeviceId;
@property (weak) UIAlertAction *saveAction;

@end

/**
 * This Player will not work without a proper provider configuration which requires DRM-protected content
 * and Device Management.
 */
@implementation DeviceManagementPlayerViewController

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerSimple";

  self.apiKey = @"Fill me in";
  self.secret = @"Fill me in";
  self.accountId = @"Fill me in";
  self.authorizeHost = @"http://player.ooyala.com";

  if (self.playerSelectionOption) {
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    self.pcode = self.playerSelectionOption.pcode;
    self.playerDomain = self.playerSelectionOption.domain;
  } else {
    NSLog(@"There was no PlayerSelectionOption!");
    return nil;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  OOOptions *options = [OOOptions new];
  // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
  // This is not how this should be implemented in production - In production, you should implement your own OOSecureURLGenerator
  //   which contacts a server of your own, which will help sign the url with the appropriate API Key and Secret
  options.secureURLGenerator = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey
                                                                             secret:self.secret];

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                             embedTokenGenerator:self options:options];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

  [NSNotificationCenter.defaultCenter addObserver: self
                                         selector:@selector(notificationReceived:)
                                             name:nil
                                           object:self.ooyalaPlayerViewController.player];

  [self.playerView addSubview:_ooyalaPlayerViewController.view];
  self.ooyalaPlayerViewController.view.frame = self.playerView.bounds;
  [self addChildViewController:self.ooyalaPlayerViewController];

  [self.ooyalaPlayerViewController.player setEmbedCode:@"h0NGNxczpVZm5WeI-iwEHGgGcCoipQJy"];
  [self.ooyalaPlayerViewController.player play];
}

- (void)notificationReceived:(NSNotification *)notification {
  CMTimeRange r = [self.ooyalaPlayerViewController.player seekableTimeRange];
  NSLog(@"Notification Received: %@ - state: %@ -- playhead: %f, duration: %f",
        notification.name,
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

- (void)asyncErrorCheckLastResult {
  // generate a last_result request to check if the error is a device management error
  NSMutableURLRequest *request = [self generateGetLastResultRequest];
  NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:request
                                                                 completionHandler:^(NSData * _Nullable data,
                                                                                     NSURLResponse * _Nullable response,
                                                                                     NSError * _Nullable error) {
    NSLog(@"Response from last_result to check reason for error: %@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);

    if (!error && [(NSHTTPURLResponse *)response statusCode] == 200) {
      NSDictionary *responseDictionary =
      [NSJSONSerialization JSONObjectWithData:data
                                      options:NSJSONReadingMutableContainers error:nil];
      NSString *result = responseDictionary[@"result"];

      NSLog(@"Reason for registration failure:%@", result);
    } else if (!error && [(NSHTTPURLResponse *)response statusCode] == 404) {
      NSLog(@"Device registration last result not found");
    } else {
      NSLog(@"Other errors");
    }
  }];
  [dataTask resume];
}

- (void)asyncSuccessCheckLastResult {
  NSMutableURLRequest *request = [self generateGetLastResultRequest];
  NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:request
                                                                 completionHandler:^(NSData * _Nullable data,
                                                                                     NSURLResponse * _Nullable response,
                                                                                     NSError * _Nullable error) {
    NSLog(@"Response from last_result: %@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);

    if (!error && [(NSHTTPURLResponse *)response statusCode] == 200) {
      NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:NSJSONReadingMutableContainers error:nil];
      NSString *result = responseDictionary[@"result"];
      self.publicDeviceId = responseDictionary[@"public_device_id"];

      // if this is a new device, prompt for a nickname
      if ([result isEqualToString:@"new device registered"]) {
        // use main thread to show a popup for the nickname
        dispatch_async(dispatch_get_main_queue(), ^{
          [self showNicknamePromptDialog];
        });
      }
    } else {
      NSLog(@"Last result did not return correctly");
    }
  }];
  [dataTask resume];
}

- (NSMutableURLRequest *)generateGetLastResultRequest {
  NSURL *url = [NSURL URLWithString:[NSString
                                     stringWithFormat:@"http://player.ooyala.com/sas/api/v1/device_management/auth_token/%@/last_result",
                                     self.ooyalaPlayerViewController.player.authToken]];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                         cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                     timeoutInterval:60.0];
  [request setHTTPMethod:@"GET"];
  return request;
}

- (void)showNicknamePromptDialog {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Nickname"
                                                                           message:@"Please enter a nickname for your new device:"
                                                                    preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action){
    UITextField *textField = alertController.textFields[0];
    NSString *nickname = textField.text;
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

    [[NSURLSession.sharedSession dataTaskWithRequest:request] resume];
  }];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
    [alertController dismissViewControllerAnimated:YES completion:nil];
  }];

  [alertController addAction:okAction];
  [alertController addAction:cancelAction];
  self.saveAction = okAction;
  okAction.enabled = NO;

  [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    textField.placeholder = @"Enter device nickname";
    textField.keyboardType = UIKeyboardTypeDefault;
    [textField addTarget:self action:@selector(textChanged:) forControlEvents:(UIControlEventEditingChanged)];
  }];

  [self presentViewController:alertController animated:YES completion:nil];
}

- (void)textChanged:(UITextField *)sender {
  self.saveAction.enabled = sender.text.length > 0;
}

// to use, add embedTokenGenerator:self to our ViewController alloc above
- (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback {
  NSMutableDictionary* params = [NSMutableDictionary dictionary];
  params[@"account_id"] = self.accountId;  // only used for concurrent streams
  NSString* uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", self.pcode, [embedCodes componentsJoinedByString:@","]];
  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.secret];
  NSURL* embedTokenUrl = [urlGen secureURL:self.authorizeHost uri:uri params:params];
  callback(embedTokenUrl.absoluteString);
}

@end
