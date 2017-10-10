//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOPerformanceStatisticsProtocol.h"
#import <mach/mach.h>

/**
 * CPU profiling related data.
 * \ingroup performance
 */
@interface OOPerformanceCPUProfilingStatistics : NSObject <OOPerformanceStatisticsProtocol>

// see mach's thread_info.h's thread_basic_info_t.
@property (nonatomic, readonly) time_value_t userTime;
@property (nonatomic, readonly) time_value_t systemTime;
@property (nonatomic, readonly) double smallestCPUUsagePercent;
@property (nonatomic, readonly) double biggestCPUUsagePercent;
@property (nonatomic, readonly) double averageCPUUsagePercent; /**< windowed moving average. */

-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithName:(NSString*)name;
-(void) mergeThreadInfo:(thread_basic_info_t)threadInfo;

@end
