//
//  BasicEmbedTokenGenerator.m
//  ContentProtectionSampleApp
//
//  Created on 9/1/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "BasicEmbedTokenGenerator.h"
#import <OoyalaSDK/OOEmbeddedSecureURLGenerator.h>

@interface BasicEmbedTokenGenerator ()

- (instancetype)initWithPcode:(NSString *)pcode
                       apiKey:(NSString *)apiKey
                    apiSecret:(NSString *)apiSecret
                    accountId:(NSString *)accountId
                authorizeHost:(NSString *)authorizeHost;

@end

@implementation BasicEmbedTokenGenerator

- (instancetype)initWithPcode:(NSString *)pcode
                       apiKey:(NSString *)apiKey
                    apiSecret:(NSString *)apiSecret
                    accountId:(NSString *)accountId
                authorizeHost:(NSString *)authorizeHost {
  if (self = [super init]) {
    _pcode = pcode;
    _apiKey = apiKey;
    _apiSecret = apiSecret;
    _accountId = accountId;
    _authorizeHost = authorizeHost;
  }
  return self;
}

+ (instancetype)initWithPcode:(NSString *)pcode
                       apiKey:(NSString *)apiKey
                    apiSecret:(NSString *)apiSecret
                    accountId:(NSString *)accountId
                authorizeHost:(NSString *)authorizeHost {
  BasicEmbedTokenGenerator *tokenGenerator = [[BasicEmbedTokenGenerator alloc] initWithPcode:pcode
                                                                                      apiKey:apiKey
                                                                                   apiSecret:apiSecret
                                                                                   accountId:accountId
                                                                               authorizeHost:authorizeHost];
  return tokenGenerator;
}

- (void)tokenForEmbedCodes:(NSArray<NSString *> *)embedCodes
                  callback:(OOEmbedTokenCallback)callback {
  NSDictionary *params = @{@"account_id": self.accountId};
  NSString *uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@",
                   self.pcode, [embedCodes componentsJoinedByString:@","]];
  
  // You should not be using OOEmbeddedSecureURLGenerator in your own app.
  // We recommend generating this URL in a remote server you own, as we discourage storing apiKey and apiSecret information within the app because of security concerns.
  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey
                                                                                       secret:self.apiSecret];
  NSURL* embedTokenUrl = [urlGen secureURLForHost:self.authorizeHost uri:uri params:params];
  callback(embedTokenUrl.absoluteString);
}

@end
