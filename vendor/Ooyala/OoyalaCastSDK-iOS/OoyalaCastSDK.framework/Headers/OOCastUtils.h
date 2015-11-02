//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOCastUtils : NSObject

/**
 * Post a OOCastErrorNotification.
 * @param from the non-nil sender of the notification (the 'object' parameter for posting).
 * @param error if non-nill will be passed in userInfo dictionary as @{@"error":error}, otherwise
 * the userInfo dictionary is nil.
 * @param extras if non-nil will be used as the base for the userInfo dictionary (@param error won't be over-written in userInfo).
 */
+(void) postCastErrorNotificationFrom:(id)from error:(NSError*)error extras:(NSDictionary*)extras;

@end