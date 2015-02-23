//
//  OOSampleAdSpot.m
//  PluginSampleApp
//
//  Created by Zhihui Chen on 9/2/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "OOSampleAdSpot.h"

@implementation OOSampleAdSpot

+ (OOSampleAdSpot *)spotWithTime:(Float64)time text:(NSString *)text {
  OOSampleAdSpot *adSpot = [[OOSampleAdSpot alloc] initWithTime:[NSNumber numberWithFloat:time]];
  adSpot.text = text;
  return adSpot;
}

@end
