//
//  OOOoyalaPlayer+MultiAudio.h
//  OoyalaSDK
//
//  Created on 10/31/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"
#import "OOMultiAudioProtocol.h"

#ifndef OOOoyalaPlayer_MultiAudio_h
#define OOOoyalaPlayer_MultiAudio_h

@interface OOOoyalaPlayer (MultiAudio)<OOMultiAudioProtocol>

/**
 Lets you know if the current video has multiple audio tracks.

 It requires that a video has already loaded.

 The following code snippet shows an example of this method. It assumes you are listening
 to the events of the OOOoyalaPlayer using notifications:
 @code
 // assumes you are observing OOOoyalaPlayer notifications and you have a property
 // like `@property OOOoyalaPlayer *player;`
 if ([notification.name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
 NSNumber *state = notification.userInfo[@"newState"];
 if (state.intValue == OOOoyalaPlayerStateReady) {
 NSLog(@"has audio tracks: %d", [self.player hasMultipleAudioTracks]);
 }
 }
 @endcode

 @return true if there are more than one audio tracks, false otherwise.
 */
- (BOOL)hasMultipleAudioTracks;

@end

#endif /* OOOoyalaPlayer_MultiAudio_h */
