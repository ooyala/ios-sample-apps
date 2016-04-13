//
//  IMAStreamRequest.h
//  GoogleIMA3
//
//  Copyright (c) 2015 Google Inc. All rights reserved.
//
//  Declares a simple stream request class.

#import <Foundation/Foundation.h>

@class IMAAdDisplayContainer;
@protocol IMAVideoDisplay;

/**
 *  Data class describing the stream request.
 */
@interface IMAStreamRequest : NSObject

/**
 *  The stream request asset key.
 */
@property(nonatomic, copy, readonly) NSString *assetKey;

/**
 *  The stream request content source ID.
 */
@property(nonatomic, copy, readonly) NSString *contentSourceId;

/**
 *  The stream request video ID.
 */
@property(nonatomic, copy, readonly) NSString *videoId;

/**
 *  The stream request asset type. Should be either "content" or "event".
 */
@property(nonatomic, copy, readonly) NSString *assetType;

/**
 *  The stream display container for displaying the ad UI.
 */
@property(nonatomic, strong, readonly) IMAAdDisplayContainer *adDisplayContainer;

/**
 *  The video display where the stream can be played.
 */
@property(nonatomic, strong, readonly) id<IMAVideoDisplay> videoDisplay;

/**
 *  The stream request API key. This is used for content authentication. The API key is provided to
 *  the publisher to unlock their content. It's a security measure used to verify the applications
 *  that are attempting to access the content.
 */
@property(nonatomic, copy) NSString *apiKey;

/**
 *  Any custom targeting parameters.
 */
@property(nonatomic, copy) NSDictionary *customParameters;

/**
 *  Whether the SDK should attempt to play a preroll during server side ad insertion.
 *  Defaults to false.
 */
@property(nonatomic) BOOL attemptPreroll;

/**
 *  Initializes a stream request instance with the given assetKey. Uses the given ad display
 *  container to display the stream. This is used for live streams.
 *
 *  @param assetKey           the stream assetKey
 *  @param adDisplayContainer the IMAAdDisplayContainer for rendering the ad UI
 *  @parem videoDisplay       the IMAVideoDisplay for playing the stream
 *
 *  @return the IMAStreamRequest instance
 */
- (instancetype)initWithAssetKey:(NSString *)assetKey
              adDisplayContainer:(IMAAdDisplayContainer *)adDisplayContainer
                    videoDisplay:(id<IMAVideoDisplay>)videoDisplay;

/**
 *  Initializes a stream request instance with the given content source ID and video ID.
 *  Uses the given ad display container to display the stream. This is used for on-demand streams.
 *
 *  @param contentSourceId    the content source ID for this stream
 *  @param videoId            the video identifier for this stream
 *  @param adDisplayContainer the IMAAdDisplayContainer for rendering the ad UI
 *  @parem videoDisplay       the IMAVideoDisplay for playing the stream
 *
 *  @return the IMAStreamRequest instance
 */
- (instancetype)initWithContentSourceId:(NSString *)contentSourceId
                                videoId:(NSString *)videoId
                     adDisplayContainer:(IMAAdDisplayContainer *)adDisplayContainer
                           videoDisplay:(id<IMAVideoDisplay>)videoDisplay;

- (instancetype)init NS_UNAVAILABLE;

@end
