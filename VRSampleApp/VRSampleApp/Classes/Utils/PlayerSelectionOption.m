//
//  PlayerSelectionOption.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "PlayerSelectionOption.h"


@implementation PlayerSelectionOption

  - (id)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode pcode:(NSString *)pcode  domain:(NSString *)domain {
    if (self = [super init]) {
      self.title = title;
      self.embedCode = embedCode;
      self.pcode = pcode;
      self.domain = domain;
    }
    return self;
  }

- (id)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode pcode:(NSString *)pcode {
  if (self = [super init]) {
    self.title = title;
    self.embedCode = embedCode;
    self.pcode = pcode;
    self.domain = @"http://www.ooyala.com";
  }
  return self;
}

- (id)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode {
  if (self = [super init]) {
    self.title = title;
    self.embedCode = embedCode;
    self.pcode = @"BzY2syOq6kIK6PTXN7mmrGVSJEFj";
    self.domain = @"http://www.ooyala.com";
  }
  return self;
}
  
@end
