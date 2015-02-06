//
//  OOPlayerStuckMonitor.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOMoviePlayer.h"

@protocol OOPlayerStuckDelegate
- (void) onFrozen;
@end

@interface OOPlayerStuckMonitor : NSObject
@property(nonatomic, assign) id<OOPlayerStuckDelegate> delegate;

- (id) initWithMoviePlayer: (OOMoviePlayer *)moviePlayer;
@end
