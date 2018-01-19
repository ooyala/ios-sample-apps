#import <Foundation/Foundation.h>
#import "OOPerformanceMonitor.h"

/**
 * \ingroup performance
 */
@interface OOPerformanceMonitorBuilder : NSObject
+(OOPerformanceMonitor *) getStandardMonitor; /**< Returns an instance of OOPerformanceMonitor configured with standard monitoring. */
+(OOPerformanceMonitor *) getStandardAdsMonitor; /**< Returns an instance of OOPerformanceMonitor configured with standard monitoring and additionally ads monitoring. */
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithNotificationCenter:(NSNotificationCenter*)notificationCenter;
-(void) addEventWatch:(id<OOPerformanceEventWatchProtocol>)watch; /**< Backed by an NSSet to keep watches unique. */
-(OOPerformanceMonitor *) build;
@end
