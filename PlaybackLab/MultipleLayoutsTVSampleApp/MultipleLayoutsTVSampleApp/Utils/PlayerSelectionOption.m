/**
 * @class      PlayerSelectionOption PlayerSelectionOption.m "PlayerSelectionOption.m"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "PlayerSelectionOption.h"
#import "FullscreenPlayerViewController.h"

@implementation PlayerSelectionOption

- (instancetype)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode {
  return [self initWithTitle:title embedCode:embedCode needsAuthorization:NO];
}

- (instancetype)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode needsAuthorization:(BOOL)authorization {
  return [self initWithTitle:title embedCode:embedCode needsAuthorization:authorization viewController:[FullscreenPlayerViewController class]];
}

- (instancetype)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode needsAuthorization:(BOOL)authorization viewController:(Class)hostVC {
  self = [super init];
  if (self) {
    self.title = title;
    self.embedCode = embedCode;
    self.needsAuthorization = authorization;
    self.hostVC = hostVC;
  }
  return self;
}

@end
