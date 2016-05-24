//
//  OOOoyalaTVPlayerViewController.h
//  OoyalaTVSkinSDK
//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OOOoyalaPlayer;

@interface OOOoyalaTVPlayerViewController : UIViewController

/*!
  @property player
  @abstract The player that will playback the video supplied through this controller.
 */
@property (strong, nonatomic) OOOoyalaPlayer *player;

/*!
	@property	showsPlaybackControls
	@abstract	Whether or not the receiver shows playback controls. Default is NO.
	@discussion	Clients can set this property to NO when they don't want to have any playback controls on top of the visual content (e.g. when the player is an inline element, with sibling views).
 */
@property (nonatomic) BOOL showsPlaybackControls;

- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player;

@end
