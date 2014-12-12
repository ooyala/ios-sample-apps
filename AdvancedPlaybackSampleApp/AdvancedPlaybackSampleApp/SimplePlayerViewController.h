//
//  DetailViewController.h
//  AdvancedPlaybackSampleApp
//
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimplePlayerViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

 @property (nonatomic, retain) IBOutlet UIView *ooyalaPlayerView;
@end

