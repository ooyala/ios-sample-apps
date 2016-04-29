//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOPerformanceStatisticsProtocol.h"

/**
 * Accumulated count.
 */
@interface OOPerformanceCountingStatistics : NSObject <OOPerformanceStatisticsProtocol>
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithName:(NSString*)name;
-(void) mergeCount:(int)count;
@end
