//
//  OOSamplePlugin.h
//  PluginSampleApp
//
//  Created on 9/2/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import <OoyalaSDK/OoyalaSDK.h>

@interface OOSamplePlugin : NSObject <OOAdPlugin>

- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player;

@end
