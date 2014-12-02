//
//  ViewController.m
//  DeviceManagementSampleApp
//
//  Created by Shuo Wang on 7/31/13.
//
//

#import "ViewController.h"
#import "OOOoyalaPlayerViewController.h" 
#import "OOOoyalaPlayer.h"
#import "OOEmbeddedSecureURLGenerator.h"
#import "OOOoyalaError.h"
#import "OOPlayerDomain.h"

@interface ViewController ()

@property(nonatomic, strong) UIAlertView *nicknameDialog;
@property(nonatomic) NSString *publicDeviceId;

@end

@implementation ViewController

@synthesize ooyalaPlayerViewController;

NSString *const APIKEY          = @"Fill me in";
NSString *const SECRETKEY       = @"Fill me in";
NSString *const PCODE           = @"Fill me in";
NSString *const PLAYERDOMAIN    = @"http://replaceme.example.com";
NSString *const EMBEDCODE       = @"Fill me in";
NSString *const ACCOUNT_ID      = @"Fill me in";
NSString *const AUTHORIZE_HOST  = @"http://player.ooyala.com";

- (void)viewDidLoad {
  [super viewDidLoad];
  // initialize Ooyala Player
  ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPcode:PCODE
                                                                            domain:[[OOPlayerDomain alloc] initWithString:PLAYERDOMAIN]
                                                               embedTokenGenerator:self];
  [ooyalaPlayerViewController.view setFrame:self.view.bounds];
  [self addChildViewController:ooyalaPlayerViewController];
  [self.view addSubview:ooyalaPlayerViewController.view];
  // add obersevers to receive notifications from Ooyala Player
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(notificationReceived:)
                                               name:nil object:ooyalaPlayerViewController.player];
  // prepare the asset by embedcode
  [ooyalaPlayerViewController.player setEmbedCode:EMBEDCODE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) notificationReceived:(NSNotification *)notification {
  CMTimeRange r = [ooyalaPlayerViewController.player seekableTimeRange];
  NSLog(@"Notification Received: %@ - state: %@ -- playhead: %f, duration: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[ooyalaPlayerViewController.player state]],
        [ooyalaPlayerViewController.player playheadTime],
        [ooyalaPlayerViewController.player duration]);
  CMTimeRangeShow(r);
  // listen to error notifications
  if ([notification.name isEqualToString:OOOoyalaPlayerErrorNotification]) {
    // Widevine-related errors
    if ([ooyalaPlayerViewController.player.error.description isEqualToString: @"Widevine EMM Failed"] ||
        [ooyalaPlayerViewController.player.error.description isEqualToString: @"Widevine Play Failed"] ||
        [ooyalaPlayerViewController.player.error.description isEqualToString: @"Widevine Initialize Failed"]) {
      NSLog(@"Widevine Error: %@", ooyalaPlayerViewController.player.error.description);
    } else {
      // other errors
      NSLog(@"Error: %@", ooyalaPlayerViewController.player.error.description);
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
          NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData
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
  }
  // listen to a successful license acquisition notification
  if ([notification.name isEqualToString:OOOoyalaplayerLicenseAcquisitionNotification]) {
    // generate a last_result request to check if current device is a new device
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
    }];
  }
}

-(NSMutableURLRequest *)generateGetLastResultRequest {
  NSURL *url = [NSURL URLWithString:[NSString
                                     stringWithFormat:@"http://player.ooyala.com/sas/api/v1/device_management/auth_token/%@/last_result",
                                     ooyalaPlayerViewController.player.authToken]];
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
    NSLog(@"AuthToken: %@", ooyalaPlayerViewController.player.authToken);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:
                                       @"http://player.ooyala.com/sas/api/v1/device_management/auth_token/%@/devices/%@",
                                       ooyalaPlayerViewController.player.authToken, self.publicDeviceId]];
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
  params[@"account_id"] = ACCOUNT_ID;  // only used for concurrent streams
  NSString* uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", PCODE, [embedCodes componentsJoinedByString:@","]];
  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:APIKEY secret:SECRETKEY];
  NSURL* embedTokenUrl = [urlGen secureURL:AUTHORIZE_HOST uri:uri params:params];
  callback([embedTokenUrl absoluteString]);
}
@end

