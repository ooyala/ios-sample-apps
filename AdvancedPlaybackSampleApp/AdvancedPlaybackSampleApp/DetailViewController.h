//
//  DetailViewController.h
//  AdvancedPlaybackSampleApp
//
//  Created by Michael Len on 12/2/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

