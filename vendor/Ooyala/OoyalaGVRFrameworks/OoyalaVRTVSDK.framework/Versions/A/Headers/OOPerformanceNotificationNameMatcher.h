#import <Foundation/Foundation.h>
#import "OOPerformanceEventMatcherProtocol.h"

/**
 * Match only on a notification's name.
 * \ingroup performance
 */
@interface OOPerformanceNotificationNameMatcher : NSObject <OOPerformanceEventMatcherProtocol>
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithNotificationName:(NSString*)notificationName;
@end
