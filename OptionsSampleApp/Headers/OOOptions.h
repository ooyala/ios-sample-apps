//
// Created by Jon Slenk on 8/26/14.
// Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OOFCCTVRatingConfiguration;

@interface OOOptions : NSObject

@property (nonatomic) OOFCCTVRatingConfiguration *tvRatingConfiguration; // todo: readonly?
@property (nonatomic) BOOL showCuePoints;
@property (nonatomic) BOOL showAdsControls;
@property (nonatomic) BOOL preloadContent;
@property (nonatomic) BOOL showPromoImage;

-(instancetype) init;
-(instancetype) initWithTVRatingsConfiguration:(OOFCCTVRatingConfiguration *)tvRatingConfiguration
                                 showCuePoints:(BOOL)showCuePoints
                                  showControls:(BOOL)showControls
                                preloadContent:(BOOL)preloadContent
                                showPromoImage:(BOOL)showPromoImage;

@end