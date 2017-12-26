#import "OOPerformanceEventWatchProtocol.h"
#import "OOPerformanceEventMatcherProtocol.h"

/**
 * Sample memory stats whenever notifications match.
 * \ingroup performance
 */
@interface OOPerformanceEventWatchMemoryProfiling : NSObject <OOPerformanceEventWatchProtocol>
@property (nonatomic, readonly) id<OOPerformanceEventMatcherProtocol> matcher;
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithMatcher:(id<OOPerformanceEventMatcherProtocol>)matcher;
@end
