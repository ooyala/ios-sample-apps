//
//  OOBaseMoviePlayer.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "OOStreamPlayer.h"

@interface OOBaseStreamPlayer : OOStreamPlayer

@property(nonatomic, weak) OOOoyalaPlayer *notificationContext;

- (BOOL)setupWithUrl:(NSURL *)url;

- (CGRect)videoRect;
- (void)detachPlayer;
- (void)attachPlayer;

@end
