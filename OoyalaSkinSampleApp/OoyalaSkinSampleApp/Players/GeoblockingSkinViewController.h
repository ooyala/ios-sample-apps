//
//  GeoblockingSkinViewController.h
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OoyalaSDK/OoyalaSDK.h>
#import "SampleAppPlayerViewController.h"

@interface GeoblockingSkinViewController : SampleAppPlayerViewController <OOEmbedTokenGenerator>

#pragma mark - Public properties

@property (nonatomic, retain) IBOutlet UIView *videoView;
@property (nonatomic, retain) IBOutlet UILabel *textLabel;

@end
