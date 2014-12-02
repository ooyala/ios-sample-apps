//
// Created by Jon Slenk on 8/26/14.
// Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OOFCCTVRatingConfiguration;
@class OOOptions;

@interface OOOptions : NSObject
@property (nonatomic) OOFCCTVRatingConfiguration *tvRatingConfiguration; // todo: readonly?
-(instancetype) init;
-(instancetype) initWithTVRatingsConfiguration:(OOFCCTVRatingConfiguration *)tvRatingConfiguration;
@end