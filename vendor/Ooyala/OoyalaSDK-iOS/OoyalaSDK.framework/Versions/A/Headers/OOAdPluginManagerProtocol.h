//
//  OOAdPluginManagerProtocol.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOAdPlugin.h"

/**
 * Defines player behavior after video playback has ended, defaults to OOOoyalaPlayerActionAtEndContinue
 */
typedef enum
{
  OOAdModeNone,
  OOAdModeContentChanged,
  OOAdModeInitialPlay,
  OOAdModePlayhead,
  OOAdModeCuePoint,
  OOAdModeContentFinished,
  OOAdModeContentError,
  OOAdModePluginInitiated
} OOAdMode;

@protocol OOAdPluginManagerProtocol

/**
 * Register an Ad plugin
 *
 * @param plugin
 *          the plugin to be registered
 * @return true on success, false otherwise
 */
- (BOOL)registerPlugin:(id<OOAdPlugin>)plugin;

/**
 * deregister an Ad plugin
 *
 * @param plugin
 *          the plugin to be deregistered
 * @return true on success, false otherwise
 */
- (BOOL)deregisterPlugin:(id<OOAdPlugin>)plugin;

/**
 * called when plugin exits ad mode
 *
 * @param plugin
 *          the plugin that exits
 * @return true on success, false otherwise
 */
- (BOOL)exitAdMode:(id<OOAdPlugin>)plugin;

/**
 * called when plugin request ad mode
 *
 * @param plugin
 *          the plugin that request ad mode
 * @return true on success, false otherwise
 */
- (BOOL)requestAdMode:(id<OOAdPlugin>)plugin;

/**
 * Determine which ad plugin, if any, has control of the OoyalaPlayer
 *
 * @return the ad plugin which currently is in Ad Mode, or nil if no plugin is in ad mode
 */
- (id<OOAdPlugin>)activeAdPlugin;
@end
