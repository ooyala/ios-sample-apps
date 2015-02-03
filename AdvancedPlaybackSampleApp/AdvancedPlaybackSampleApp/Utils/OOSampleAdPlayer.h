//
//  OOSamplePlayer.h
//  PluginSampleApp
//
//  Created by Zhihui Chen on 9/2/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OOPlayerProtocol.h"
#import "OOLifeCycle.h"
#import "OOSampleAdSpot.h"
#import "OOStateNotifier.h"

@interface OOSampleAdPlayer : UILabel <OOLifeCycle, OOPlayerProtocol>

- (instancetype)initWithFrame:(CGRect)frame notifier:(OOStateNotifier *)notifier;
- (void)loadAd:(OOSampleAdSpot *)ad;

@end
