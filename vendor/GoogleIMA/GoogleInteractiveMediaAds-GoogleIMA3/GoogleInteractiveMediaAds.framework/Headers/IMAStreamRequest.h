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
 *  The stream display container for displaying the ad UI.
 */
@property(nonatomic, strong, readonly) IMAAdDisplayContainer *adDisplayContainer;

/**
 *  The video display where the stream can be played.
 */
@property(nonatomic, strong, readonly) id<IMAVideoDisplay> videoDisplay;

/**
 *  The stream request API key. It's configured through the
 *  <a href="//support.google.com/dfp_premium/answer/6381445">
 *  DFP Admin UI</a> and provided to the publisher to unlock their content.
 *  It verifies the applications that are attempting to access the content.
 */
@property(nonatomic, copy) NSString *apiKey;

/**
 *  The stream request authorization token. This is used in place of the API key for stricter
 *  content authorization. The publisher can control individual content streams authorized based
 *  on this token.
 */
@property(nonatomic, copy) NSString *authToken;

/**
 *  The stream request debug key. This is used to provide a convenient way to allow publishers to
 *  find a stream log in the stream activity monitor tool.
 */
@property(nonatomic, copy) NSString *debugKey;

/**
 *  The parameters that the SDK will attempt to add to ad tags. The following parameters are
 *  allowed: "cust_params", "dai-ot", "dai-ov", "sz", "description_url", "iu", "ppid" and "tfcd".
 *  All other parameters are ignored.
 */
@property(nonatomic, copy) NSDictionary *adTagParameters;

/**
 *  The suffix that the SDK will append to the query of the stream manifest URL. Do not include the
 *  '?' separator at the start. The SDK will account for the existence of parameters in the URL
 *  already, removing existing ones that collide with ones supplied here. This suffix needs to be
 *  sanitized and encoded as the SDK will not do this.
 */
@property(nonatomic, copy) NSString *manifestURLSuffix;

- (instancetype)init NS_UNAVAILABLE;

@end
