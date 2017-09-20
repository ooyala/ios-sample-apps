#import <Foundation/Foundation.h>
#import "OOPerformanceStatisticsProtocol.h"

/**
 * Keep track of the time taken between the start and end events.
 * As the start-end windows repeat, this keeps gathering those
 * into itself and updating a moving average.
 * \ingroup performance
 */
@interface OOPerformanceStartEndStatistics : NSObject <OOPerformanceStatisticsProtocol>
@property (nonatomic, readonly) NSTimeInterval totalTime;
@property (nonatomic, readonly) NSTimeInterval smallestTime;
@property (nonatomic, readonly) NSTimeInterval biggestTime;
@property (nonatomic, readonly) double averageTime;
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithName:(NSString*)name;
-(void) mergeTimeInterval:(NSTimeInterval)time;
@end
