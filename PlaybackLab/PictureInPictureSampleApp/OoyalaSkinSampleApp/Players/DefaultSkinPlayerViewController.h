//
//  MasterViewController.h
//  OoyalaSkin
//
//  Created by Zhihui Chen on 6/3/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleAppPlayerViewController.h"

@interface DefaultSkinPlayerViewController : SampleAppPlayerViewController


@property (nonatomic, retain) IBOutlet UIView *videoView;

@property (nonatomic, retain) IBOutlet UILabel *textLabel;

@end
