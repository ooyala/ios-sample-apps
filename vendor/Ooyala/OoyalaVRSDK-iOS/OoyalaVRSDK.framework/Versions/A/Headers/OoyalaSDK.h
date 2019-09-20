
#ifndef OoyalaSDK_h
#define OoyalaSDK_h


#import "OOOoyalaPlayer.h"
#import "OOOoyalaPlayerFacade.h"
#import "OOOoyalaPlayer+AdPluginManagement.h"
#import "OOOoyalaPlayer+Ads.h"
#import "OOOoyalaPlayer+Playback.h"
#import "OOOoyalaPlayer+AppEvents.h"
#import "OOOoyalaPlayer+PlaybackSpeed.h"
#import "OOOoyalaPlayer+Cast.h"
#import "OOOoyalaPlayer+PlaybackWorkflow.h"
#import "OOOoyalaPlayer+Channel.h"
#import "OOOoyalaPlayer+ClosedCaptions.h"
#import "OOOoyalaPlayer+MoviePlayerCreation.h"
#import "OOOoyalaPlayer+UI.h"
#import "OOOoyalaPlayer+MultiAudio.h"
#import "OOOoyalaPlayer+StateMachine.h"

#import "OOFCCTVRatingConfiguration.h"
#import "OOIQConfiguration.h"
#import "OODeviceInfo.h"
#import "OOOptions.h"
#import "OOPlayerDomain.h"
#import "OOPlayerInfo.h"
#import "OODefaultPlayerInfo.h"
#import "OODefaultAudioOnlyPlayerInfo.h"

#import "OOMetadataPulseData.h"
#import "OOMetadataIMAAd.h"

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
#import "OOVolumeButton.h"
#import "OOControlsViewController.h"
#import "OOImages.h"
#import "OOPreviousButton.h"
#import "OONextButton.h"
#import "OOPiPButton.h"
#import "OOAirPlayButton.h"

#import "OOInlineControlsView.h"
#import "OOInlineViewController.h"
#import "OOInlineControlsBottomBar.h"
#import "OOFullScreenControlsView.h"
#import "OOFullScreenViewController.h"
#import "OOFullScreenControlsBottomBar.h"
#import "OOFullScreenControlsBottomBarMainControlsView.h"
#import "OOFullScreenControlsTopBar.h"
#import "OOFullScreenControlsBottomBarVolumeView.h"
#import "OOVolumeSliderView.h"
#import "OOTimeSliderDelegate.h"
#import "OOTimeSliderProtocol.h"
#import "OOProgressSliderView.h"

#import "OOAnalyticsPluginBaseImpl.h"

// Audio
#import "OOAudioSession.h"

#else

// TVOS GVR
#import "OOOoyalaSimpleTVPlayerViewController.h"

#endif

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
#import "OOAuthCode.h"
#import "OOClosedCaptionsItem.h"
#import "OOUnbundledVideo.h"
#import "OOOfflineVideo.h"
#import "OOPlayableItem.h"
#import "OOFCCTVRating.h"
#import "OOMultiAudioProtocol.h"
#import "OOAudioTrackProtocol.h"
#import "OOMarker.h"

// Offline
#if !TARGET_OS_TV // Check is tvOS

#import "OOAssetDownloadOptions.h"
#import "OOAssetDownloadStream.h"
#import "OODtoAsset.h"

#endif

// API access classes
#import "OODiscoveryManager.h"
#import "OODiscoveryOptions.h"
#import "OOOoyalaAPIClient.h"

// Utils classes
#import "OODebugMode.h"
#import "OOOoyalaError.h"
#import "OOOoyalaErrorCode.h"
#import "OOOrderedDictionary.h"
#import "OOTBXML.h"

// Signature generation classes
#import "OOEmbeddedSecureURLGenerator.h"
#import "OOEmbeddedSignatureGenerator.h"
#import "OOEmbedTokenGenerator.h"
#import "OOSecureURLGenerator.h"
#import "OOSignatureGenerator.h"

#import "OOFairplayContentKeyDelegate.h"

#import "OOCastModeOptions.h"
#import "OOCastManagerProtocol.h"
#import "OOCallbacks.h"
#import "OOModule.h"
#import "OOStreamPlayerMappingCreator.h"
#import "OOStreamPlayerMappingPredicate.h"
#import "OOLifeCycle.h"
#import "OOManagedAdsPlugin.h"
#import "OOStateNotifier.h"
#import "OOPlayerState.h"
#import "OOAssetLoaderDelegate.h"
#import "OODeliveryTypeConstants.h"

#endif /* OoyalaSDK_h */
