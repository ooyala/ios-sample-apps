//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import "OOPerformanceEventWatchProtocol.h"
#import "OOPerformanceEventMatcherProtocol.h"

/**
 * Increment a counter whenever notifications match.
 */
@interface OOPerformanceEventWatchCounting : NSObject <OOPerformanceEventWatchProtocol>
@property (nonatomic, readonly) id<OOPerformanceEventMatcherProtocol> matcher;
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithMatcher:(id<OOPerformanceEventMatcherProtocol>)matcher;
@end
