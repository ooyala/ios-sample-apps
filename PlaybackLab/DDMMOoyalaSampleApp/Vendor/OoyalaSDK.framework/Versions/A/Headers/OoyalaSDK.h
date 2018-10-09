
#ifndef OoyalaSDK_h
#define OoyalaSDK_h


#import "OOOoyalaPlayer.h"

#import "OOFCCTVRatingConfiguration.h"
#import "OOIQConfiguration.h"
#import "OODeviceInfo.h"
#import "OOOptions.h"
#import "OOPlayerDomain.h"
#import "OOPlayerInfo.h"
#import "OODefaultPlayerInfo.h"

// VAST ad classes
#import "OOVASTConstants.h"
#import "OOVASTCreative.h"
#import "OOVASTVMAPAdHelper.h"
#import "OOVASTOffset.h"
#import "OOVASTResource.h"
#import "OOVASTCompanionAds.h"
#import "OOVASTNonLinearAds.h"
#import "OOVASTIcon.h"
#import "OOVASTNonLinear.h"
#import "OOVASTCompanion.h"
#import "OOVASTVMAPAdSpot.h"
#import "OOVASTAd.h"
#import "OOVASTAdSpot.h"
#import "OOVASTLinearAd.h"
#import "OOVASTStream.h"
#import "OOVASTUtils.h"

// Old UI classes
#import "OOFCCTVRatingStampView.h"
#import "OOFCCTVRatingVideoView.h"
#import "OOUIUtils.h"
#import "OOClosedCaptionsView.h"

#if !TARGET_OS_TV // Check is tvOS

#import "OOOoyalaPlayerViewController.h"

#import "OOTransparentToolbar.h"
#import "OOBufferView.h"
#import "OOCuePointsView.h"
#import "OOClosedCaptionsSelectorViewController.h"
#import "OOClosedCaptionsSelectorBackgroundViewController.h"
#import "OOClosedCaptionsButton.h"
#import "OOAdsLearnMoreButton.h"
#import "OOFullscreenButton.h"
#import "OOPlayPauseButton.h"
#import "OOVideoGravityButton.h"
#import "ScrubberSliderFraming.h"
#import "OOVolumeButton.h"
#import "OOControlsViewController.h"
#import "OOImages.h"

#else

// TVOS GVR
#import "OOOoyalaSimpleTVPlayerViewController.h"

#endif

// Performance Monitoring classes
#import "OOPerformanceEventWatchMemoryProfiling.h"
#import "OOPerformanceCPUProfilingStatistics.h"
#import "OOPerformanceFileSpaceProfilingStatistics.h"
#import "OOPerformanceMemoryProfilingStatistics.h"
#import "OOPerformanceEventWatchFileSpaceProfiling.h"
#import "OOPerformanceEventWatchCPUProfiling.h"
#import "OOPerformanceMonitor.h"
#import "OOPerformanceNotificationNameMatcher.h"
#import "OOPerformanceCountingStatistics.h"
#import "OOPerformanceStartEndStatistics.h"
#import "OOPerformanceMonitorBuilder.h"
#import "OOPerformanceNotificationNameStateMatcher.h"
#import "OOPerformanceEventMatcherProtocol.h"
#import "OOPerformanceEventWatchStartEnd.h"
#import "OOPerformanceStatisticsProtocol.h"
#import "OOPerformanceEventWatchProtocol.h"
#import "OOPerformanceStatisticsSnapshot.h"
#import "OOPerformanceEventWatchCounting.h"
#import "OOMovingAverage.h"

// Player Interfaces
#import "OOPlayerProtocol.h"
#import "OOPlayer.h"
#import "OOStreamPlayer.h"

// Ad manager classes
#import "OOAdSpot.h"
#import "OOAdSpotManager.h"
#import "OOManagedAdSpot.h"
#import "OOOoyalaAdSpot.h"
#import "OOAdPlugin.h"
#import "OOAdPluginManagerProtocol.h"
#import "OOAdSpotPlugin.h"

// Message data
#import "OOAdPodInfo.h"
#import "OOAdOverlayInfo.h"
#import "OOClientId.h"
#import "OOSeekInfo.h"

// Caption information
#import "OOCaption.h"
#import "OOClosedCaptions.h"
#import "OOClosedCaptionsStyle.h"
#import "OOClosedCaptionsLabel.h"

// Content Item Data Model classes
#import "OOChannel.h"
#import "OOChannelSet.h"
#import "OOContentItem.h"
#import "OODynamicChannel.h"
#import "OOPaginatedParentItem.h"
#import "OOStream.h"
#import "OOVideo.h"
#import "OOAuthorizableItem.h"
#import "OOClosedCaptionsItem.h"
#import "OOUnbundledVideo.h"
#import "OOOfflineVideo.h"
#import "OOPlayableItem.h"
#import "OOFCCTVRating.h"
#import "OOMultiAudioProtocol.h"
#import "OOAudioTrackProtocol.h"

// Offline
#if !TARGET_OS_TV // Check is tvOS

#import "OOAssetDownloadOptions.h"
#import "OOAssetDownloadStream.h"
#import "OOAssetDownloadManager.h"

#endif

// API access classes
#import "OODiscoveryManager.h"
#import "OODiscoveryOptions.h"
#import "OOOoyalaAPIClient.h"

// Utils classes
#import "OODebugMode.h"
#import "OOOoyalaError.h"
#import "OOOrderedDictionary.h"
#import "OOTBXML.h"

// Signature generation classes
#import "OOEmbeddedSecureURLGenerator.h"
#import "OOEmbeddedSignatureGenerator.h"
#import "OOEmbedTokenGenerator.h"
#import "OOSecureURLGenerator.h"
#import "OOSignatureGenerator.h"

#import "OOCastModeOptions.h"
#import "OOCastManagerProtocol.h"
#import "OOCallbacks.h"
#import "OOModule.h"
#import "OOReturnState.h"
#import "OOUserInfo.h"
#import "OOStreamPlayerMappingCreator.h"
#import "OOStreamPlayerMappingPredicate.h"
#import "OOLifeCycle.h"
#import "OOManagedAdsPlugin.h"
#import "OOStateNotifier.h"
#import "OOAssetLoaderDelegate.h"
#import "OODeliveryTypeConstants.h"

#endif /* OoyalaSDK_h */
