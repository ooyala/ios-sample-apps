//
// Copyright (c) 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOPerformanceEventMatcherProtocol.h"

/**
 * Match only on a notification's name.
 */
@interface OOPerformanceNotificationNameMatcher : NSObject <OOPerformanceEventMatcherProtocol>
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithNotificationName:(NSString*)notificationName;
@end