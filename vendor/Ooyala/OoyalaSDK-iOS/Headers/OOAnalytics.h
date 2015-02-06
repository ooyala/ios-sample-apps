/**
 * @class      OOAnalytics OOAnalytics.h "OOAnalytics.h"
 * @brief      OOAnalytics
 * @details    OOAnalytics.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OOOoyalaAPIClient.h"

/**
 * Ooyala analytics implementation.
 * Normally used internally by Ooyala SDK and doesn't need to be referenced by app code.
 */
@interface OOAnalytics : NSObject <UIWebViewDelegate>

@property(readonly, nonatomic) BOOL ready;  /**< @internal YES if OOAnalytics is ready to accept events, NO if not */
@property(readonly, nonatomic) BOOL failed; /**< @internal YES if OOAnalytics failed to load, NO if not */
@property(nonatomic, strong) NSString *userAgent;

/** @internal
 * Initialize an OOAnalytics using the specified api and module params
 * @param[in] api the API to initialize this OOAnalytics with
 * @param[in] moduleParams additional ModuleParams to initialize Analytics with
 * @returns the initialized OOAnalytics
 */
- (id)initWithAPI:(OOOoyalaAPIClient *)api moduleParams:(NSDictionary *)moduleParams;

/** @internal
 * Initialize an OOAnalytics using the specified api and HTML
 * @note [jigish]: this is here purely to be able to test this class
 * @param[in] api the API to initialize this OOAnalytics with
 * @param[in] embedHTML the HTML to use when initializing this OOAnalytics
 * @returns the initialized OOAnalytics
 */
- (id)initWithAPI:(OOOoyalaAPIClient *)api embedHTML:(NSString *)theEmbedHTML;

/**
 * Report a new video being initialized with the given embed code and duration
 * @param[in] embedCode the embed code of the new video
 * @param[in] duration the duration (in seconds) of the new video
 */
- (void)initializeVideoWithEmbedCode:(NSString *)embedCode duration:(NSNumber *)duration;

/**
 * Report a playhead update to the specified time
 * @param[in] time the new playhead time (in seconds)
 */
- (void)reportPlayheadUpdateToTime:(NSNumber *)time;

/**
 * Report that the player was asked to play
 */
- (void)reportPlayRequested;

/**
 * Report that the player has started playing
 */
- (void)reportPlayStarted;

/**
 * Report that the player was asked to replay
 */
- (void)reportReplay;

/** @internal
 * Delegate method for UIWebView for when the UIWebView finishes loading
 * @param[in] webView the UIWebView that finished loading
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView;

/** @internal
 * Delegate method for UIWebView for when the UIWebView fails to load
 * @param[in] webView the UIWebView that failed to load
 * @param[in] error the NSError explaining the failure
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

/**
 * Sets a tag for custom analytics
 * @param[in] tags
 */
- (void)setTags:(NSArray *)tags;

@end
