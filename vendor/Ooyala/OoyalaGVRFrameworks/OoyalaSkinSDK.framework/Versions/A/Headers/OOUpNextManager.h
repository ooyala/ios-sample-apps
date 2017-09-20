//
// Created by Daniel Kao on 7/6/15.
// Copyright (c) 2015 ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>

@class OOReactBridge;

@interface OOUpNextManager : NSObject

@property (nonatomic, readonly) BOOL isDismissed;
@property (nonatomic, readonly, weak) OOOoyalaPlayer *player;

- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player
                        bridge:(OOReactBridge *)bridge
                        config:(NSDictionary *)config;

- (void)setNextVideo:(NSMutableArray *)nextVideo;

- (void)playCompletedNotification:(NSNotification *)notification;
- (void)currentItemChangedNotification:(NSNotification *)notification;

- (void)goToNextVideo;
- (void)onDismissPressed;

@end
