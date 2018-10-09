//
//  OOAudioTrackProtocol.h
//  OoyalaSDK
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AVMediaSelectionOption;


/**
 Encapsulates important information of an AVMediaSelectionOption instance.
 
 You don't need to instantiate this class yourself. The player will pass you instances of OOAudioTrackProtocol when you want to
 know information about an audio track of a video.
 */
@protocol OOAudioTrackProtocol <NSObject>

/// Meaningful name for the audio track, retrieved from the video asset
@property (nonatomic, readonly) NSString *name;

/// Meaningful title for the audio track, created in implemenation of file. By default, is equal to the language
@property (nonatomic, readonly) NSString *title;

/// Laguage code of audio track, retrived from AVMediaSelectionOption (mediaSelectionOption)
@property (nonatomic, readonly) NSString *languageCode;

/// Media selection option from AVMediaSelectionGroup
@property (nonatomic, readonly) AVMediaSelectionOption *mediaSelectionOption;

@end
