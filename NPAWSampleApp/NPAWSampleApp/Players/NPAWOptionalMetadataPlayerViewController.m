/**
 * @class      NPAWOptionalMetadataPlayerViewController NPAWOptionalMetadataPlayerViewController.m "NPAWOptionalMetadataPlayerViewController.m"
 * @brief      A Player that demonstrates NPAW Youbora integration with optional metadata
 * @details    NPAWOptionalMetadataPlayerViewController in Ooyala Sample Apps
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "NPAWOptionalMetadataPlayerViewController.h"

#import <YouboraMedia/Youbora.h>
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>

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

@implementation NPAWOptionalMetadataPlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerSimple";
  self.pcode =@"R2d3I6s06RyB712DN0_2GsQS-R-Y";
  self.playerDomain = @"http://www.ooyala.com";
  self.npawSystemId = @"ooyalaqa";
  self.npawUserId = @"pkArmh";

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
  [super viewDidLoad];

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];


  // Get the custom metadata
  NSDictionary *customMetadata = [self generateNpawCustomMetadata];

  // initialize youbora plugin
  self.youbora = [[Youbora alloc] initWithSystemId:self.npawSystemId userID:self.npawUserId playerInstance:player options:customMetadata];

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

  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime]);
}
@end
