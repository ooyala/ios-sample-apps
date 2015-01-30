//
// Created by Jon Slenk on 8/21/14.
// Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OOFCCTVRating : NSObject
@property (readonly, nonatomic) NSString *ageRestriction;
@property (readonly, nonatomic) NSString *labels;
@property (readonly, nonatomic) NSString *clickthroughUrl;
-(instancetype) __unavailable init;
-(instancetype) initWithAgeRestriction:(NSString*)ageRestriction labels:(NSString*)labels clickthroughUrl:(NSString*)clickthroughUrl;
@end