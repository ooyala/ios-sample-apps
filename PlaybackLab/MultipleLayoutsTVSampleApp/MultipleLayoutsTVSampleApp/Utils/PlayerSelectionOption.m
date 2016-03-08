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

- (instancetype)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode {
  self = [super init];
  if (self) {
    self.title = title;
    self.embedCode = embedCode;
  }
  return self;
}
@end
