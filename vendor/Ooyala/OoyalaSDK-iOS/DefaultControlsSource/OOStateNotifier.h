//
//  OOStateNotifier.h
//  OoyalaSDK
//
//  Created by Zhihui Chen on 8/15/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OOStateNotifier : NSObject

@property OOOoyalaPlayerState state;

- (void)notifyPlayheadChange;
- (void)notifyAdsLoaded;
- (void)notifyAdSkipped;

@end
