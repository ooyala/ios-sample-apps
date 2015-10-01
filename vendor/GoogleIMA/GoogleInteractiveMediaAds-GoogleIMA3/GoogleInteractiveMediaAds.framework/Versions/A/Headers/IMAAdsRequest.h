//
//  IMAAdsRequest.h
//  GoogleIMA3
//
//  Copyright (c) 2013 Google Inc. All rights reserved.
//
//  Declares a simple ad request class.

#import <Foundation/Foundation.h>

@class IMAAdDisplayContainer;

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
 *  container. Serial ad requests may reuse the same IMAAdDisplayContainer by
 *  first calling [IMAAdsManager destroy] its current adsManager. Concurrent
 *  requests must use different ad containers.
 *
 *  @param adTagUrl           the ad tag URL
 *  @param adDisplayContainer the IMAAdDisplayContainer for rendering the ad
 *  @param userContext        the user context for tracking requests
 *
 *  @return the IMAAdsRequest instance
 */
- (instancetype)initWithAdTagUrl:(NSString *)adTagUrl
              adDisplayContainer:(IMAAdDisplayContainer *)adDisplayContainer
                     userContext:(id)userContext;

- (instancetype)init NS_UNAVAILABLE;

@end
