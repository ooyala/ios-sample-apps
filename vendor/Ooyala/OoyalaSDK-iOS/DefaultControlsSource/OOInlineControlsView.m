/**
 * @file       OOInlineControlsView.m
 * @brief      Implementation of OOInlineControlsView
 * @details    OOInlineControlsView.m in OoyalaSDK
 * @date       1/13/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import "OOInlineControlsView.h"
#import "OOUIProgressSlider.h"
#import "OOImages.h"
#import "OOUIUtils.h"
#import "OODebugMode.h"

@interface OOInlineControlsView() {
  BOOL _playButtonShowing;
  BOOL _fullScreenButton;
  BOOL _isClosedCaptionsButtonShowing;
}
@end

@implementation OOInlineControlsView

@synthesize playButton, pauseButton, fullscreenButton, navigationBar, scrubberSlider, closedCaptionsButton;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 36, self.bounds.size.width, 36)];
    if (navigationBar) {
      navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
      navigationBar.backgroundColor = [UIColor colorWithWhite:0.19 alpha:0.62];
      [self addSubview:navigationBar];

      scrubberSlider = [[OOUIProgressSlider alloc] initWithFrame:CGRectMake(36, 8, navigationBar.bounds.size.width - 80, 20)];
      LOG(@"the frame of scrubberSlider is %@", NSStringFromCGRect(scrubberSlider.frame));
      scrubberSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
      [navigationBar addSubview:scrubberSlider];

      CGSize buttonSize = [OOUIUtils isIpad] ? CGSizeMake(45, 45) : CGSizeMake(30, 30);

      UIImage* closedCaptionsIcon =[OOImages closedCaptionsImage];
      closedCaptionsIcon = [UIImage imageWithCGImage:[closedCaptionsIcon CGImage] scale:.50 orientation:UIImageOrientationUp];

      closedCaptionsButton = [[UIButton alloc] initWithFrame:CGRectMake(navigationBar.frame.size.width-72, 0, 36, 36)];
      closedCaptionsButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
      closedCaptionsButton.showsTouchWhenHighlighted = YES;
      closedCaptionsButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
      [closedCaptionsButton setImage: closedCaptionsIcon forState:UIControlStateNormal];

      playButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 0, 36, 36)];
      playButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
      playButton.showsTouchWhenHighlighted = YES;
      playButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
      [playButton setImage:[OOImages playImage:buttonSize] forState:UIControlStateNormal];
      [navigationBar addSubview:playButton];

      pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 0, 36, 36)];
      pauseButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
      pauseButton.showsTouchWhenHighlighted = YES;
      pauseButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
      [pauseButton setImage:[OOImages pauseImage:buttonSize] forState:UIControlStateNormal];

      fullscreenButton = [[UIButton alloc] initWithFrame:CGRectMake(navigationBar.frame.size.width-36, 0, 36, 36)];
      fullscreenButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
      fullscreenButton.showsTouchWhenHighlighted = YES;
      fullscreenButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
      [fullscreenButton setImage:[OOImages maximizeImage:buttonSize]forState:UIControlStateNormal];
      [navigationBar addSubview:fullscreenButton];

      [self setPlayButtonShowing:YES];
      [self setFullscreenButtonShowing:YES];
      [self setClosedCaptionsButtonShowing:NO];
    }
  }
  return self;
}

- (BOOL)playButtonShowing {
  return _playButtonShowing;
}
  
- (void)setPlayButtonShowing:(BOOL)showing {
  _playButtonShowing = showing;
  if (showing) {
    [pauseButton removeFromSuperview];
    [navigationBar addSubview:playButton];
  } else {
    [playButton removeFromSuperview];
    [navigationBar addSubview:pauseButton];
  }
}
- (void)setFullscreenButtonShowing:(BOOL)showing {
  _fullScreenButton = showing;
  if (showing) {
    [navigationBar addSubview:fullscreenButton];
  } else {
    [fullscreenButton removeFromSuperview];
  }
}
- (BOOL)closedCaptionsButtonShowing {
  return _isClosedCaptionsButtonShowing;
}

- (void)setClosedCaptionsButtonShowing:(BOOL)showing {
  _isClosedCaptionsButtonShowing = showing;
  if (showing) {
    [closedCaptionsButton setFrame:CGRectMake(navigationBar.frame.size.width-72, 0, 36, 36)];
    [navigationBar addSubview:closedCaptionsButton];
  } else {
    [closedCaptionsButton removeFromSuperview];
  }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  for (UIView *view in self.subviews) {
    if (CGRectContainsPoint(view.frame, point)) {
      return YES;
    }
  }
  return NO;
}

// absorb touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {}

@end
