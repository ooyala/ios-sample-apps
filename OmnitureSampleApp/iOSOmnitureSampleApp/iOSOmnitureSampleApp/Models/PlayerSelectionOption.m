//
//  PlayerSelectionOption.m
//  iOSOmnitureSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "PlayerSelectionOption.h"

@implementation PlayerSelectionOption

- (instancetype)initWithTitle:(NSString *)title pcode:(NSString *)pcode embedCode:(NSString *)embedCode {
  if (self = [super init]) {
    _title = title;
    _pcode = pcode;
    _embedCode = embedCode;
  }
  return self;
}

@end
