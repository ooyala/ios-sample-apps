/**
 * @class      ChromecastPlayerSelectionOption ChromecastPlayerSelectionOption.m "ChromecastPlayerSelectionOption.m"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "ChromecastPlayerSelectionOption.h"

@implementation ChromecastPlayerSelectionOption

- (id)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode pcode:(NSString *)pcode domain:(NSString *)domain viewController:(Class) viewController {
  self = [super init];
  if (self) {
    _title = title;
    _embedCode = embedCode;
    _pcode = pcode;
    _domain = domain;
    _viewController = viewController;
    _startPlaying = true;
  }
  return self;
}
@end
