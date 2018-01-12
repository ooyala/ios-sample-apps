//
//  CustomVideoTransitionManager.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "CustomVideoTransitionManager.h"
#import "CustomVideoViewController.h"


@interface CustomVideoTransitionManager ()

@property (nonatomic) BOOL presenting;

@end


@implementation CustomVideoTransitionManager

#pragma mark - Private functions

- (void)offStageAnimationViewController:(UIViewController *)animationViewController {
  CustomVideoViewController *customVideoViewController = (CustomVideoViewController *)animationViewController;
  
  customVideoViewController.view.alpha = 0;
  customVideoViewController.containerView.alpha = 0;
  customVideoViewController.containerView.transform = CGAffineTransformMakeTranslation(0, UIScreen.mainScreen.bounds.size.height);
}

- (void)onStageAnimationViewController:(UIViewController *)animationViewController {
  CustomVideoViewController *customVideoViewController = (CustomVideoViewController *)animationViewController;
  
  customVideoViewController.view.alpha = 1;
  customVideoViewController.containerView.alpha = 1;
  customVideoViewController.containerView.transform = CGAffineTransformIdentity;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIView *container = transitionContext.containerView;
  
  
  UIViewController *vcFrom = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *vcTo = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

  UIViewController *animationViewController;
  UIViewController *bottomViewController;
  
  if (self.presenting) {
    animationViewController = vcTo;
    bottomViewController    = vcFrom;
  } else {
    animationViewController = vcFrom;
    bottomViewController    = vcTo;
  }
  
  UIView *animationView = animationViewController.view;
  UIView *bottomView = animationViewController.view;

  if (self.presenting) {
    [self offStageAnimationViewController:animationViewController];
  }
  
  [container addSubview:bottomView];
  [container addSubview:animationView];
  
  [UIView animateWithDuration:[self transitionDuration:transitionContext]
                        delay:0
                      options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        if (self.presenting) {
                          [self onStageAnimationViewController:animationViewController];
                        } else {
                          [self offStageAnimationViewController:animationViewController];
                        }
                      } completion:^(BOOL finished) {
                        [UIApplication.sharedApplication.keyWindow addSubview:vcTo.view];
                        
                        [transitionContext completeTransition:YES];
                      }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.33;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
  self.presenting = YES;
  
  return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  self.presenting = NO;
  
  return self;
}


@end
