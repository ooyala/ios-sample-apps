/**
 * @class      PlayerSelectionOption PlayerSelectionOption.m "PlayerSelectionOption.m"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

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

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                 playerDomain:(NSString *)playerDomain
               viewController:(Class)viewController
              markersFileName:(NSString *)markersFileName
                          nib:(NSString *)nib {
  if (self = [self initWithTitle:title
                       embedCode:embedCode
                           pcode:pcode
                    playerDomain:playerDomain
                  viewController:viewController
                             nib:nib]) {
    _markersFileName = markersFileName;
  }
  return self;
}


- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                 playerDomain:(NSString *)playerDomain
                adSetProvider:(NSString *)adSetProvider
               viewController:(Class)viewController
                          nib:(NSString *)nib {
  if (self = [self initWithTitle:title
                       embedCode:embedCode
                           pcode:pcode
                    playerDomain:playerDomain
                  viewController:viewController
                             nib:nib]) {
    _adSetProvider = adSetProvider;
  }
  return self;
}

@end
