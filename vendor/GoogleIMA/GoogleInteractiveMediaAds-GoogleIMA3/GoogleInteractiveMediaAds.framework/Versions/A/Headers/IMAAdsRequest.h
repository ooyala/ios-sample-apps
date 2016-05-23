//
//  IMAAdsRequest.h
//  GoogleIMA3
//
//  Copyright (c) 2013 Google Inc. All rights reserved.
//
//  Declares a simple ad request class.

#import <Foundation/Foundation.h>

@class IMAAdDisplayContainer;
@class IMAAVPlayerContentPlayhead;
@class IMAAVPlayerVideoDisplay;
@class IMAPictureInPictureProxy;
@protocol IMAContentPlayhead;

/**
 *  Data class describing the ad request.
 */
@interface IMAAdsRequest : NSObject

/**
 *  The ad request URL set.
 */
@property(nonatomic, copy, readonly) NSString *adTagUrl;

/**
 *  The ad display containter.
 */
@property(nonatomic, strong, readonly) IMAAdDisplayContainer *adDisplayContainer;

/**
 *  The user context.
 */
@property(nonatomic, strong, readonly) id userContext;

/**
 *  Specifies whether the player intends to start the content and ad in
 *  response to a user action or whether they will be automatically played.
 *  Changing this setting will have no impact on ad playback.
 */
@property(nonatomic) BOOL adWillAutoPlay;

/**
 *  Initializes an ads request instance with the given ad tag URL and ad display
 *  container with Picture-in-Picture support. Serial ad requests may reuse the
 *  same IMAAdDisplayContainer by first calling [IMAAdsManager destroy] on its
 *  current adsManager. Concurrent requests must use different ad containers.
 *
 *  @param adTagUrl              the ad tag URL
 *  @param adDisplayContainer    the IMAAdDisplayContainer for rendering the ad UI
 *  @param avPlayerVideoDisplay  the IMAAVPlayerVideoDisplay for rendering ads
 *  @param pictureInPictureProxy the IMAPictureInPictureProxy for tracking PIP events
 *  @param userContext           the user context for tracking requests (optional)
 *
 *  @return the IMAAdsRequest instance
 */
- (instancetype)initWithAdTagUrl:(NSString *)adTagUrl
              adDisplayContainer:(IMAAdDisplayContainer *)adDisplayContainer
            avPlayerVideoDisplay:(IMAAVPlayerVideoDisplay *)avPlayerVideoDisplay
           pictureInPictureProxy:(IMAPictureInPictureProxy *)pictureInPictureProxy
                     userContext:(id)userContext;

/**
 *  Initializes an ads request instance with the given ad tag URL and ad display
 *  container. Serial ad requests may reuse the same IMAAdDisplayContainer by
 *  first calling [IMAAdsManager destroy] on its current adsManager. Concurrent
 *  requests must use different ad containers. Does not support Picture-in-Picture.
 *
 *  @param adTagUrl           the ad tag URL
 *  @param adDisplayContainer the IMAAdDisplayContainer for rendering the ad UI
 *  @param contentPlayhead    the IMAContentPlayhead for the content player (optional)
 *  @param userContext        the user context for tracking requests (optional)
 *
 *  @return the IMAAdsRequest instance
 */
- (instancetype)initWithAdTagUrl:(NSString *)adTagUrl
              adDisplayContainer:(IMAAdDisplayContainer *)adDisplayContainer
                 contentPlayhead:(NSObject<IMAContentPlayhead> *)contentPlayhead
                     userContext:(id)userContext NS_DESIGNATED_INITIALIZER;

/**
 *  Initializes an ads request instance with the given ad tag URL and ad display
 *  container. Serial ad requests may reuse the same IMAAdDisplayContainer by
 *  first calling [IMAAdsManager destroy] on its current adsManager. Concurrent
 *  requests must use different ad containers. Does not support Picture-in-Picture.
 *
 *  @param adTagUrl           the ad tag URL
 *  @param adDisplayContainer the IMAAdDisplayContainer for rendering the ad
 *  @param userContext        the user context for tracking requests (optional)
 *
 *  @return the IMAAdsRequest instance
 */
- (instancetype)initWithAdTagUrl:(NSString *)adTagUrl
              adDisplayContainer:(IMAAdDisplayContainer *)adDisplayContainer
                     userContext:(id)userContext DEPRECATED_ATTRIBUTE;

- (instancetype)init NS_UNAVAILABLE;

@end
