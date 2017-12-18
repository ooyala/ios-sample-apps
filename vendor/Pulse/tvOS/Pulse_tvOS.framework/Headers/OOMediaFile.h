//
//  OOMediaFile.h
//  Pulse
//
//  Created by Jacques du Toit on 20/04/15.
//  Copyright (c)2015 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Indicates the delivery method of a given media file.
 */
typedef NS_ENUM(NSUInteger, OODeliveryMethod) {
	/** Progressive delivery. */
  OODeliveryMethodProgressive = 0,
	/** Streaming delivery. */
  OODeliveryMethodStreaming
};

/**
 *  Represents a media resource associated with a video ad.
 */
@interface OOMediaFile : NSObject

/**
 The delivery method of the media file.
 */
- (OODeliveryMethod)deliveryMethod;

/**
 The media file's width.
 */
- (NSInteger)width;

/**
 The media file's height.
 */
- (NSInteger)height;

/**
 The media file's bitrate.
 */
- (NSInteger)bitRate;

/**
 The MIME-type of the media file.
 */
- (NSString *)mimeType;

/**
 The URL from which the media file should be retrieved.
 */
- (NSURL *)URL;

/**
 String value indicating the the API needed to execute the file.
 */
- (NSString *)APIFramework;


@end
