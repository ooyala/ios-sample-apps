//
//  PlayerViewController.h
//  OoyalaSkin
//
//  Created on 6/3/15.
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

#import "SampleAppPlayerViewController.h"

@class OOSkinViewController;
@class OOOoyalaPlayer;
@class DemoSettings;

@interface PlayerViewController : SampleAppPlayerViewController

@property (nonatomic, retain) IBOutlet UIView *videoView;

@property (nonatomic, retain) IBOutlet UILabel *textLabel;

@property (nonatomic, retain) OOSkinViewController *skinController;
@property (nonatomic, retain) OOOoyalaPlayer *ooyalaPlayer;

- (void)setCustomSkin;
- (void)replayCurrentVideo;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@property DemoSettings *configuration;

@end
