//
//  OO360StreamPlayer.h
//  OoyalaVRSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "OOStreamPlayer.h"

@interface OO360StreamPlayer : OOStreamPlayer

#pragma mark - Public functions

- (void)switchVideoType;
- (CGRect)videoRect;
- (void)detachPlayer;
- (void)attachPlayer;

@end
