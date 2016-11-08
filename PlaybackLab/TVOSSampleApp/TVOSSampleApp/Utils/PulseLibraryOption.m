//
//  PulseLibraryOption.m
//  TVOSSampleApp
//
//  Created by Steve on 2016-10-12.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "PulseLibraryOption.h"

@implementation PulseLibraryOption

- (instancetype) initWithTitle:(NSString*)title embedCode:(NSString*)embedCode category:(NSString*)category tags:(id)tags midrollPositions:(id)midrollPositions {
  self = [super init];
  
  if(self) {
    _title = title;
    _embedCode = embedCode;
    _category = category;
    _tags = tags;
    _midrollPositions = midrollPositions;
  }
  
  return self;
}

@end
