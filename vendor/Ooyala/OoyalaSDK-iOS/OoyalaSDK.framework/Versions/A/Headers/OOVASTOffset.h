//
//  OOVASTOffset.h
//  OoyalaSDK
//
//  Created by Yi Gu on 3/21/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OffsetType) {
  OffsetTypeSeconds,
  OffsetTypePercentage,
  OffsetTypePosition
};

@interface OOVASTOffset : NSObject

@property (readonly, nonatomic, assign) OffsetType type;

- (id)initWithType:(OffsetType)type value:(Float64)value;
- (id)initWithOffset:(NSString *)offsetStr;

- (Float64)getPercentage;
- (Float64)getSeconds;
- (NSInteger)getPosition;
@end
