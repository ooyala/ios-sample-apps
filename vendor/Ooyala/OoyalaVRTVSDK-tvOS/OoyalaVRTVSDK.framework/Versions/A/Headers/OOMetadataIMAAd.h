//
//  OOMetadataIMAAd.h
//  OoyalaSDK
//
//  Created on 7/17/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#ifndef OOMetadataIMAAd_h
#define OOMetadataIMAAd_h

@import Foundation;

@interface OOMetadataIMAAd: NSObject

@property (nonatomic) NSString *tagUrl;
@property (nonatomic) NSString *clickUrl;
@property (nonatomic) NSNumber *position;
@property (nonatomic) NSString *positionType;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

#endif /* OOMetadataIMAAd_h */
