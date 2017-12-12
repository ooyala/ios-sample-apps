//
//  FreewheelPlayerViewController.h
//  OoyalaSkinSampleApp
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SampleAppPlayerViewController.h"


@interface FreewheelPlayerViewController : SampleAppPlayerViewController

#pragma mark - Public properties

@property (nonatomic, retain) IBOutlet UIView *videoView;

@property (nonatomic, retain) IBOutlet UILabel *textLabel;

@end
