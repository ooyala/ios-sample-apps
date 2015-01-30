//
//  OOWidevinePlayer.h
//  OoyalaSDK
//
//  Created by Chris Leonavicius on 8/2/12.
//  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
//

#import "OOMoviePlayer.h"
#import "OOPlayerStuckMonitor.h"

@interface OOWidevinePlayer : OOMoviePlayer <OOPlayerStuckDelegate>
- (id) initWithVideo:(OOVideo*)video streamType:(NSString*)streamType pcode:(NSString*)pcode authToken:(NSString*)authToken;
@end
