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

@property (nonatomic) IBOutlet UIView *videoView;

@property (nonatomic) IBOutlet UILabel *textLabel;

@property (nonatomic) OOSkinViewController *skinController;
@property (nonatomic) OOOoyalaPlayer *ooyalaPlayer;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;
@property (nonatomic) DemoSettings *configuration;

- (void)setCustomSkin;

@end
