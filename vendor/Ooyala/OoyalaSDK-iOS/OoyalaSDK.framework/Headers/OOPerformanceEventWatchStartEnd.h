//
// Copyright (c) 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOPerformanceEventWatchProtocol.h"
#import "OOPerformanceEventMatcherProtocol.h"

@interface OOPerformanceEventWatchStartEnd : NSObject <OOPerformanceEventWatchProtocol>
@property (nonatomic, readonly) id<OOPerformanceEventMatcherProtocol> start;
@property (nonatomic, readonly) id<OOPerformanceEventMatcherProtocol> end;
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithStart:(id<OOPerformanceEventMatcherProtocol>)start end:(id<OOPerformanceEventMatcherProtocol>)end;
@end