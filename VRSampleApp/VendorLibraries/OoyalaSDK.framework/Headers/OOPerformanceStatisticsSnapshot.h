//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOPerformanceEventWatchProtocol.h"

@class OOPerformanceStatisticsSnapshot;
@class OOPerformanceCountingStatistics;
@class OOPerformanceStartEndStatistics;
@class OOPerformanceCPUProfilingStatistics;
@class OOPerformanceMemoryProfilingStatistics;
@class OOPerformanceFileSpaceProfilingStatistics;

/**
 * \ingroup performance
 */
@interface OOPerformanceStatisticsSnapshotBuilder : NSObject
-(void)addCountingStatistics:(OOPerformanceCountingStatistics*)countingStatistics;
-(void)addStartEndStatistics:(OOPerformanceStartEndStatistics*)startEndStatistics;
-(void)addCPUProfilingStatistics:(OOPerformanceCPUProfilingStatistics *)cpuProfilingStatistics;
-(void)addMemoryProfilingStatistics:(OOPerformanceMemoryProfilingStatistics *)memoryProfilingStatistics;
-(void)addFileSpaceProfilingStatistics:(OOPerformanceFileSpaceProfilingStatistics *)fileSpaceProfilingStatistics;
-(OOPerformanceStatisticsSnapshot *) build;
@end

/**
 * A collection of the OOPerformanceStatistics at a point in time.
 */
@interface OOPerformanceStatisticsSnapshot : NSObject
@property (nonatomic, readonly) NSSet *countingStatistics; /**< set of OOPerformanceCountingStatistics */
@property (nonatomic, readonly) NSSet *startEndStatistics; /**< set of OOPerformanceStartEndStatistics */
@property (nonatomic, readonly) NSSet *cpuProfilingStatistics; /**< set of OOPerformanceCPUProfilingStatistics */
@property (nonatomic, readonly) NSSet *memoryProfilingStatistics; /**< set of OOPerformanceMemoryProfilingStatistics */
@property (nonatomic, readonly) NSSet *fileSpaceProfilingStatistics; /**< set of OOPerformanceFileSpaceProfilingStatistics */
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithCountingStatistics:(NSSet*)countingStatistics startEndStatistics:(NSSet*)startEndStatistics cpuProfilingStatistics:(NSSet*)cpuProfilingStatistics memoryProfilingStatistics:(NSSet*)memoryProfilingStatistics fileSpaceProfilingStatistics:(NSSet*)fileSpaceProfilingStatistics;
-(NSString*) generateReport; /**< mainly for debugging, this might be a little bit expensive to run. */
@end
