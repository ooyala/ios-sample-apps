//
//  PulseManagerViewController.h
//  PulseSampleApp
//
//  Created by Jacques du Toit on 03/02/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

//#import "SampleAppPlayerViewController.h"
#import "VideoItem.h"
#import <OoyalaPulseIntegration/OOPulseManager.h>

@interface PulseManagerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *playerView;

- (id)initWithVideoItem:(VideoItem *)video;

@end
