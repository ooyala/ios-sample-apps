//
//  YouboraOOOoyalaPlayerViewController.h
//  YouboraAnalytics
//
//  Copyright (c) 2014 Nice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OoyalaSDK/OOOoyalaError.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OOVideo.h>
#import <OoyalaSDK/OOStream.h>
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>


@interface Youbora: NSObject

@property (nonatomic, strong) OOOoyalaPlayerViewController* playerController;
@property (nonatomic, assign) BOOL connected;

- (NSString*)contentURL;
- (int)currentPlaybackTime;
- (void)updateYouboraMetadata:(NSDictionary *)metadata;
- (id)initWithSystemId:(NSString*)SYSTEM_ID userID:(NSString*)USER_ID playerInstance:(OOOoyalaPlayerViewController*)playerInstance options:(NSDictionary*)options;
- (void)stop;
- (void)pauseSession;
- (void)restartSession;

+ (void)load:(NSString*)system user:(NSString*)user isLiveResource:(BOOL)isLive metadata:(NSDictionary*)metadata transaction:(NSString *)trans analyticsActive:(BOOL)analyticsActive;
+ (void)dismissPlayerViewController:(Youbora*)playerVC;
- (NSDictionary*)prepareMetadata:(NSURL *)url;

@end
