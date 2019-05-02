//
//  IMAAdDisplayContainer.h
//  GoogleIMA3
//
//  Copyright (c) 2014 Google Inc. All rights reserved.
//
//  Declares the IMAAdDisplayContainer interface that manages the views,
//  ad slots, and displays used for ad playback.

#import <UIKit/UIKit.h>

/**
 *  The IMAAdDisplayContainer is responsible for managing the ad container view
 *  and companion ad slots used for ad playback.
 */
@interface IMAAdDisplayContainer : NSObject

/**
 *  View containing the video display and ad related UI. This view must be present in the view
 *  hierarchy in order to make ad or stream requests.
 */
@property(nonatomic, strong, readonly) UIView *adContainer;

/**
 *  List of companion ad slots. Can be nil or empty.
 */
@property(nonatomic, copy, readonly) NSArray *companionSlots;

/**
 *  Initializes IMAAdDisplayContainer for rendering the ad and displaying the ad UI without any
 *  companion slots.
 *
 *  @param adContainer    the UIView where the ad will be rendered. Fills the view's bounds.
 *
 *  @return the IMAAdDisplayContainer instance
 */
- (instancetype)initWithAdContainer:(UIView *)adContainer;

/**
 *  Initializes IMAAdDisplayContainer for rendering the ad and displaying the ad UI.
 *
 *  @param adContainer    the UIView where the ad will be rendered. Fills the view's bounds.
 *  @param companionSlots the array of IMACompanionAdSlots. Can be nil or empty.
 *
 *  @return the IMAAdDisplayContainer instance
 */
- (instancetype)initWithAdContainer:(UIView *)adContainer
                     companionSlots:(NSArray *)companionSlots NS_DESIGNATED_INITIALIZER;

/**
 * :nodoc:
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 *  Registers your application's video playback controls that will overlay this container. Multiple
 *  controls may be registered with this method.
 *  WARNING: It is critical that this UI obscure as little ad space as possible so that viewabilty
 *  measurement isn't impacted.
 *
 *  @param videoControlsOverlay Small or mostly transparent video controls presented over the
 *      container.
 */
- (void)registerVideoControlsOverlay:(UIView *)videoControlsOverlay;

/**
 *  Unregisters all previously registered video controls overlays.
 */
- (void)unregisterAllVideoControlsOverlays;

@end
