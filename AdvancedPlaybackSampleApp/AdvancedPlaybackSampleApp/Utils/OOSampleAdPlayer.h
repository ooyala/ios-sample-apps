//
//  OOSamplePlayer.h
//  PluginSampleApp
//
//  Created on 9/2/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OoyalaSDK/OoyalaSDK.h>
#import "OOSampleAdSpot.h"

@interface OOSampleAdPlayer : UILabel <OOLifeCycle, OOPlayerProtocol>

- (instancetype)initWithFrame:(CGRect)frame notifier:(OOStateNotifier *)notifier;
- (void)loadAd:(OOSampleAdSpot *)ad;

@end
