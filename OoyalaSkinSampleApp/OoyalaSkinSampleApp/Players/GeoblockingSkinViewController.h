//
//  GeoblockingSkinViewController.h
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import <OoyalaSDK/OoyalaSDK.h>
#import "SampleAppPlayerViewController.h"

@interface GeoblockingSkinViewController : SampleAppPlayerViewController <OOEmbedTokenGenerator>

#pragma mark - Public properties

@property (nonatomic) IBOutlet UIView *videoView;
@property (nonatomic) IBOutlet UILabel *textLabel;

@end
