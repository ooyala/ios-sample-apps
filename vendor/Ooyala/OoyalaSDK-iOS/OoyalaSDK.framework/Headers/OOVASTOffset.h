//
//  OOVASTOffset.h
//  OoyalaSDK
//
//  Created by Yi Gu on 3/21/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  Seconds,
  Percentage,
  Position
} Type;

@interface OOVASTOffset : NSObject

@property (readonly, nonatomic, assign) Type type;

- (id)initWithType:(Type)type value:(Float64)value;
- (id)initWithOffset:(NSString *)offsetStr;

- (Float64)getPercentage;
- (Float64)getSeconds;
- (NSInteger)getPosition;
@end
