//
//  OOWidevinePlayer.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "OOMoviePlayer.h"
#import "OOPlayerStuckMonitor.h"

@interface OOWidevinePlayer : OOMoviePlayer <OOPlayerStuckDelegate>
- (id) initWithVideo:(OOVideo*)video streamType:(NSString*)streamType pcode:(NSString*)pcode authToken:(NSString*)authToken;
@end
