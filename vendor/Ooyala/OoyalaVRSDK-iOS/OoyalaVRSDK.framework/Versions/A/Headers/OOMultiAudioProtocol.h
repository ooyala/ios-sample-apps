//
//  OOMultiAudioProtocol.h
//  OoyalaSDK
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

@protocol OOAudioTrackProtocol;


/**
 This protocol defines all the required methods to manage audio tracks and audio languages for OOOoyalaPlayer.
 */
@protocol OOMultiAudioProtocol <NSObject>

/**
 Searchs for all of the audio tracks for the current asset.
 It requires that a video has already loaded.
 
 @return NSArray of OOAudioTrackProtocol objects. It could be empty if no audio tracks were found.
 */
- (nonnull NSArray *)availableAudioTracks;

/**
 Gets the currently selected (loaded) audio track.
 It requires that a video has already loaded.

 @return An OOAudioTrackProtocol object or nil if nothing was found.
 */
- (nullable id<OOAudioTrackProtocol>)selectedAudioTrack;

/**
 Requests to change the current audio track to the one provided as a parameter.
 It requires that a video has already loaded.
 
 @remark If the supplied OOAudioTrackProtocol isn't part of the current video asset nothing will happen.
 @param audioTrack OOAudioTrackProtocol to be used.
 */
- (void)setAudioTrack:(nonnull id<OOAudioTrackProtocol>)audioTrack;

/**
 Change the current default audio track to the one provided as a parameter.

 @remark This method doesn't change current playable audio track.
 @param audioTrack OOAudioTrackProtocol to be used.
 */
- (void)setDefaultAudioTrack:(nonnull id<OOAudioTrackProtocol>)audioTrack;

/**
 Change the current default audio track language code to the one provided as a parameter.

 @param defaultAudioTrackLanguageCode Language code to be used.
 */
- (void)setDefaultAudioTrackLanguageCode:(nonnull NSString *)defaultAudioTrackLanguageCode;

/**
 Change the current default audio track language code from config to the one provided as a parameter.

 @param defaultConfigAudioTrackLanguageCode Language code to be used.
 */
- (void)setDefaultConfigAudioTrackLanguageCode:(nonnull NSString *)defaultConfigAudioTrackLanguageCode;

/**
 Gets the default audio track from manifest.
 
 @return An OOAudioTrackProtocol object or nil if nothing was found
 */
- (nullable id<OOAudioTrackProtocol>)defaultAudioTrack;

@end
