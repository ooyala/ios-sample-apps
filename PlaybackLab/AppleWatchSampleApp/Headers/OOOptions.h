//
//Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OOFCCTVRatingConfiguration;

@interface OOOptions : NSObject

@property (nonatomic) OOFCCTVRatingConfiguration *tvRatingConfiguration; // todo: readonly?
@property (nonatomic) BOOL showCuePoints;
@property (nonatomic) BOOL showLiveContentScrubber;
@property (nonatomic) BOOL showAdsControls;
@property (nonatomic) BOOL preloadContent;
@property (nonatomic) BOOL showPromoImage;
@property (nonatomic) NSTimeInterval connectionTimeout;

-(instancetype) init;
-(instancetype) initWithTVRatingsConfiguration:(OOFCCTVRatingConfiguration *)tvRatingConfiguration
                                 showCuePoints:(BOOL)showCuePoints
                       showLiveContentScrubber:(BOOL)showLiveContentScrubber
                               showAdsControls:(BOOL)showAdsControls
                                preloadContent:(BOOL)preloadContent
                                showPromoImage:(BOOL)showPromoImage
                             connectionTimeout:(NSTimeInterval)connectionTimeout;

@end