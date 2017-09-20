#import <Foundation/Foundation.h>
#import "OOPerformanceStatisticsProtocol.h"

/**
 * File space profiling related data.
 * \ingroup performance
 */
@interface OOPerformanceFileSpaceProfilingStatistics : NSObject <OOPerformanceStatisticsProtocol>

@property (nonatomic, readonly) long long smallestBytesFree;
@property (nonatomic, readonly) long long biggestBytesFree;
@property (nonatomic, readonly) double averageBytesFree; /**< windowed moving average. */

-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithName:(NSString*)name;
-(void) mergeBytesFree:(long long)bytesFree;

@end
