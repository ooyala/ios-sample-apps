//
//  OOAnalyticsAdEventsReportingProtocol.h
//  OoyalaSDK
//
//  Created on 6/10/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#ifndef OOAnalyticsAdEventsReportingProtocol_h
#define OOAnalyticsAdEventsReportingProtocol_h

@import Foundation;

#import "OOOoyalaPlayer+Ads.h"

@protocol OOAnalyticsAdEventsReportingProtocol

- (void)notifyAdRequestFromPlugin:(OOAdProvider)plugin
                    forAdPosition:(Float64)adPosition;

- (void)notifyAdRequestErrorFromPlugin:(OOAdProvider)plugin
                         forAdPosition:(Float64)adPosition
                              adTagUrl:(NSString *)adTagUrl
                             errorCode:(NSInteger)errorCode
                          errorMessage:(NSString *)errorMessage
                             isTimeout:(BOOL)isTimeOut;

- (void)notifyAdRequestEmptyFromPlugin:(OOAdProvider)plugin
                         forAdPosition:(Float64)adPosition
                              adTagUrl:(NSString *)adTagUrl
                             errorCode:(NSInteger)errorCode
                          errorMessage:(NSString *)errorMessage;

- (void)notifyAdRequestSuccessFromPlugin:(OOAdProvider)plugin
                           forAdPosition:(Float64)adPosition
                            responseTime:(NSTimeInterval)responseTime
                    timeSinceInitialPlay:(NSTimeInterval)timeSinceInitialPlay;

- (void)notifyAdImpressionFromPlugin:(OOAdProvider)plugin
                       forAdPosition:(Float64)adPosition
                          adLoadTime:(NSTimeInterval)adLoadTime
                          adProtocol:(OOAdProtocol)adProtocol
                              adType:(OOAdType)adType;

- (void)notifyAdCompletedFromPlugin:(OOAdProvider)plugin
                timeSinceImpression:(NSTimeInterval)timeSinceImpression
                          isSkipped:(BOOL)skipped
                           adTagUrl:(NSString *)adTagUrl;

- (void)notifyAdPlaybackErrorFromPlugin:(OOAdProvider)plugin
                          forAdPosition:(Float64)adPosition
                               adTagUrl:(NSString *)adTagUrl
                              errorCode:(NSInteger)errorCode
                           errorMessage:(NSString *)errorMessage;

- (void)notifyAdPlaythroughFromPlugin:(OOAdProvider)plugin
                      quartilePercent:(OOAdQuartile)quartilePercent;

@end

#endif /* OOAnalyticsAdEventsReportingProtocol_h */
