/**
 * @class      PlayerSelectionOption PlayerSelectionOption.m "PlayerSelectionOption.m"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "PlayerSelectionOption.h"

@interface PlayerSelectionOption ()

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class)viewController;

@end

@implementation PlayerSelectionOption

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class)viewController {
  if (self = [super init]) {
    _title = title;
    _embedCode = embedCode;
    _pcode = pcode;
    _domain = domain;
    _viewController = viewController;
  }
  return self;
}

+ (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class)viewController {
  PlayerSelectionOption *option = [[PlayerSelectionOption alloc] initWithTitle:title
                                                                     embedCode:embedCode
                                                                         pcode:pcode
                                                                        domain:domain
                                                                viewController:viewController];
  return option;
}

+ (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class)viewController
          embedTokenGenerator:(id<OOEmbedTokenGenerator>)embedTokenGenerator {
  PlayerSelectionOption *option = [[PlayerSelectionOption alloc] initWithTitle:title
                                                                     embedCode:embedCode
                                                                         pcode:pcode
                                                                        domain:domain
                                                                viewController:viewController];
  option.embedTokenGenerator = embedTokenGenerator;
  return option;
}

@end
