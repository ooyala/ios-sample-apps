/**
 * @class      ChromecastPlayerSelectionOption ChromecastPlayerSelectionOption.m "ChromecastPlayerSelectionOption.m"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright © 2014 Ooyala, Inc. All rights reserved.
 */

#import "ChromecastPlayerSelectionOption.h"

@implementation ChromecastPlayerSelectionOption

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class)viewController {
  return [self initWithTitle:title
                   embedCode:embedCode
                  embedCode2:nil
                       pcode:pcode
                      domain:domain
              viewController:viewController];
}

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                   embedCode2:(NSString *)embedCode2
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class) viewController {
  if (self = [super init]) {
    _title = title;
    _embedCode = embedCode;
    _embedCode2 = embedCode2;
    _pcode = pcode;
    _domain = domain;
    _viewController = viewController;
  }
  return self;
}
@end
