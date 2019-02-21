//
//  OOSampleAdSpot.h
//  PluginSampleApp
//
//  Created on 9/2/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import <OoyalaSDK/OoyalaSDK.h>

@interface OOSampleAdSpot : OOAdSpot

@property (nonatomic) NSString *text;
@property BOOL played;

+ (OOSampleAdSpot *)spotWithTime:(Float64)time text:(NSString *)text;

@end
