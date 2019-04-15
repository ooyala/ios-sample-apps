//
// Created on 7/6/15.
// Copyright (c) 2015 ooyala. All rights reserved.
//

@import Foundation;

@class OOReactSkinModel;
@class OOOoyalaPlayer;

@interface OOUpNextManager : NSObject

@property (nonatomic, readonly) BOOL isDismissed;
@property (nonatomic, readonly, weak) OOOoyalaPlayer *player;

- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player
              ooReactSkinModel:(OOReactSkinModel *)ooReactSkinModel
                        config:(NSDictionary *)config;

- (void)setNextVideo:(NSDictionary *)nextVideo;

- (void)playCompletedNotification:(NSNotification *)notification;
- (void)currentItemChangedNotification:(NSNotification *)notification;

- (void)goToNextVideo;
- (void)onDismissPressed;

@end
