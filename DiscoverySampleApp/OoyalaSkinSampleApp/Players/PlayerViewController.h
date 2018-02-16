//
//  MasterViewController.h
//  OoyalaSkin
//
//  Created by Zhihui Chen on 6/3/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleAppPlayerViewController.h"
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import <OoyalaSDK/OoyalaSDK.h>
#import "DemoSettings.h"
//#import "MainView.h"

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
