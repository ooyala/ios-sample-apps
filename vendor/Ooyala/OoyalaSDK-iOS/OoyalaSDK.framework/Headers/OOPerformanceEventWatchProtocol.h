//
// Copyright (c) 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OOPerformanceStatisticsSnapshotBuilder;

@protocol OOPerformanceEventWatchProtocol <NSObject>
@property (nonatomic, readonly) NSSet *wantedNotifications; /**< NSSet of *NSStrings. */
-(void) onNotification:(NSNotification*)notification;
-(void) addStatisticsToBuilder:(OOPerformanceStatisticsSnapshotBuilder*)builder;
@end