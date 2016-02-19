//
//  OOPerformanceMonitor.h
//  OoyalaSDK
//

#import <Foundation/Foundation.h>
#import "OOPerformanceEventWatchProtocol.h"
#import "OOPerformanceNotificationNameMatcher.h"
#import "OOPerformanceNotificationNameStateMatcher.h"
#import "OOPerformanceStatisticsSnapshot.h"

@class OOPerformanceMonitor;

/**
 * Currently only supports one source of events at a time, it does
 * not pay attention to the NSNotification's object field.
 */
@interface OOPerformanceMonitorBuilder : NSObject
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithNotificationCenter:(NSNotificationCenter*)notificationCenter;
-(void) addEventWatch:(id<OOPerformanceEventWatchProtocol>)watch; /**< These are added to an NSSet, thus they cannot lead to duplicates. */
-(OOPerformanceMonitor *) build;
@end

/**
 * Does not support watches that start and end on the exact same event occurrence, and thus have zero time.
 * Does support watches that start and end on a repeating event, with time in between.
 */
@interface OOPerformanceMonitor : NSObject
+(OOPerformanceMonitor *) getStandardMonitor; /**< Returns an instance of OOPerformanceMonitor configured with standard monitoring. */
-(instancetype) init __attribute__((unavailable("init not available")));
-(OOPerformanceStatisticsSnapshot *) buildStatisticsSnapshot;
@end

