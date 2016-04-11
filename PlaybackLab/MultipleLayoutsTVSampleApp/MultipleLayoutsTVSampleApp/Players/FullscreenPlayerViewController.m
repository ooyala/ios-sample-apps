//
//  FullscreenPlayerViewController.m
//  MultipleLayoutsTVSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "FullscreenPlayerViewController.h"
#import <OoyalaTVSDK/OOOoyalaPlayer.h>
#import <OoyalaTVSDK/OOPlayerDomain.h>
#import <OoyalaTVSDK/OOEmbedTokenGenerator.h>
#import <OoyalaTVSDK/OOEmbeddedSecureURLGenerator.h>
#import "PlayerSelectionOption.h"

@interface FullscreenPlayerViewController () <OOEmbedTokenGenerator>

@property (nonatomic, strong) NSString *pcode;
@property (nonatomic, strong) NSString *playerDomain;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *authorizeHost;

@end

@implementation FullscreenPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.pcode =@"c0cTkxOqALQviQIGAHWY5hP0q9gU";
  self.apiKey = @"<ADD API KEY>";
  self.secret = @"<ADD SECRET>";
  self.authorizeHost = @"http://player.ooyala.com";
  self.playerDomain = @"http://www.ooyala.com";
  
  if (self.option.needsAuthorization) {
    self.player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] embedTokenGenerator:self];
  } else {
    self.player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  }
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:nil object:self.player];
  
  // currently, enables seek backward or forward using remote control left and right
  self.showsPlaybackControls = YES;
  
  if ([self.player setEmbedCode:self.option.embedCode]) {
    [self.player play];
  }
}

- (void)notificationHandler:(NSNotification *)notification
{
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.player state]],
        [self.player playheadTime]);
}

#pragma mark - OOEmbedTokenGenerator

- (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback {
  NSMutableDictionary* params = [NSMutableDictionary dictionary];
  
  NSString* uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", self.pcode, [embedCodes componentsJoinedByString:@","]];
  
  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.secret];
  NSURL* embedTokenUrl = [urlGen secureURL:self.authorizeHost uri:uri params:params];
  callback([embedTokenUrl absoluteString]);
}

@end
