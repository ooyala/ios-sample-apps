
#ifndef OoyalaSDK_h
#define OoyalaSDK_h
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>

#import <OoyalaSDK/OOFCCTVRatingConfiguration.h>
#import <OoyalaSDK/OOIQConfiguration.h>
#import <OoyalaSDK/OOOptions.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OOPlayerInfo.h>
#import <OoyalaSDK/OODefaultPlayerInfo.h>

// VAST ad classes
#import <OoyalaSDK/OOVASTConstants.h>
#import <OoyalaSDK/OOVASTCreative.h>
#import <OoyalaSDK/OOVASTVMAPAdHelper.h>
#import <OoyalaSDK/OOVASTOffset.h>
#import <OoyalaSDK/OOVASTResource.h>
#import <OoyalaSDK/OOVASTCompanionAds.h>
#import <OoyalaSDK/OOVASTNonLinearAds.h>
#import <OoyalaSDK/OOVASTIcon.h>
#import <OoyalaSDK/OOVASTNonLinear.h>
#import <OoyalaSDK/OOVASTCompanion.h>
#import <OoyalaSDK/OOVASTVMAPAdSpot.h>
#import <OoyalaSDK/OOVASTAd.h>
#import <OoyalaSDK/OOVASTAdSpot.h>
#import <OoyalaSDK/OOVASTLinearAd.h>
#import <OoyalaSDK/OOVASTStream.h>
#import <OoyalaSDK/OOVASTUtils.h>

// Old UI classes
#import <OoyalaSDK/OOFCCTVRatingStampView.h>
#import <OoyalaSDK/OOFCCTVRatingVideoView.h>
#import <OoyalaSDK/OOTransparentToolbar.h>
#import <OoyalaSDK/OOUIProgressSliderIOS7.h>
#import <OoyalaSDK/OOBufferView.h>
#import <OoyalaSDK/OOCuePointsView.h>
#import <OoyalaSDK/OOClosedCaptionsSelectorViewController.h>
#import <OoyalaSDK/OOClosedCaptionsSelectorBackgroundViewController.h>
#import <OoyalaSDK/OOClosedCaptionsView.h>
#import <OoyalaSDK/OOClosedCaptionsButton.h>
#import <OoyalaSDK/OOAdsLearnMoreButton.h>
#import <OoyalaSDK/OOFullscreenButton.h>
#import <OoyalaSDK/OOPlayPauseButton.h>
#import <OoyalaSDK/OOVideoGravityButton.h>
#import <OoyalaSDK/OOVolumeButton.h>
#import <OoyalaSDK/iOS7ScrubberSliderFraming.h>
#import <OoyalaSDK/OOControlsViewController.h>
#import <OoyalaSDK/OOImagesIOS7.h>
#import <OoyalaSDK/OOUIUtils.h>

// Performance Monitoring classes
#import <OoyalaSDK/OOPerformanceEventWatchMemoryProfiling.h>
#import <OoyalaSDK/OOPerformanceCPUProfilingStatistics.h>
#import <OoyalaSDK/OOPerformanceFileSpaceProfilingStatistics.h>
#import <OoyalaSDK/OOPerformanceMemoryProfilingStatistics.h>
#import <OoyalaSDK/OOPerformanceEventWatchFileSpaceProfiling.h>
#import <OoyalaSDK/OOPerformanceEventWatchCPUProfiling.h>
#import <OoyalaSDK/OOPerformanceMonitor.h>
#import <OoyalaSDK/OOPerformanceNotificationNameMatcher.h>
#import <OoyalaSDK/OOPerformanceCountingStatistics.h>
#import <OoyalaSDK/OOPerformanceStartEndStatistics.h>
#import <OoyalaSDK/OOPerformanceMonitorBuilder.h>
#import <OoyalaSDK/OOPerformanceNotificationNameStateMatcher.h>
#import <OoyalaSDK/OOPerformanceEventMatcherProtocol.h>
#import <OoyalaSDK/OOPerformanceEventWatchStartEnd.h>
#import <OoyalaSDK/OOPerformanceStatisticsProtocol.h>
#import <OoyalaSDK/OOPerformanceEventWatchProtocol.h>
#import <OoyalaSDK/OOPerformanceStatisticsSnapshot.h>
#import <OoyalaSDK/OOPerformanceEventWatchCounting.h>
#import <OoyalaSDK/OOMovingAverage.h>

// Player Interfaces
#import <OoyalaSDK/OOPlayerProtocol.h>
#import <OoyalaSDK/OOPlayer.h>
#import <OoyalaSDK/OOStreamPlayer.h>

// Ad manager classes
#import <OoyalaSDK/OOAdSpot.h>
#import <OoyalaSDK/OOAdSpotManager.h>
#import <OoyalaSDK/OOManagedAdSpot.h>
#import <OoyalaSDK/OOOoyalaAdSpot.h>
#import <OoyalaSDK/OOAdPlugin.h>
#import <OoyalaSDK/OOAdPluginManagerProtocol.h>
#import <OoyalaSDK/OOAdSpotPlugin.h>

// Message data
#import <OoyalaSDK/OOAdPodInfo.h>
#import <OoyalaSDK/OOAdOverlayInfo.h>
#import <OoyalaSDK/OOClientId.h>
#import <OoyalaSDK/OOSeekInfo.h>


// Caption information
#import <OoyalaSDK/OOCaption.h>
#import <OoyalaSDK/OOClosedCaptions.h>
#import <OoyalaSDK/OOClosedCaptionsStyle.h>
#import <OoyalaSDK/OOClosedCaptionsLabel.h>

// Content Item Data Model classes
#import <OoyalaSDK/OOChannel.h>
#import <OoyalaSDK/OOChannelSet.h>
#import <OoyalaSDK/OOContentItem.h>
#import <OoyalaSDK/OODynamicChannel.h>
#import <OoyalaSDK/OOPaginatedParentItem.h>
#import <OoyalaSDK/OOStream.h>
#import <OoyalaSDK/OOVideo.h>
#import <OoyalaSDK/OOAuthorizableItem.h>
#import <OoyalaSDK/OOClosedCaptionsItem.h>
#import <OoyalaSDK/OOUnbundledVideo.h>
#import <OoyalaSDK/OOOfflineVideo.h>
#import <OoyalaSDK/OOPlayableItem.h>
#import <OoyalaSDK/OOFCCTVRating.h>
#import <OoyalaSDK/OOAudioTrack.h>
#import <OoyalaSDK/OOAudioTrackProtocol.h>

// Offline
#import <OoyalaSDK/OOAssetDownloadOptions.h>
#import <OoyalaSDK/OOAssetDownloadManager.h>

// API access classes
#import <OoyalaSDK/OODiscoveryManager.h>
#import <OoyalaSDK/OODiscoveryOptions.h>
#import <OoyalaSDK/OOOoyalaAPIClient.h>

// Utils classes
#import <OoyalaSDK/OODebugMode.h>
#import <OoyalaSDK/OOOoyalaError.h>
#import <OoyalaSDK/OOOrderedDictionary.h>
#import <OoyalaSDK/OOTBXML.h>

// Signature generation classes
#import <OoyalaSDK/OOEmbeddedSecureURLGenerator.h>
#import <OoyalaSDK/OOEmbeddedSignatureGenerator.h>
#import <OoyalaSDK/OOEmbedTokenGenerator.h>
#import <OoyalaSDK/OOSecureURLGenerator.h>
#import <OoyalaSDK/OOSignatureGenerator.h>

#import <OoyalaSDK/OOCastModeOptions.h>
#import <OoyalaSDK/OOCastManagerProtocol.h>
#import <OoyalaSDK/OOCallbacks.h>
#import <OoyalaSDK/OOModule.h>
#import <OoyalaSDK/OOReturnState.h>
#import <OoyalaSDK/OOUserInfo.h>
#import <OoyalaSDK/OOStreamPlayerMappingCreator.h>
#import <OoyalaSDK/OOStreamPlayerMappingPredicate.h>
#import <OoyalaSDK/OOLifeCycle.h>
#import <OoyalaSDK/OOManagedAdsPlugin.h>
#import <OoyalaSDK/OOStateNotifier.h>
#import <OoyalaSDK/OOAssetLoaderDelegate.h>
#import <OoyalaSDK/OODeliveryTypeConstants.h>

#endif /* OoyalaSDK_h */
