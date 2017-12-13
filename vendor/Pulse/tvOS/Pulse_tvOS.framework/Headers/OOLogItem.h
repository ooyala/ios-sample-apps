//
//  OOLogItem.h
//  Pulse
//
//  Created by Jacques du Toit on 20/04/15.
//  Copyright (c) 2015 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OOLogItem;

/**
 * A block that receives a OOLogItem instance that provides information about a logged event.
 */
typedef void(^OOLogListenerBlock)(OOLogItem* logItem);

/**
 * Indicates which subsystem is the source of a LogItem.
 */
typedef NS_ENUM(NSUInteger, OOLogItemSource) {
  /** Indicates that the LogItem relates to an ad request. */
  OOLogItemSourceAd = 0,
  /** Indicates that the LogItem relates to a session request. */
  OOLogItemSourceSession,
  /** Indicates that the LogItem relates to a tracking request. */
  OOLogItemSourceTracker

};

/**
 * Indicates which event a LogItem instance relates to.
 */
typedef NS_ENUM(NSUInteger, OOLogItemEvent) {
  /** Blank or inventory ad response received. Only dispatched during ad requests. */
  OOLogItemEventNoAdResponse = 0,
  
  /** Unaccepted or missing arguments. Only dispatched during session and tracker requests. */
  OOLogItemEventInvalidArgument,
  /** A request received an empty or malformed response. Potentially dispatched during all types of requests. */
  OOLogItemEventInvalidResponse,
  
  /** Error with no dedicated event type. Potentially dispatched during all types of requests. */
  OOLogItemEventGeneralError,
  /** HTTP request failed. Potentially dispatched during all types of requests. */
  OOLogItemEventRequestFailed,
  /** HTTP request timed out. Potentially dispatched during all types of requests. */
  OOLogItemEventRequestTimeout,
  /** SDK user canceled request. Only dispatched during ad requests. */
  OOLogItemEventRequestCanceled,
  
  /** Non-fatal warning message. Potentially dispatched during all types of requests. */
  OOLogItemEventWarning,
  /** The user tried to perform an operation not allowed in the current state. Only dispatched during tracker requests. */
  OOLogItemEventIllegalOperation

};


/**
 Object passed to callbacks when errors occur.
 */
@interface OOLogItem : NSObject

/**
 * Describes the source of the LogItem. Depending on the source, not all fields might be set.
 */
@property (assign, nonatomic, readonly) OOLogItemSource source;

/**
 * Describes what type of event has occurred.
 */
@property (assign, nonatomic, readonly) OOLogItemEvent event;


/**
 * Associated error message for the log item. Can be nil if message is defined.
 */
@property (nonatomic, readonly) NSError *error;

/**
 * The path of third party ads fetched until an error occurred; only relevant when source is OOLogItemSourceAd.
 * The array will only contain instances of NSURL.
 */
@property (nonatomic, readonly) NSArray *thirdPartySourceURLs;


#pragma mark - String conversion

/**
 * Returns a string representation of the LogItem.
 */
- (NSString *)description;

/**
 * Returns a string representation of the LogItem message and/or error.
 */
- (NSString *)errorMessageDescription;

/**
 * Returns a string representation of the LogItem source.
 */
- (NSString *)sourceDescription;

/**
 * Returns a string representation of the LogItem type.
 */
- (NSString *)eventDescription;
@end
