//
//  OoyalaPlayerTokenPlayerViewController.m
//  TVOSSampleApp
//
//  Created by Yi Gu on 6/2/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "OoyalaPlayerTokenPlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OODebugMode.h>
#import <OoyalaSDK/OOEmbeddedSecureURLGenerator.h>
#import "PlayerSelectionOption.h"
#import <OOyalaSDK/OOEmbedTokenGenerator.h>

@interface OoyalaPlayerTokenPlayerViewController () <OOEmbedTokenGenerator>

@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;

@property (nonatomic) NSString *authorizeHost;
@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *secret;
@property (nonatomic) NSString *accountId;

@end

@implementation OoyalaPlayerTokenPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.pcode = self.option.pcode;
  self.playerDomain = self.option.domain;

  self.authorizeHost = @"http://player.ooyala.com";
  
  /*
   * The API Key and Secret should not be saved inside your applciation (even in git!).
   * However, for debugging you can use them to locally generate Ooyala Player Tokens.
   */
  self.apiKey = @"Fill me in";
  self.secret = @"Fill me in";
  self.accountId = @"Fill me in";
  
  self.player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                             embedTokenGenerator:self];
  
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
