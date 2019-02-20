//
//  ListOfVideosFactory.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "ListOfVideosFactory.h"
#import "DefaultVideoPlayerViewController.h"
#import "IMAVideoPlayerViewController.h"
#import "VideoPlayerViewModel.h"
#import "CustomVideoViewController.h"
#import "CustomVideoViewModel.h"
#import "VideoItem.h"

@implementation ListOfVideosFactory

#pragma mark - Public functions

- (UIViewController *)viewControllerWithVideoItem:(VideoItem *)videoItem
                                            pcode:(NSString *)pcode
                                           domain:(NSString *)domain
                                    QAModeEnabled:(BOOL)QAModeEnabled {
  UIViewController *configuredViewController;

  switch (videoItem.videoAdType) {
    case IMA:
      configuredViewController = [self createIMAViewPlayerModule:videoItem
                                                           pcode:pcode
                                                          domain:domain
                                                andQAModeEnabled:QAModeEnabled];
      break;
      
    default:
      configuredViewController = [self createDefaultVideoPlayerModuleWithVideoItem:videoItem
                                                                             pcode:pcode
                                                                            domain:domain
                                                                  andQAModeEnabled:QAModeEnabled];
      break;
  }
  
  return configuredViewController;
}

- (UIViewController *)configuredCustomVideoViewControllerWithCompletion:(void (^)(NSString *pCode, NSString *embedCode))completion {
  CustomVideoViewModel *videoPlayerViewModel = [CustomVideoViewModel new];
  CustomVideoViewController *customVideoViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomVideoViewController"];
  
  customVideoViewController.viewModel = videoPlayerViewModel;
  videoPlayerViewModel.delegate = customVideoViewController;
  videoPlayerViewModel.completionBlock = completion;
  
  return customVideoViewController;
}

#pragma mark - Private functions

- (UIViewController *)createDefaultVideoPlayerModuleWithVideoItem:(VideoItem *)videoItem
                                                            pcode:(NSString *)pcode
                                                           domain:(NSString *)domain
                                                 andQAModeEnabled:(BOOL)QAModeEnabled {
  
  VideoPlayerViewModel *videoPlayerViewModel = [[VideoPlayerViewModel alloc] initWithVideoItem:videoItem
                                                                                         pcode:pcode
                                                                                        domain:domain
                                                                              andQAModeEnabled:QAModeEnabled];

  DefaultVideoPlayerViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DefaultVideoPlayerViewController"];
  
  viewController.viewModel = videoPlayerViewModel;

  return viewController;
}

- (UIViewController *)createIMAViewPlayerModule:(VideoItem *)videoItem
                                                            pcode:(NSString *)pcode
                                                           domain:(NSString *)domain
                                                 andQAModeEnabled:(BOOL)QAModeEnabled {
  
  VideoPlayerViewModel *videoPlayerViewModel = [[VideoPlayerViewModel alloc] initWithVideoItem:videoItem
                                                                                         pcode:pcode
                                                                                        domain:domain
                                                                              andQAModeEnabled:QAModeEnabled];

  IMAVideoPlayerViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"IMAVideoPlayerViewController"];
  
  viewController.viewModel = videoPlayerViewModel;
  
  return viewController;
}

@end
