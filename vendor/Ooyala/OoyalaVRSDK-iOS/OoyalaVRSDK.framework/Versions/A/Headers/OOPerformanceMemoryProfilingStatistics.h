#import <Foundation/Foundation.h>
#import <mach/mach.h>
#import "OOPerformanceStatisticsProtocol.h"

/**
 * Memory profiling related data.
 * \ingroup performance
 */
@interface OOPerformanceMemoryProfilingStatistics : NSObject <OOPerformanceStatisticsProtocol>

// see mach's task_info.h's mach_task_basic_info.
@property (nonatomic, readonly) mach_vm_size_t smallestVirtualSize;
@property (nonatomic, readonly) mach_vm_size_t biggestVirtualSize;
@property (nonatomic, readonly) double averageVirtualSize; /**< windowed moving average. */
@property (nonatomic, readonly) mach_vm_size_t smallestResidentSize;
@property (nonatomic, readonly) mach_vm_size_t biggestResidentSize;
@property (nonatomic, readonly) double averageResidentSize; /**< windowed moving average. */
@property (nonatomic, readonly) mach_vm_size_t resident_size_max; /**< as reported by the system, rather than our own sampling. */

-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithName:(NSString*)name;
-(void) mergeMemoryInfo:(mach_task_basic_info_t)memoryInfo;

@end
