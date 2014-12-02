//
// Created by Jon Slenk on 9/26/14.
// Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol OOCuePointViewDurationDataSource
@property (nonatomic, readonly) float duration;
@end

@interface OOCuePointsView : UIView
@property (nonatomic) NSSet *cuePointsAtSeconds; /**< NSNumber int seconds */
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable));
- (instancetype)initWithFrame:(CGRect)frame padding:(float)padding durationDataSource:(id <OOCuePointViewDurationDataSource>)durationDataSource diameter:(float)diameter;
@end