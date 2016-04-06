//
//  VideoItem.h
//  PulsePlayer
//
//  Created by Jacques du Toit on 23/10/15.
//  Copyright © 2015 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  A model object for video content.
 *
 */
@interface VideoItem : NSObject

+ (VideoItem *)videoItemWithDictionary:(NSDictionary *)dictionary;

/**
 *  A identifier for this content that used to identify this content in 
 *  the Pulse session request.
 */
@property (strong, nonatomic) NSString *identifier;

/**
 *  The title of this content, for displaying in the content list.
 */
@property (strong, nonatomic) NSString *title;

/**
 *  The duration of this content in seconds.
 */
@property (assign, nonatomic) NSInteger duration;

/**
 *  An array of string tags used to target ad campaigns.
 */
@property (strong, nonatomic) NSArray<NSString *> *tags;

/**
 *  A string category used to target ad campaigns.
 */
@property (strong, nonatomic) NSString *category;

/**
 *  An array of numbers of positions (in seconds) where midroll ad breaks
 *  may occur.
 */
@property (strong, nonatomic) NSArray<NSNumber *> *midrollPositions;

/**
 *  The URL to the video content.
 */
@property (strong, nonatomic) NSString *embedCode;

@end
