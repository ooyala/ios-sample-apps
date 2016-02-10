//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOPerformanceEventWatchProtocol.h"

@class OOPerformanceStatisticsSnapshot;
@class OOPerformanceCountingStatistics;
@class OOPerformanceStartEndStatistics;

@interface OOPerformanceStatisticsSnapshotBuilder : NSObject
-(void)addCountingStatistics:(OOPerformanceCountingStatistics*)countingStatistic;
-(void)addStartEndStatistics:(OOPerformanceStartEndStatistics*)startEndStatistic;
-(OOPerformanceStatisticsSnapshot *) build;
@end

@interface OOPerformanceStatisticsSnapshot : NSObject
@property (nonatomic, readonly) NSSet *countingStatistics; /**< set of OOPerformanceCountingStatistics */
@property (nonatomic, readonly) NSSet *startEndStatistics; /**< set of OOPerformanceStartEndStatistics */
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithCountingStatistics:(NSSet*)countingStatistics startEndStatistics:(NSSet*)startEndStatistics;
-(NSString*) generateReport; /**< mainly for debugging, this might be a little bit expensive to run. */
@end
