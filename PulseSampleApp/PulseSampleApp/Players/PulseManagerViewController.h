//
//  PulseManagerViewController.h
//  PulseSampleApp
//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

//#import "SampleAppPlayerViewController.h"
#import "VideoItem.h"
#import <OoyalaPulseIntegration/OOPulseManager.h>

@interface PulseManagerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *playerView;

- (id)initWithVideoItem:(VideoItem *)video;

@end
