//
//  OOPerformanceMonitor.h
//  OoyalaSDK
//

#import <Foundation/Foundation.h>
#import "OOPerformanceEventWatchProtocol.h"
#import "OOPerformanceNotificationNameMatcher.h"
#import "OOPerformanceNotificationNameStateMatcher.h"
#import "OOPerformanceStatisticsSnapshot.h"

/**
 * \ingroup performance
 */
@class OOPerformanceMonitor;

/**
 * Listens to notifications and runs any matching watchers.
 * Does not support watches that start and end on the exact same event occurrence, and thus have zero time.
 * Does support watches that start and end on a repeating event, with time in between.
 */
@interface OOPerformanceMonitor : NSObject
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithWatches:(NSSet*)watches notificationCenter:(NSNotificationCenter*)notificationCenter;
-(OOPerformanceStatisticsSnapshot *) buildStatisticsSnapshot;
@end

