//
//  VideoItemSection+Mappable.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "VideoItemSection+Mappable.h"
#import "VideoItem+Mappable.h"

@implementation VideoItemSection (Mappable)

+ (id)createFromJSON:(id)json {
  json = (NSDictionary *)json;
  
  if (json) {
    NSArray *videos = json[@"videos"];
    NSString *title = json[@"title"];
    NSArray *videoItems = [VideoItem createCollectionFromArrayJSON:videos];

    if (!videos || !title || !videoItems) {
      return NULL;
    }
    
    return [[VideoItemSection alloc] initWithVideoItems:videoItems andTitle:title];
  }
  
  return NULL;
}

+ (id)createCollectionFromJSON:(id)json {
  return [VideoItemSection createCollectionFromArrayJSON:json];
}

+ (id)createCollectionFromArrayJSON:(id)json {
  NSArray *jsonArray = json;
  NSMutableArray *objectsArray = [NSMutableArray array];
  
  if (jsonArray) {
    for (id json in jsonArray) {
      VideoItemSection *videoItem = [VideoItemSection createFromJSON:json];
      
      if (videoItem) {
        [objectsArray addObject:videoItem];
      }
    }
  }
  
  return objectsArray;
}


@end
