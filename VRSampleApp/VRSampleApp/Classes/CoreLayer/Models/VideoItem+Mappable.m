//
//  VideoItem+Mappable.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "VideoItem+Mappable.h"

@implementation VideoItem (Mappable)

+ (id)createFromJSON:(id)json {
  json = (NSDictionary *)json;
  
  if (json) {
    NSString *embedCode = json[@"embed-code"];
    NSString *title = json[@"title"];
    NSString *pcode = json[@"provider-code"];
    NSString *parsedAdTypeString = json[@"ad-type"];
    VideoAdType parsedAdType;
    VideoItem *newVideoItem;
    
    if (!embedCode || !title) {
      return NULL;
    }

    if (parsedAdTypeString) {
      if ([parsedAdTypeString isEqualToString:@"NO-ADS"]) {
        parsedAdType = NOADS;
      } else if ([parsedAdTypeString isEqualToString:@"OOYALA"]) {
        parsedAdType = OOYALA;
      } else if ([parsedAdTypeString isEqualToString:@"IMA"]) {
        parsedAdType = IMA;
      } else if ([parsedAdTypeString isEqualToString:@"VAST"]) {
        parsedAdType = VAST;
      } else if ([parsedAdTypeString isEqualToString:@"FREEWHEEL"]) {
        parsedAdType = FREEWHEEL;
      } else {
        parsedAdType = UNKNOWN;
      }
    } else {
      parsedAdType = UNKNOWN;
    }
    
    newVideoItem = [[VideoItem alloc] initWithEmbedCode:embedCode andTitle:title];
    newVideoItem.videoAdType = parsedAdType;
    newVideoItem.pcode = pcode;
    
    return newVideoItem;
  }
  
  return NULL;
}

+ (id)createCollectionFromJSON:(id)json {
  return NULL;
}

+ (id)createCollectionFromArrayJSON:(id)json {
  NSArray *jsonArray = json;
  NSMutableArray *objectsArray = [NSMutableArray array];

  if (jsonArray) {
    for (id json in jsonArray) {
      VideoItem *videoItem = [VideoItem createFromJSON:json];
      
      if (videoItem) {
        [objectsArray addObject:videoItem];
      }
    }
  }
  
  return objectsArray;
}

@end
