//
//  YouboraOOOoyalaPlayerViewController.h
//  YouboraAnalytics
//
//  Created by Joan Biscarri on 05/08/14.
//  Copyright (c) 2014 Nice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOOoyalaError.h"
#import "OOOoyalaPlayer.h"
#import "OOPlayerDomain.h"
#import "OOVideo.h"
#import "OOStream.h"
#import "OOOoyalaPlayerViewController.h"


@interface YouboraOOOoyalaPlayerViewController : OOOoyalaPlayerViewController


- (NSString*)contentURL;
- (int)currentPlaybackTime;
- (void)setOptions:(NSDictionary *)options;

+ (void)load:(NSString*)system user:(NSString*)user isLiveResource:(BOOL)isLive metadata:(NSDictionary*)metadata transaction:(NSString *)trans analyticsActive:(BOOL)analyticsActive;
+ (void)dismissPlayerViewController:(YouboraOOOoyalaPlayerViewController*)playerVC;


@end
