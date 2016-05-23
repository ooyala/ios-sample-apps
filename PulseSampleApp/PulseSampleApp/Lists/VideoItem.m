//
//  VideoItem.m
//  PulsePlayer
//
//  Created by Jacques du Toit on 23/10/15.
//  Copyright © 2015 Ooyala. All rights reserved.
//

#import "VideoItem.h"

@implementation VideoItem

+ (VideoItem *)videoItemWithDictionary:(NSDictionary *)dictionary
{
  VideoItem *videoItem = [VideoItem new];
  
  videoItem.identifier = dictionary[@"content-id"];
  videoItem.title = dictionary[@"content-title"] ?: @"";
  videoItem.tags = dictionary[@"tags"];
  videoItem.category = dictionary[@"category"];
  videoItem.duration = dictionary[@"content-duration"] ?
    [dictionary[@"content-duration"] integerValue] : 0;
  videoItem.midrollPositions = dictionary[@"midroll-positions"];
  videoItem.embedCode = dictionary[@"content-code"];

  return videoItem;
}

@end
