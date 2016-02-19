//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOPerformanceStatisticsProtocol.h"

@interface OOPerformanceCountingStatistics : NSObject <OOPerformanceStatisticsProtocol>
@property (nonatomic, readonly) int count;
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithName:(NSString*)name;
-(void) mergeCount:(int)count;
@end
