//
//  OOPlaybackSpeedProtocol.h
//  OoyalaSDK
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OOPlaybackSpeedProtocol <NSObject>


/**
 Gets the currently selected playback speed rate.
 
 @return An Float64 value.
 */
@property (nonatomic, readonly) Float64 selectedPlaybackSpeedRate;

/**
 Lets you know if the current video supporting playback speed.
 
 The following code snippet shows an example of this method. It assumes you are listening
 to the events of the OOOoyalaPlayer using notifications:
 @code
 // assumes you are observing OOOoyalaPlayer notifications and you have a property
 // like `@property OOOoyalaPlayer *player;`
 if ([notification.name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
   NSNumber *state = notification.userInfo[@"newState"];
   if (state.intValue == OOOoyalaPlayerStateReady) {
     NSLog(@"playback speed enabled: %d", self.player.isPlaybackSpeedEnabled);
   }
 }
 @endcode
 
 @return YES if the asset isn't LIVE, AD OR VR. NO otherwise.
 */
@property (nonatomic, readonly, getter=isPlaybackSpeedEnabled) BOOL playbackSpeedEnabled;

/**
 Requests to change the current playback speed rate to the one provided as a parameter.

 @param playbackSpeedRate to be used.
 */
- (void)changePlaybackSpeedRate:(Float64)playbackSpeedRate;

@end
