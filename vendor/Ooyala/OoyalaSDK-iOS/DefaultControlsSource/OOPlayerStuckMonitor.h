//
//  OOPlayerStuckMonitor.h
//  OoyalaSDK
//
//  Created by Michael Len on 12/20/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOMoviePlayer.h"

@protocol OOPlayerStuckDelegate
- (void) onFrozen;
@end

@interface OOPlayerStuckMonitor : NSObject
@property(nonatomic) id<OOPlayerStuckDelegate> delegate;

- (id) initWithMoviePlayer: (OOMoviePlayer *)moviePlayer;
@end
