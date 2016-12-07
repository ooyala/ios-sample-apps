#import <Foundation/Foundation.h>
#import "OOPerformanceEventMatcherProtocol.h"
#import "OOOoyalaPlayer.h"

/**
 * Match only Ooyala state change notifications, also checking the OOOoyalaPlayerState in the notification.
 * E.g. match the OOOoyalaPlayerStateChangedNotification notification name, but only when the state change
 * is to the OOOoyalaPlayerStateReady state.
 * \ingroup performance
 */
@interface OOPerformanceNotificationNameStateMatcher : NSObject <OOPerformanceEventMatcherProtocol>
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithNotificationName:(NSString*)notificationName state:(OOOoyalaPlayerState)state;
-(instancetype) initWithNotificationName:(NSString*)notificationName anyStateOtherThan:(OOOoyalaPlayerState)anyStateOtherThan;
@end
