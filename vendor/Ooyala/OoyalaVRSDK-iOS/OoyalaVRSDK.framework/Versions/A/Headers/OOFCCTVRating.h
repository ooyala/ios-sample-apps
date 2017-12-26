//
//Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Encapsulates the UI-relevant rating data of an asset.
 */
@interface OOFCCTVRating : NSObject
@property (readonly, nonatomic) NSString *ageRestriction;
@property (readonly, nonatomic) NSString *labels;
@property (readonly, nonatomic) NSString *clickthroughUrl;
-(instancetype) __unavailable init;
-(instancetype) initWithAgeRestriction:(NSString*)ageRestriction labels:(NSString*)labels clickthroughUrl:(NSString*)clickthroughUrl;
@end