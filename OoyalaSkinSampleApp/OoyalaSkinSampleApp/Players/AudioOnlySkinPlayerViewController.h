//
//  AudioOnlySkinPlayerViewController.h
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "SampleAppPlayerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioOnlySkinPlayerViewController : SampleAppPlayerViewController

@property (weak, nonatomic) IBOutlet UIView *audioPlayerContainerView;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@end

NS_ASSUME_NONNULL_END
