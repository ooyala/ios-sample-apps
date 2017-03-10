/**
 * @class      NPAWOptionalMetadataPlayerViewController NPAWOptionalMetadataPlayerViewController.m "NPAWOptionalMetadataPlayerViewController.m"
 * @brief      A Player that demonstrates NPAW Youbora integration with optional metadata
 * @details    NPAWOptionalMetadataPlayerViewController in Ooyala Sample Apps
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */


#import "NPAWOptionalMetadataPlayerViewController.h"
#import <YouboraMedia/Youbora.h>
#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"

@interface NPAWOptionalMetadataPlayerViewController ()
@property (strong, nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@property NSString *npawSystemId;
@property NSString *npawUserId;
@property (nonatomic, strong) Youbora *youbora;

@end

@implementation NPAWOptionalMetadataPlayerViewController{
    AppDelegate *appDel;
}

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  self.nib = @"PlayerSimple";

    NSLog(@"value of qa mode in FreeWheelPlayerviewController %@", self.qaModeEnabled ? @"YES" : @"NO");
  //NPAW configurations
  self.npawSystemId = @"ooyalaqa";
  self.npawUserId = @"pkArmh";

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
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
    appDel = [[UIApplication sharedApplication] delegate];

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];
    
    // In QA Mode , making textView visible
    if(self.qaModeEnabled==YES){
        self.textView.hidden = NO;
        
    }


  // Get the custom metadata
  NSDictionary *customMetadata = [self generateNpawCustomMetadata];

  // initialize youbora plugin
  self.youbora = [[Youbora alloc] initWithSystemId:self.npawSystemId userID:self.npawUserId playerInstance:player options:customMetadata httpSecure:YES];

  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];

  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

/*
 * Youbora optional parameters
 */
- (NSDictionary*)generateNpawCustomMetadata
{
  NSDictionary *optionsCustomData = @{ @"customData":
                                         @{@"filename": @"Example Custom File Name",
                                           @"content_metadata":
                                             @{@"title": @"Custom Overridden Title", @"genre": @"Custom Genre"},
                                           @"device":
                                             @{@"manufacturer": @"Custom Device Manufacturer"}}
                                    };
  return optionsCustomData;
}

- (void) notificationHandler:(NSNotification*) notification {

  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }

    NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                         [notification name],
                         [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
                         [self.ooyalaPlayerViewController.player playheadTime], appDel.count];
    
    NSLog(@"%@",message);
    
    //In QA Mode , adding notifications to the TextView
    if(self.qaModeEnabled==YES) {
        NSString *string = self.textView.text;
        NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@",string,message];
        [self.textView setText:appendString];
        
    }
    appDel.count++;
}
@end
