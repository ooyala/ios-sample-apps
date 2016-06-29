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
 *  The inventory unit (iu).
 */
extern NSString *const kIMAStreamParamIU;

/**
 *  The description url (description_url).
 */
extern NSString *const kIMAStreamParamDescriptionURL;

/**
 *  The custom parameters (cust_params).
 */
extern NSString *const kIMAStreamParamCustomParameters;

/**
 *  Tag for child detection parameter (tfcd).
 */
extern NSString *const kIMAStreamParamTFCD;

/**
 *  The order variant parameter (dai-ov).
 */
extern NSString *const kIMAStreamParamOrderVariant;

/**
 *  The order type parameter (dai-ot).
 */
extern NSString *const kIMAStreamParamOrderType;

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
 *  The parameters that the SDK will attempt to add to ad tags. The following parameters are
 *  allowed: "cust_params", "dai-ot", "dai-ov", "description_url", "durl", "iu", and "tfcd".
 *  All other parameters will be ignored.
 */
@property(nonatomic, copy) NSDictionary *adTagParameters;

/**
 *  Whether the SDK should attempt to play a preroll during dynamic ad insertion.
 *  Defaults to false. This setting is only used for live streams.
 */
@property(nonatomic) BOOL attemptPreroll;

/**
 *  Initializes a stream request instance with the given assetKey. Uses the given ad display
 *  container to display the stream. This is used for live streams.
 *
 *  @param assetKey           the stream assetKey
 *  @param adDisplayContainer the IMAAdDisplayContainer for rendering the ad UI
 *  @param videoDisplay       the IMAVideoDisplay for playing the stream
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
 *  @param videoDisplay       the IMAVideoDisplay for playing the stream
 *
 *  @return the IMAStreamRequest instance
 */
- (instancetype)initWithContentSourceId:(NSString *)contentSourceId
                                videoId:(NSString *)videoId
                     adDisplayContainer:(IMAAdDisplayContainer *)adDisplayContainer
                           videoDisplay:(id<IMAVideoDisplay>)videoDisplay;

- (instancetype)init NS_UNAVAILABLE;

@end
