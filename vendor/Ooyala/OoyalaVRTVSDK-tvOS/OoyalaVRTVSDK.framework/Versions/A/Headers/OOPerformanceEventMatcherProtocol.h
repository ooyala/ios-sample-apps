#import <Foundation/Foundation.h>

/**
 * Minimal stuff an OOPerformanceEventMatcher object should implement.
 * Defines the noatification event to match.
 * \ingroup performance
 */
@protocol OOPerformanceEventMatcherProtocol <NSObject>
@property (nonatomic, readonly) NSString *notificationName; /**< required so we can register for the specific notification. */
@property (nonatomic, readonly) NSString *reportName; /**< required so we can pretty print stats. */
-(BOOL) matches:(NSNotification*)notification;
@end
