//
//  DRMPlayerSelectionOptions.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "DRMPlayerSelectionOptions.h"


@implementation DRMPlayerSelectionOptions

- (id)initWithTitle:(NSString *)title
          embedCode:(NSString *)embedCode
              pcode:(NSString *)pcode
       playerDomain:(NSString *)playerDomain
     viewController:(Class)viewController
                nib:(NSString *)nib
             apiKey:(NSString *)apiKey
          secretKey:(NSString *)secretKey
          accountId:(NSString *)accountId {
  self = [super initWithTitle:title
                    embedCode:embedCode
                        pcode:pcode
                 playerDomain:playerDomain
               viewController:viewController
                          nib:nib];
  if (self) {
    self.apiKey = apiKey;
    self.secretKey = secretKey;
    self.accountId = accountId;
  }
  return self;
}

@end
