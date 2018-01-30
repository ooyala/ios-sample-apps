//
//  GeoblockingPlayerSelectionOptions.h
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "PlayerSelectionOption.h"

@interface GeoblockingPlayerSelectionOptions : PlayerSelectionOption

@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *secretKey;
@property (nonatomic) NSString *accountId;

- (id)initWithTitle:(NSString *)title
          embedCode:(NSString *)embedCode
              pcode:(NSString *)pcode
       playerDomain:(NSString *)playerDomain
     viewController:(Class)viewController
                nib:(NSString *)nib
             apiKey:(NSString *)apiKey
          secretKey:(NSString *)secretKey
          accountId:(NSString *)accountId;

@end
