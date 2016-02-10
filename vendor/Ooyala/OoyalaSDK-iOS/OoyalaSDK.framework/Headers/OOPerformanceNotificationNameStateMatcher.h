//
// Copyright (c) 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOPerformanceEventMatcherProtocol.h"
#import "OOOoyalaPlayer.h"

@interface OOPerformanceNotificationNameStateMatcher : NSObject <OOPerformanceEventMatcherProtocol>
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithNotificationName:(NSString*)notificationName state:(OOOoyalaPlayerState)state;
@end