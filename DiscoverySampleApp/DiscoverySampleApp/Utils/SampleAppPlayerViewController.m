//
//  SampleAppPlayerViewController.m
//  DiscoverySampleApp
//
//  Created on 15/04/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import "SampleAppPlayerViewController.h"
#import "PlayerSelectionOption.h"

@interface SampleAppPlayerViewController (GestureDelegate) <UIGestureRecognizerDelegate>

@end

@implementation SampleAppPlayerViewController

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  if (self = [super init]) {
    _playerSelectionOption = playerSelectionOption;
  }
  return self;
}

- (IBAction)onButtonClick:(NSString*)videoTitle {}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
  }
}

@end

@implementation SampleAppPlayerViewController (GestureDelegate)

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  return NO;
}

@end
