//
//  OOStateNotifier.h
//  OoyalaSDK
//
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

#ifndef OOStateNotifier_h
#define OOStateNotifier_h

#import "OOPlayerState.h"
#import "OOOoyalaPlayer+Ads.h"

@class OOAdPodInfo;
@class OOSsaiAdsMetadata;
@class OOAdOverlayInfo;
@class OOSeekInfo;

@interface OOStateNotifier : NSObject

@property (nonatomic) OOOoyalaPlayerState state;

- (void)notifyPlayheadChange;

- (void)notifyPlayCompleted;

- (void)notifySeekCompletedWithSeekInfo:(OOSeekInfo *)seekInfo;

- (void)notifyAdsLoaded;

- (void)notifyAdStartedWithAdPodInfo:(OOAdPodInfo *)adPodInfo;

- (void)notifyAdOverlayDisplay:(OOAdOverlayInfo *)adOverlayInfo;

- (void)notifyAdSkipped;

- (void)notifyAdTapped;

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

/**
 Notifies the player the ads metadata has been received.
 Used for SSAI ads.
 @param adsMetadata metadata returned by SSAI endpoint
 */
- (void)notifySSAIAdsMetadataReceived:(OOSsaiAdsMetadata *)adsMetadata;
/**
 Notifies the player a when an SSAI ad break has started
 @param adPodInfo ad metadata to display in adScreen
 */
- (void)notifySSAIAdPlaying:(OOAdPodInfo *)adPodInfo;
/**
 Notifies the player a when an SSAI ad break has ended
 */
- (void)notifySSAIAdPlayed;

@end

#endif /* OOStateNotifier_h */
