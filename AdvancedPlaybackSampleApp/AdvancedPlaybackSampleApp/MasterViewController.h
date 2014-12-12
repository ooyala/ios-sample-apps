//
//  MasterViewController.h
//  AdvancedPlaybackSampleApp
//
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimplePlayerViewController;

@interface MasterViewController : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) SimplePlayerViewController *detailViewController;


@end

