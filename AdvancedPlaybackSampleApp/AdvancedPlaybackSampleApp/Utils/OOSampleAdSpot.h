//
//  OOSampleAdSpot.h
//  PluginSampleApp
//
//  Created by Zhihui Chen on 9/2/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OoyalaSDK/OOAdSpot.h>

@interface OOSampleAdSpot : OOAdSpot

@property (nonatomic) NSString *text;
@property BOOL played;

+ (OOSampleAdSpot *)spotWithTime:(Float64)time text:(NSString *)text;

@end
