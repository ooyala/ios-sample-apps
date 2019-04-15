//
//  IMAPlayerViewController.h
//  OoyalaSkinSampleApp
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <OoyalaIMASDK/OOIMAManager.h>
#import "SampleAppPlayerViewController.h"

@interface IMAPlayerViewController : SampleAppPlayerViewController<OOIMAAdsManagerDelegate>

#pragma mark - Public properties

@property (nonatomic) IBOutlet UIView *videoView;
@property (nonatomic) IBOutlet UILabel *textLabel;

@end
