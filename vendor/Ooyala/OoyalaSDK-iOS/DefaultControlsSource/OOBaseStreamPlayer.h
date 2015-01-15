//
//  OOBaseMoviePlayer.h
//  OoyalaSDK
//
//  Created by Chris Leonavicius on 11/14/12.
//  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
//

#import "OOStreamPlayer.h"

@interface OOBaseStreamPlayer : OOStreamPlayer
- (BOOL)setupWithUrl:(NSURL *)url;

- (CGRect)videoRect;
- (void)detachPlayer;
- (void)attachPlayer;

@end
