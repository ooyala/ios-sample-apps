//
//  NielsenAppApi.h
//  NielsenID3Meter
//
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

/**
 Notification Names
 */
#define kNielsenApiNotifyError @"kNol_notifyAppApiErrorStatusUpdate"
#define kNielsenApiNotifyEvent @"kNol_notifyAppApiEventStatusUpdate"

/**
 Nielsen web view close command
 */
#define kNielsenWebClose @"nielsen://close"

@interface NielsenAppApi : NSObject

//
// R2 Api
//

//Singleton class that invokes the post data play head position.
+ (NielsenAppApi*)sharedInstance;
/**
 Initializes the ID3Meter metering framework.
 @param appInfo A JSON string includes identifications of the app.
 @param tagMapping A JSON string includes tag mapping of the client.
 @returns returns (id) pointer to object of a Meter object; nil if error occurred.
 */
- (id)initWithAppInfo:(NSString*)appInfo;

/**
 Retrieve Nielsen ID for user opt-in or opt-out purpose.
 @param N/A
 */
- (NSString *)getNielsenId;

/**
 Start playing a content.
 @param channelInfo A JSON string includes metadata of the channel; This should be availabe when user tap the play button.
 */
- (void)play:(NSString*)channelInfo;

/**
 Load metadata from content.
 @param jsonMetadata A JSON string includes metadata of either the content or ad. If available, metadata should come from video server or from ad manager before, during, or after a content. And, app may need to reformat it to json string per requirement from Nielsen
 */
- (void)loadMetadata:(NSString*)jsonMetadata;

/**
 Stop or pause playing a content.
 */
- (void)stop;

/**
 Current playhead position.
 @param playheadPos A long integer value represents offset in second from the beginning of the content
 */
- (void)playheadPosition:(long long)playheadPos;

/**
 Send Nielsen ID3 tag data.
 @param data A string captured from ID3 PRIV info field
 */
- (void)sendID3:(NSString *)data;

/**
 Disable metering for the app.
 @param bDisable Boolean to disable
 */
- (void)appDisableApi:(BOOL)apiDisable;

/**
 Get the URL of the web page that is used for giving user a chance to
 opt out from the Nielsen measurements.
 */
- (NSString*)optOutURLString;

/**
 Disable metering for the app due to user opt out.
 @param optOut string to disable or enable
 */
- (BOOL)userOptOut:(NSString *)optOut;

/**
 Queries the Nielsen App Api version information.
 @returns NSString containing the version details.
 */
+ (NSString *)getMeterVersion;


/**
 Queries the Nielsen App Api framework for the last event that occurred.
 @returns an JSON string with the event information:
 */
+ (NSString *)getLastEvent;

/**
 Queries the Nielsen App Api framework for the last event that occurred.
 @returns an NSDictionary object with the event information:
 */
+ (NSDictionary *)getLastOccurredEvent;


/**
 Queries the Nielsen App Api framework for the last error that occurred.
 @returns an NSDictionary object with the error information:
 */
+ (NSDictionary *)getLastOccurredError;

@end

