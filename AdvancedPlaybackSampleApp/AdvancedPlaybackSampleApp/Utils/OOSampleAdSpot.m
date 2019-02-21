//
//  OOSampleAdSpot.m
//  PluginSampleApp
//
//  Created on 9/2/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "OOSampleAdSpot.h"

@implementation OOSampleAdSpot

+ (OOSampleAdSpot *)spotWithTime:(Float64)time text:(NSString *)text {
  OOSampleAdSpot *adSpot = [[OOSampleAdSpot alloc] initWithTime:@(time)];
  adSpot.text = text;
  return adSpot;
}

@end
