//
// Created by Jon Slenk on 8/26/14.
// Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "OOFCCTvRatingsConfiguration.h"


@implementation OOFCCTvRatingsConfiguration

-(instancetype) initWithDurationSeconds:(int)durationSeconds position:(OOFCCTvRatingsPosition)position scale:(CGFloat)scale opacity:(CGFloat)opacity {
  if( self = [super init] ) {
    _durationSeconds = durationSeconds;
    _position = position;
    _scale = scale;
    _opacity = opacity;
  }
  return self;
}
@end