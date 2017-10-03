//
//  IMAPlayerViewController.h
//  OoyalaSkinSampleApp
//
//  Created by Zhihui Chen on 7/29/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleInteractiveMediaAds/GoogleInteractiveMediaAds.h>
#import <OoyalaIMASDK/OOIMAManager.h>
#import "SampleAppPlayerViewController.h"


@interface IMAPlayerViewController : SampleAppPlayerViewController<OOIMAAdsManagerDelegate>

@property (nonatomic, retain) IBOutlet UIView *videoView;

@property (nonatomic, retain) IBOutlet UILabel *textLabel;

@end
