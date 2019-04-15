//
//  SSAIPlayerViewController.h
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "SampleAppPlayerViewController.h"

@interface SSAIPlayerViewController : SampleAppPlayerViewController

#pragma mark - Public properties

@property (nonatomic) IBOutlet UIView *videoView;
@property (nonatomic) IBOutlet UIView *qaView;
@property (nonatomic) IBOutlet UITextView *playerParams;
@property (nonatomic) IBOutlet UITextView *qaLogTextView;

@end
