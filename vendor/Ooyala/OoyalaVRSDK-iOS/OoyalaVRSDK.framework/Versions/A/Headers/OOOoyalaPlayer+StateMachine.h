//
//  OOOoyalaPlayer+StateMachine.h
//  OoyalaSDK
//
//  Created on 04.12.2018.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"

#ifndef OOOoyalaPlayer_StateMachine_h
#define OOOoyalaPlayer_StateMachine_h

@interface OOOoyalaPlayer (StateMachine)

- (void)changePlayerState:(OOOoyalaPlayerState)state;
- (void)setState:(OOOoyalaPlayerState)state;

- (void)exitPlayerStatePlaying;
- (void)enterPlayerStatePlaying;

- (void)exitPlayerStateLoading;
- (void)enterPlayerStateLoading;

- (void)exitPlayerStateCompleted;
- (void)enterPlayerStateCompleted;

- (void)exitPlayerStateReady;
- (void)enterPlayerStateReady;

@end

#endif /* OOOoyalaPlayer_StateMachine_h */
