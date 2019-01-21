//
//  OOAudioTrackSelectionProtocol.h
//  OoyalaSDK
//
//  Created on 2/9/17.
//  Copyright © 2017 Ooyala, Inc. All rights reserved.


@protocol OOAudioTrackProtocol;


/**
 This protocol defines all the required methods to manage audio tracks for an asset.
 */
@protocol OOAudioTrackSelectionProtocol <NSObject>

/**
 Searchs for all of the audio tracks for the current asset.
 
 It requires that a video has already loaded.
 
 The following code snippet shows an example of this method. It assumes you are listening
 to the events of the OOOoyalaPlayer using notifications:
@code
// assumes you are observing OOOoyalaPlayer notifications and you have a property
// like `@property OOOoyalaPlayer *player;`
if ([notification.name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
  NSNumber *state = notification.userInfo[@"newState"];
  if (state.intValue == OOOoyalaPlayerStateReady) {
    NSLog(@"available audio tracks: %@", [self.player availableAudioTracks]);
  }
}
@endcode
 
 @return NSArray of OOAudioTrackProtocol objects. It could be empty if no audio tracks were found.
 */
- (NSArray *)availableAudioTracks;

/**
 Gets the currently selected (loaded) audio track.
 
 It requires that a video has already loaded.
 
 The following code snippet shows an example of this method. It assumes you are listening
 to the events of the OOOoyalaPlayer using notifications:
@code
// assumes you are observing OOOoyalaPlayer notifications and you have a property
// like `@property OOOoyalaPlayer *player;`
if ([notification.name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
  NSNumber *state = notification.userInfo[@"newState"];
  if (state.intValue == OOOoyalaPlayerStateReady) {
    NSLog(@"selected audio track: %@", [self.player selectedAudioTrack].name);
  }
}
@endcode
 
 @return an OOAudioTrackProtocol object or nil if nothing was found.
 */
- (id <OOAudioTrackProtocol>)selectedAudioTrack;

/**
 Requests the player to change the current audio track to the one provided as a parameter.
 
 It requires that a video has already loaded.
 
 The following code snippet shows an example of this method. It assumes you are listening
 to the events of the OOOoyalaPlayer using notifications:
@code
// assumes you are observing OOOoyalaPlayer notifications and you have a property
// like `@property OOOoyalaPlayer *player;`
if ([notification.name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
  NSNumber *state = notification.userInfo[@"newState"];
  if (state.intValue == OOOoyalaPlayerStateReady) {
    NSArray *audioTracks = [self.player availableAudioTracks];
    // lets assume audio tracks array has 2 different tracks and we want to select the second one
    [self.player setAudioTrack:audioTracks[1]];
  }
}
@endcode
 
 @param audioTrack OOAudioTrackProtocol to be used.
 If the supplied OOAudioTrackProtocol isn't part of the current video asset nothing will happen.
 */
- (void)setAudioTrack:(id<OOAudioTrackProtocol>)audioTrack;

/**
 Gets the default audio track from manifest.

 @return An OOAudioTrackProtocol object or nil if nothing was found
 */
- (id<OOAudioTrackProtocol>)defaultAudioTrack;

@end
