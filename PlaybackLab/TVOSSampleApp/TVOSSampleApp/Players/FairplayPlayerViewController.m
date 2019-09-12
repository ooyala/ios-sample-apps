//
//  FairplayPlayerViewController.m
//  TVOSSampleApp
//
//  Created on 6/1/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "FairplayPlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OODebugMode.h>
#import <OoyalaSDK/OOEmbeddedSecureURLGenerator.h>
#import <OoyalaSDK/OOOptions.h>
#import "PlayerSelectionOption.h"
#import <OOyalaSDK/OOEmbedTokenGenerator.h>

@interface FairplayPlayerViewController () <OOEmbedTokenGenerator>

@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;

// required for FairPlay.
@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *secret;
// additionaly required if using OPT.
@property (nonatomic) NSString *authorizeHost;
@property (nonatomic) NSString *accountId;

@end

@implementation FairplayPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.pcode = self.option.pcode;
  self.playerDomain = self.option.domain;
  
  self.authorizeHost = @"http://player.ooyala.com";
  
  self.apiKey = @"Fill me in";
  [OODebugMode setDebugMode:LogAndAbort];
  ASSERT([self.apiKey containsString:self.pcode], @"self.pcode must be the long prefix of self.apiKey.");

  self.secret = @"Fill me in";
  self.accountId = @"Fill me in";
  
  OOOptions *options = [OOOptions new];
  
  // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
  // This is not how this should be implemented in production - In production, you should implement your own OOSecureURLGenerator
  //   which contacts a server of your own, which will help sign the url with the appropriate API Key and Secret
  options.secureURLGenerator = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey
                                                                             secret:self.secret];
  
  self.player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                               domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                  embedTokenGenerator:self
                                              options:options];
  
  [self.player setEmbedCode:self.option.embedCode shouldAutoPlay:YES withCallback:nil];
}

- (void)tokenForEmbedCodes:(NSArray<NSString *> *)embedCodes
                  callback:(OOEmbedTokenCallback)callback {
  NSDictionary *params = @{@"account_id": self.accountId};
  NSString *uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", self.pcode, [embedCodes componentsJoinedByString:@","]];
  
  OOEmbeddedSecureURLGenerator *urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey
                                                                                       secret:self.secret];
  NSURL *embedTokenUrl = [urlGen secureURLForHost:self.authorizeHost uri:uri params:params];
  callback(embedTokenUrl.absoluteString);
}

@end
