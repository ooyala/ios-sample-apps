//
//  OO360StreamPlayer.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "OOStreamPlayer.h"


@interface OO360StreamPlayer : OOStreamPlayer

extern NSString *const OOBaseStreamCurrentItemFailed;

@property(nonatomic, weak) OOOoyalaPlayer *notificationContext;

- (CGRect)videoRect;
- (void)detachPlayer;
- (void)attachPlayer;

@end
