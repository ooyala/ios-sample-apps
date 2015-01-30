/**
 * @class      OOAuthHeartbeat OOAuthHeartbeat.h "OOAuthHeartbeat.h"
 * @brief      OOAuthHeartbeat
 * @details    OOAuthHeartbeat.h in OoyalaSDK
 * @date       11/21/11
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOPlayerAPIClient.h"

@class OOAuthHeartbeat;

@protocol OOAuthHeartbeatDelegate
- (void) stopPlaybackOnHeartbeatFailure: (OOAuthHeartbeat *) sender;
@end

@interface OOAuthHeartbeat : NSObject

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) OOPlayerAPIClient *apiClient;
@property (nonatomic, assign) id <OOAuthHeartbeatDelegate> delegate;

- (id)initWithApiClient:(OOPlayerAPIClient *)api;

- (void)start;
- (void)stop;
- (void)authHeartbeatTimerTask;
- (void)tryHeartbeatWithRetries:(int)retries;

@end



