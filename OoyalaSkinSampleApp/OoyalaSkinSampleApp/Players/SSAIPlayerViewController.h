//
//  SSAIPlayerViewController.h
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "SampleAppPlayerViewController.h"

@interface SSAIPlayerViewController : SampleAppPlayerViewController

#pragma mark - Public properties

@property (nonatomic, retain) IBOutlet UIView *videoView;
@property (nonatomic, retain) IBOutlet UIView *qaView;
@property (nonatomic, retain) IBOutlet UITextView *playerParams;
@property (nonatomic, retain) IBOutlet UITextView *qaLogTextView;

@end
