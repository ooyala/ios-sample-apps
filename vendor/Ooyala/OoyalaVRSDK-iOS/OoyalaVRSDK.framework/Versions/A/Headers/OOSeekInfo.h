//
//  OOSeekInfo.h
//  OoyalaSDK
//
//  Created by Unnath Kumar on 10/3/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOSeekInfo : NSObject

@property (nonatomic) Float64 seekStart;
@property (nonatomic) Float64 seekEnd;
@property (nonatomic) Float64 totalDuration;

- (instancetype)initWithStartTime:(Float64)startTime
                          endTime:(Float64)endTime
                 andTotalDuration:(Float64)totalDuration;

@end
