//
//  NotificationsPlayerViewController.m
//  AdvancedPlaybackSampleApp
//
//  Created on 11/16/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import "NotificationsPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"


@interface NotificationsPlayerViewController ()

#pragma mark - Private properties

@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;

@end


@implementation NotificationsPlayerViewController{
  AppDelegate *appDel;
}

#pragma mark - Initialization

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled{
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled];
  self.nib = @"PlayerSimple";
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

#pragma mark - Life cycle

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  // Add self as an observer for the OoyalaPlayer
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];
  
  // In QA Mode , making textView visible
  self.textView.hidden = !self.qaModeEnabled;

  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];
  
  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

/** Handle all notifications from the OoyalaPlayer
 *  Filter on "Note:" in xcode logs to see key points in the notification workflow
 *  Filter on "Notification Received:" in xcode logs to see all notifications in the notification workflow
 */
/** NOTE: there could also be UI-related notifications from your OoyalaPlayerViewController or OOSkinViewController that are not represented here **/
- (void)notificationHandler:(NSNotification*) notification {
  
  // Ignore TimeChanged Notifications for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  
    // Notifications for when Ooyala API requests are completed
  
  } else if ([notification.name isEqualToString:OOOoyalaPlayerEmbedCodeSetNotification]) {
    NSLog(@"Note: The Embed Code has been set, effectively restarting the OoyalaPlayer");
  } else if ([notification.name isEqualToString:OOOoyalaPlayerContentTreeReadyNotification]) {
  } else if ([notification.name isEqualToString:OOOoyalaPlayerAuthorizationReadyNotification]) {
  } else if ([notification.name isEqualToString:OOOoyalaPlayerMetadataReadyNotification]) {
    
    // Notification when the playback starts or completes
  } else if ([notification.name isEqualToString:OOOoyalaPlayerPlayStartedNotification]) {
    NSLog(@"Note: The player has started playback of this asset for the first time");
  } else if ([notification.name isEqualToString:OOOoyalaPlayerPlayCompletedNotification]) {
    NSLog(@"Note: The player has reached the end of the current asset");
  
    // Notification when player has all information from Ooyala APIs
  } else if ([notification.name isEqualToString:OOOoyalaPlayerCurrentItemChangedNotification]) {
    OOVideo *video = self.ooyalaPlayerViewController.player.currentItem;
    NSArray *streams = [video getStreams];
    OOStream *stream;
    if (streams.count > 0) {
      stream = [streams objectAtIndex:0];
    }
  
    NSLog(@"Current Item Changed.  Content ID: %@, Stream URL %@, Stream Type %@", video.embedCode, stream.decodedURL, stream.deliveryType);
    // Notification when the player goes into one of the OoyalaPlayer States
  } else if ([notification.name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
    switch (self.ooyalaPlayerViewController.player.state) {
        /** Initial state, player is created but no content is loaded */
      case OOOoyalaPlayerStateInit:
    
        break;
        /** Loading content */
      case OOOoyalaPlayerStateLoading:
        NSLog(@"Note: Video is buffering");
    
        // See DesiredStateChangedNotification below.
        switch (self.ooyalaPlayerViewController.player.desiredState) {
          case OOOoyalaPlayerDesiredStatePlaying:
            // If in "Loading" state and playing, you can assume that there is unexpected buffering
          case OOOoyalaPlayerDesiredStatePaused:
            break;
        }
    
        break;
        /** Content is loaded and initialized, player is ready to begin playback */
        /** TODO: This state change event is omitted if you "autoplay", or if you queue playback before playback is ready **/
      case OOOoyalaPlayerStateReady:
        NSLog(@"Note: Video is initially ready");
    
        break;
        /** Player is playing a video */
      case OOOoyalaPlayerStatePlaying:
        NSLog(@"Note: Video is now rendering");
    
        break;
        /** Player is paused, video is showing */
      case OOOoyalaPlayerStatePaused:
        NSLog(@"Note: Video is now paused");
    
        break;
        /** Player has finished playing content */
      case OOOoyalaPlayerStateCompleted:
        NSLog(@"Note: Video has been completed");
    
        break;
        /** Player has encountered an error, check OOOoyalaPlayer.error */
        /** NOTE: It's suggested to listen to the Error Notification instead of handling errors here **/
      case OOOoyalaPlayerStateError:
        NSLog(@"Note: Player is now in error state");
        break;
    }
    
      // Notification when the user changes the desired state of playback
  } else if ([notification.name isEqualToString:OOOoyalaPlayerDesiredStateChangedNotification]) {
  
    // Desired state represents what the video player SHOULD be doing.  If the user presses play (or app calls [player play]), this is set to "Playing"
    // If there is no initial [player play], if user clicks pause, or if [player pause] is called, this will be set to "Paused"
    switch (self.ooyalaPlayerViewController.player.desiredState) {
      case OOOoyalaPlayerDesiredStatePlaying:
        NSLog(@"Note: Desired state is playing. After any loading, video should be actively rendering");
        break;
      case OOOoyalaPlayerDesiredStatePaused:
        NSLog(@"Note: Desired state is paused. Video should not be actively rendering while desired state is paused");
        break;
    }
    // Notifications around ad playback
  } else if ([notification.name isEqualToString:OOOoyalaPlayerAdPodStartedNotification]) {
    NSLog(@"Note: An ad manager has taken control of the OoyalaPlayer");
  } else if ([notification.name isEqualToString:OOOoyalaPlayerAdStartedNotification]) {
  } else if ([notification.name isEqualToString:OOOoyalaPlayerAdCompletedNotification]) {
  } else if ([notification.name isEqualToString:OOOoyalaPlayerAdPodCompletedNotification]) {
    NSLog(@"Note: An ad manager has returned control of the OoyalaPlayer");
  } else if ([notification.name isEqualToString:OOOoyalaPlayerAdOverlayNotification]) {
  } else if ([notification.name isEqualToString:OOOoyalaPlayerAdsLoadedNotification]) {
  } else if ([notification.name isEqualToString:OOOoyalaPlayerAdSkippedNotification]) {
  } else if ([notification.name isEqualToString:OOOoyalaPlayerAdTappedNotification]) {
  } else if ([notification.name isEqualToString:OOOoyalaPlayerContentResumedAfterAdNotification]) {
    
    // Notifications around errors
  } else if ([notification.name isEqualToString:OOOoyalaPlayerErrorNotification]) {
    // Error codes names can be found in OOOoyalaError
    NSLog(@"Note: Playback Error: Code: %d, Description: %@", [self.ooyalaPlayerViewController.player.error code], [self.ooyalaPlayerViewController.player.error description]);
  } else if ([notification.name isEqualToString:OOOoyalaPlayerAdErrorNotification]) {
    NSLog(@"Note: Ad Playback Error");
    // Notification when setClosedCaptionsLanguage is called on OoyalaPlayer
  } else if ([notification.name isEqualToString:OOOoyalaPlayerLanguageChangedNotification]) {
    
    // Notifications around Seeking
    // TODO: Seek notifications also fire after midrolls and on video replay.
  } else if ([notification.name isEqualToString:OOOoyalaPlayerSeekStartedNotification]) {
    NSLog(@"Note: Seek Started");
  } else if ([notification.name isEqualToString:OOOoyalaPlayerSeekCompletedNotification]) {
    NSLog(@"Note: Seek Complete");
    
    // Notification when the OoyalaPlayer has gotten Timed Metadata from within the media stream
  } else if ([notification.name isEqualToString:OOOoyalaPlayerJsonReceivedNotification]) {
    
    // Notification when the bitrate changes in media playback
  } else if ([notification.name isEqualToString:OOOoyalaPlayerBitrateChangedNotification]) {
    NSLog(@"Note: Bitrate changed notification received: %f", self.ooyalaPlayerViewController.player.bitrate);
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       [notification name],
                       [OOOoyalaPlayerStateConverter playerStateToString:[self.ooyalaPlayerViewController.player state]],
                       [self.ooyalaPlayerViewController.player playheadTime], appDel.count];
  
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled == YES) {
    NSString *string = self.textView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@" ,string, message];
    [self.textView setText:appendString];
  }
  appDel.count++;
}


@end
