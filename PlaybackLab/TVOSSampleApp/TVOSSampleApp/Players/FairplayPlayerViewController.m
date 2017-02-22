//
//  FairplayPlayerViewController.m
//  TVOSSampleApp
//
//  Created by Yi Gu on 6/1/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "FairplayPlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OODebugMode.h>
#import <OoyalaSDK/OOEmbeddedSecureURLGenerator.h>
#import <OoyalaSDK/OOOptions.h>
#import "PlayerSelectionOption.h"

@interface FairplayPlayerViewController () <OOEmbedTokenGenerator>

@property (nonatomic, strong) NSString *embedCode;
@property (nonatomic, strong) NSString *pcode;
@property (nonatomic, strong) NSString *playerDomain;

// required for FairPlay.
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *secret;
// additionaly required if using OPT.
@property (nonatomic, strong) NSString *authorizeHost;
@property (nonatomic, strong) NSString *accountId;

@end

@implementation FairplayPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.pcode = self.option.pcode;
  self.playerDomain = self.option.domain;
  
  self.authorizeHost = @"http://player.ooyala.com";
  
  self.apiKey = @"Fill me in";
  [OODebugMode setDebugMode:LogAndAbort];
  ASSERT( [self.apiKey containsString:self.pcode], @"self.pcode must be the long prefix of self.apiKey." );

  self.secret = @"Fill me in";
  self.accountId = @"Fill me in";
  
  OOOptions *options = [OOOptions new];
  
  // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
  // This is not how this should be implemented in production - In production, you should implement your own OOSecureURLGenerator
  //   which contacts a server of your own, which will help sign the url with the appropriate API Key and Secret
  options.secureURLGenerator = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.secret];
  
  self.player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                               domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] embedTokenGenerator:self
                                              options:options];
  // enable seeking
  self.showsPlaybackControls = YES;
  
  [self.player setEmbedCode:self.option.embedCode];
  [self.player play];
}

- (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback {
  NSMutableDictionary* params = [NSMutableDictionary dictionary];
  
  params[@"account_id"] = self.accountId;
  NSString* uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", self.pcode, [embedCodes componentsJoinedByString:@","]];
  
  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.secret];
  NSURL* embedTokenUrl = [urlGen secureURL:self.authorizeHost uri:uri params:params];
  callback([embedTokenUrl absoluteString]);
}

@end
