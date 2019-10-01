//
//  OOMetadataPulseData.h
//  OoyalaSDK
//
//  Created on 7/30/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#ifndef OOMetadataPulseData_h
#define OOMetadataPulseData_h

@import Foundation;

@interface OOMetadataPulseData: NSObject

@property (nonatomic) NSString *pulseHost;
@property (nonatomic) NSString *pulseLegacyHost;
@property (nonatomic) NSNumber *pulseDuration;
@property (nonatomic) NSString *pulseInsertionPointFilter;
@property (nonatomic) NSString *pulseCuepoints;
@property (nonatomic) NSString *pulseLegacyCuepoints;
@property (nonatomic) NSString *pulseNonLinearCuepoints;
@property (nonatomic) NSString *pulseTags;
@property (nonatomic) NSString *pulseLegacyTags;
@property (nonatomic) NSString *pulseFlags;
@property (nonatomic) NSString *pulseCategory;
@property (nonatomic) NSString *pulseLegacyCategory;
@property (nonatomic) NSString *pulseContentPartner;
@property (nonatomic) NSString *pulseContentId;
@property (nonatomic) NSString *pulseContentFrom;
@property (nonatomic) NSString *pulseReferrerUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

#endif /* OOMetadataPulseData_h */
