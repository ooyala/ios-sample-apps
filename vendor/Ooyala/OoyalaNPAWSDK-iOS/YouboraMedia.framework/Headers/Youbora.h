//
//  YouboraOOOoyalaPlayerViewController.h
//  YouboraAnalytics
//
//  Copyright (c) 2014 Nice. All rights reserved.
//
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOVideo.h>
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOPlayerDomain.h>

@interface Youbora: NSObject

@property (nonatomic, weak) OOOoyalaPlayer* player;
@property (nonatomic, assign) BOOL connected;

- (id)initWithSystemId:(NSString*)SYSTEM_ID userID:(NSString*)USER_ID playerInstance:(OOOoyalaPlayer*)playerInstance options:(NSDictionary*)options httpSecure:(BOOL)httpSecure;
- (void)stop;
- (void)pauseSession;
- (void)restartSession;
- (void)updateYouboraMetadata:(NSDictionary *)metadata;

- (NSString*)contentURL;
- (int)currentPlaybackTime;

@end
