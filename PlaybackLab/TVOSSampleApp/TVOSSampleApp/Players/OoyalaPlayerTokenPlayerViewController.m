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

@interface OoyalaPlayerTokenPlayerViewController () <OOEmbedTokenGenerator>

@property (nonatomic, strong) NSString *embedCode;
@property (nonatomic, strong) NSString *pcode;
@property (nonatomic, strong) NSString *playerDomain;

@property (nonatomic, strong) NSString *authorizeHost;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *accountId;

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
                                                          domain:[[OOPlayerDomain alloc]initWithString:self.playerDomain]
                                             embedTokenGenerator:self];
  
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
