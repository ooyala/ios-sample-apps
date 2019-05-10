//
//  PlayerSelectionOption.m
//  DiscoverySampleApp
//
//  Created on 15/04/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import "PlayerSelectionOption.h"

@implementation PlayerSelectionOption

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                 playerDomain:(NSString *)playerDomain
               viewController:(Class)viewController
                          nib:(NSString *)nib {
  if (self = [super init]) {
    _title = title;
    _embedCode = embedCode;
    _viewController = viewController;
    _pcode = pcode;
    _playerDomain = playerDomain;
    _nib = nib;
  }
  return self;
}
@end
