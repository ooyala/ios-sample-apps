//
// Copyright (c) 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOPerformanceStatisticsProtocol.h"

@interface OOPerformanceStartEndStatistics : NSObject <OOPerformanceStatisticsProtocol>
@property (nonatomic, readonly) NSTimeInterval totalTime;
@property (nonatomic, readonly) NSTimeInterval smallestTime;
@property (nonatomic, readonly) NSTimeInterval biggestTime;
@property (nonatomic, readonly) int count;
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithName:(NSString*)name;
-(void) mergeTimeInterval:(NSTimeInterval)time;
@end