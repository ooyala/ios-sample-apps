#import <Foundation/Foundation.h>

#import "OOPlayerProtocol.h"
#import "OOLifeCycle.h"

/**
 * @brief An interface to implement an Ad Plugin, which can plug into the OoyalaPlayer
 * @see OOOoyalaPlayer.registerAdPlayer:forType:
 */
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
 * This is called when the ad is clicked.
 */
- (void)clickAd;

/**
 * @return non-nil (possibly empty) array of cue point times for ads.
 */
- (NSSet*/*<NSNumber int seconds>*/)getCuePointsAtSeconds;

/**
 * Called when an icon is clicked
 * @param index the index of the icon
 */
- (void)onAdIconClicked: (NSInteger) index;

@end
