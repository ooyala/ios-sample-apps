//
//  OOMultiAudioProtocol.h
//  OoyalaSDK
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

@class OOAudioTrack;


/**
 This protocol defines all the required methods to manage audio tracks and audio languages for OOOoyalaPlayer.
 */
@protocol OOMultiAudioProtocol <NSObject>

/**
 Searchs for all of the audio tracks for the current asset.
 It requires that a video has already loaded.
 
 @return NSArray of OOAudioTrack objects. It could be empty if no audio tracks were found.
 */
- (nonnull NSArray *)availableAudioTracks;

/**
 Gets the currently selected (loaded) audio track.
 It requires that a video has already loaded.

 @return An OOAudioTrack object or nil if nothing was found.
 */
- (nullable OOAudioTrack *)selectedAudioTrack;

/**
 Requests to change the current audio track to the one provided as a parameter.
 It requires that a video has already loaded.
 
 @remark If the supplied OOAudioTrack isn't part of the current video asset nothing will happen.
 @param audioTrack OOAudioTrack to be used.
 */
- (void)setAudioTrack:(nonnull OOAudioTrack *)audioTrack;

/**
 Change the current default audio track to the one provided as a parameter.

 @remark This method doesn't change current playable audio track.
 @param audioTrack OOAudioTrack to be used.
 */
- (void)setDefaultAudioTrack:(nonnull OOAudioTrack *)audioTrack;

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
 
 @return An OOAudioTrack object or nil if nothing was found
 */
- (nullable OOAudioTrack *)defaultAudioTrack;

@end
