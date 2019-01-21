//
//  CustomVideoViewController.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomVideoViewModel.h"

@interface CustomVideoViewController : UIViewController <CustomVideoViewModelDelegate>

@property (nonatomic) CustomVideoViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
