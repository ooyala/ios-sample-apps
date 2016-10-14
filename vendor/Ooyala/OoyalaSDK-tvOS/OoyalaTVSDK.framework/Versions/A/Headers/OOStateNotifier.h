//
//  OOStateNotifier.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OOStateNotifier : NSObject

@property OOOoyalaPlayerState state;

- (void)notifyPlayheadChange;
- (void)notifyAdsLoaded;
- (void)notifyAdSkipped;
- (void)notifyAdStarted;
- (void)notifyAdCompleted;

@end
