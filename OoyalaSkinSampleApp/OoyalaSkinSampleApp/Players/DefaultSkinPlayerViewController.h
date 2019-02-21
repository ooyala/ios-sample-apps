//
//  MasterViewController.h
//  OoyalaSkin
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "SampleAppPlayerViewController.h"

@interface DefaultSkinPlayerViewController : SampleAppPlayerViewController

#pragma mark - Public properties

@property (nonatomic, retain) IBOutlet UIView *videoView;
@property (nonatomic, retain) IBOutlet UILabel *textLabel;

@end
