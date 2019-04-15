//
//  GeoblockingPlayerSelectionOptions.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "GeoblockingPlayerSelectionOptions.h"

@implementation GeoblockingPlayerSelectionOptions

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                 playerDomain:(NSString *)playerDomain
               viewController:(Class)viewController
                          nib:(NSString *)nib
                       apiKey:(NSString *)apiKey
                    secretKey:(NSString *)secretKey
                    accountId:(NSString *)accountId {
  if (self = [super initWithTitle:title
                        embedCode:embedCode
                            pcode:pcode
                     playerDomain:playerDomain
                   viewController:viewController
                              nib:nib]) {
    _apiKey = apiKey;
    _secretKey = secretKey;
    _accountId = accountId;
  }
  return self;
}

@end
