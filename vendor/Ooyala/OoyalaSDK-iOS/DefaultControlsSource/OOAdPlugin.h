/**
 * @class      OOAdPlugin OOAdPlugin.h "OOAdPlugin.h"
 * @brief      OOAdPlugin
 * @details    OOAdPlugin.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

#import "OOPlayerProtocol.h"
#import "OOLifeCycle.h"

@protocol OOAdPlugin<NSObject, OOLifeCycle>

/**
 * This is called when content changed
 *
 * @return true if plugin want to enter admode, false otherwise
 */
- (BOOL)onContentChanged;

/**
 * This is called before start playing content so plugin can play preroll
 *
 * @return true if plugin want to enter admode, false otherwise
 */
- (BOOL)onInitialPlay;

/**
 * This is called when playhead is updated so plugin can play midroll
 *
 * @return true if plugin want to enter admode, false otherwise
 */
- (BOOL)onPlayheadUpdate:(Float64)playhead;

/**
 * This is called before finishing playing content so plugin can play postroll
 *
 * @return true if plugin want to enter admode, false otherwise
 */
- (BOOL)onContentFinished; // put your postrolls here

/**
 * This is called when a cue point is reached so plugin can play midroll
 *
 * @return true if plugin want to enter admode, false otherwise
 */
- (BOOL)onCuePoint:(int)cuePointIndex;

/**
 * This is called when an error occured when playing back content
 *
 * @return true if plugin want to enter admode, false otherwise
 */
- (BOOL)onContentError:(int)errorCode;

/**
 * This is called when control is handed over to the plugin
 *
 * @param token
 *          passed from plugin in previous calls.
 */
- (void)onAdModeEntered;

/**
 * This is called ooyala UI pass down UI related events.
 *
 * @return an object that implements PlayerInterface if plugin needs to
 *         process ui events, null if these events should be ignored.
 */
- (id<OOPlayerProtocol>)player;

/**
 * This is called to reset all ads to unplayed.
 */
- (void)resetAds;

/**
 * This is called to skip the current ad.
 *
 */
- (void)skipAd;

/**
 * @return non-nil (possibly empty) array of cue point times for ads.
 */
- (NSSet*/*<NSNumber int seconds>*/)getCuePointsAtSeconds;

@end
