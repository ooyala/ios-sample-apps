//
//  OOOoyalaPlayer+PlaybackWorkflow.h
//  OoyalaSDK
//
//  Created on 10/31/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"

#ifndef OOOoyalaPlayer_PlaybackWorkflow_h
#define OOOoyalaPlayer_PlaybackWorkflow_h

@class OOAuthHeartbeat;

@interface OOOoyalaPlayer (PlaybackWorkflow)

- (void)prepareContent;
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context;
- (void)onComplete;
- (void)onContentError;
- (void)stopPlaybackOnHeartbeatFailure:(OOAuthHeartbeat *)sender;

@end


#endif /* OOOoyalaPlayer_PlaybackWorkflow_h */
