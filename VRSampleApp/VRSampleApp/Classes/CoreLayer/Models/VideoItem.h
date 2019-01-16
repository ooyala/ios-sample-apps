//
//  VideoItem.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
  UNKNOWN,
  NOADS,
  OOYALA,
  IMA,
  VAST,
  FREEWHEEL,
} VideoAdType;

@interface VideoItem : NSObject

@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *pcode;
@property (nonatomic) VideoAdType videoAdType;

- (instancetype)initWithEmbedCode:(NSString *)embedCode andTitle:(NSString *)title;

@end
