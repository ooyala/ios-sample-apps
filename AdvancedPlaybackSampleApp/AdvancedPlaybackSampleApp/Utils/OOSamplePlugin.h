//
//  OOSamplePlugin.h
//  PluginSampleApp
//
//  Created by Zhihui Chen on 9/2/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OoyalaSDK/OOAdPlugin.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>

@interface OOSamplePlugin : NSObject <OOAdPlugin>

- (instancetype)initWithPlayer:(OOOoyalaPlayer*)player;

@end
