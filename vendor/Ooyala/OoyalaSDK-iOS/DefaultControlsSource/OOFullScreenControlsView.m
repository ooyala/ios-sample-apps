/**
 * @file       OOFullScreenControlsView.m
 * @brief      Implementation of OOFullScreenControlsView
 * @details    OOFullScreenControlsView.m in OoyalaSDK
 * @date       1/10/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import "OOFullScreenControlsView.h"
#import "OOVolumeView.h"
#import "OOUIProgressSlider.h"
#import "OOImages.h"
#import "OOUIUtils.h"

@interface OOFullScreenControlsView() {
  BOOL _playButtonShowing;
  BOOL _isClosedCaptionsButtonShowing;
}
@property (nonatomic) UINavigationBar *navigationBar;
@property (nonatomic) UINavigationItem *navigationItem;
@property (nonatomic) UIBarButtonItem *fixedSpace;
@property (nonatomic) UIBarButtonItem *flexibleSpace;

- (void)initVolumeView;
- (void)initNavigationBar;

@end

@implementation OOFullScreenControlsView

@synthesize scrubberSlider, doneButton, videoGravityFillButton, videoGravityFitButton;
@synthesize playButton, pauseButton, nextButton, previousButton, closedCaptionsButton;
@synthesize volumeView, navigationBar, navigationItem, fixedSpace, flexibleSpace;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    
    [self initVolumeView];
    [self initNavigationBar];
  }
  return self;
}

- (void)initVolumeView {
  float width = [OOUIUtils isIpad] ? 400 : 300;
  float height = [OOUIUtils isIpad] ? 100 : 100;
  float marginBottom = [OOUIUtils isIpad] ? 100 : 30;
  volumeView = [[OOVolumeView alloc] initWithFrame:CGRectMake((self.bounds.size.width - width) / 2, self.bounds.size.height - height - marginBottom, width, height)];
  
  if (volumeView) {
    [volumeView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin];
    
    fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 20;
    
    flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    CGSize buttonSize = [OOUIUtils isIpad] ? CGSizeMake(30, 30) : CGSizeMake(40, 40);
    playButton = [[UIBarButtonItem alloc] initWithImage:[OOImages playImage:buttonSize] style:UIBarButtonItemStylePlain target:nil action:nil];
    pauseButton = [[UIBarButtonItem alloc] initWithImage:[OOImages pauseImage:buttonSize] style:UIBarButtonItemStylePlain target:nil action:nil];
    nextButton = [[UIBarButtonItem alloc] initWithImage:[OOImages nextImage:buttonSize] style:UIBarButtonItemStylePlain target:nil action:nil];
    previousButton = [[UIBarButtonItem alloc] initWithImage:[OOImages previousImage:buttonSize] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self setPlayButtonShowing:YES];
    
    [self addSubview:volumeView];
  }
}

- (void)initNavigationBar {
  navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.bounds.size.width, 44)];
  if (navigationBar) {
    [navigationBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [navigationBar setBarStyle:UIBarStyleBlack];
    [navigationBar setTranslucent:YES];
    [self addSubview:navigationBar];
    
    navigationItem = [[UINavigationItem alloc] init];
    
    doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
    
    scrubberSlider = [[OOUIProgressSlider alloc] initWithFrame:CGRectMake(0, 0, navigationBar.bounds.size.width - 100, 20)];
    scrubberSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    navigationItem.titleView = scrubberSlider;
    
    navigationItem.leftBarButtonItem = doneButton;
    
    UIImage* closedCaptionsIcon = [OOImages closedCaptionsImage];
    closedCaptionsIcon = [UIImage imageWithCGImage:[closedCaptionsIcon CGImage] scale:3.0 orientation:UIImageOrientationUp];
    closedCaptionsButton = [[UIBarButtonItem alloc] initWithImage:closedCaptionsIcon style:UIBarButtonItemStylePlain target:nil action:nil];

    UIImage* fillGravityIcon = [OOUIUtils imageFromBase64String:@"iVBORw0KGgoAAAANSUhEUgAAADIAAAAkCAMAAAD8bpkFAAAAA3NCSVQICAjb4U/gAAAAdVBMVEX////////////////////////////////////////////////7+/vz8/Pl5eXi4uLR0dHPz8/MzMywsLCtra2SkpKQkJCLi4txcXFvb29qampMTExKSkozMzMwMDAuLi4dHR0bGxsZGRkMDAwLCwsEBAQAAAAhv2x2AAAAJ3RSTlMAESIzd4iZu8zd7v////////////////////////////////////85tMfTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAHnRFWHRTb2Z0d2FyZQBBZG9iZSBGaXJld29ya3MgQ1M1LjGrH0jrAAAAFHRFWHRDcmVhdGlvbiBUaW1lADQvNi8xMp+x7PQAAAC8SURBVDiNxdXZEoIwDAXQtFoLBNz3DTfy/5+ooMPIiJpbH7yvnTPTJU2IjItZndgZIhvpQZnIkscEsydUMFeka0kV62qiA2WeiE2+byixDaK6BN8gr+uTacvBP5LseMpAshJZY2RUiBRjhKR7uSVPATKXKgs96Z/v5DJQk408stVv7E3+TgLOEnBjPIPfhXkHvz4P4RpjXsKVzNkB/i8Bv7I1v7aLgKakjKmJ0zVY0+nVBEvIsAgYSfjguwKONUmIKJC5uwAAAABJRU5ErkJggg=="];
    fillGravityIcon = [UIImage imageWithCGImage:[fillGravityIcon CGImage] scale:2.0 orientation:UIImageOrientationUp];
    videoGravityFillButton = [[UIBarButtonItem alloc] initWithImage:fillGravityIcon style:UIBarButtonItemStyleBordered target:nil action:nil];

    UIImage* fitGravityIcon = [OOUIUtils imageFromBase64String:@"iVBORw0KGgoAAAANSUhEUgAAADIAAAAkBAMAAAA5nnQEAAAAA3NCSVQICAjb4U/gAAAAKlBMVEX///////////////////////////////////////////////////////9q+00tAAAADnRSTlMAESIzRGZ3iJm7zN3u/yr0oiYAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAAedEVYdFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzUuMasfSOsAAAAUdEVYdENyZWF0aW9uIFRpbWUANC82LzEyn7Hs9AAAAFVJREFUKJFjYKy+iw2cMGDQwipx9+5Vhrk4ZO4w4JC4excok8SACUTAMlgkGBgGiwx2z4zK0EJm4GMbp0yzAKaEBXbPQL00F4fETZw5axEDjty4XQAANdTt7Jv9ttUAAAAASUVORK5CYII="];
    fitGravityIcon = [UIImage imageWithCGImage:[fitGravityIcon CGImage] scale:2.0 orientation:UIImageOrientationUp];
    videoGravityFitButton = [[UIBarButtonItem alloc] initWithImage:fitGravityIcon style:UIBarButtonItemStyleBordered target:nil action:nil];

    navigationItem.rightBarButtonItem = videoGravityFillButton;
    navigationBar.items = [[NSArray alloc] initWithObjects:navigationItem, nil];
    
  }
}

- (void) updateToolbar {
  NSArray *items ;
  if (_isClosedCaptionsButtonShowing) {
    items = [[NSArray alloc] initWithObjects: closedCaptionsButton, flexibleSpace, previousButton, fixedSpace, _playButtonShowing ? playButton : pauseButton, fixedSpace, nextButton, flexibleSpace, nil];
  }
  else {
    items = [[NSArray alloc] initWithObjects: flexibleSpace, previousButton, fixedSpace, _playButtonShowing ? playButton : pauseButton, fixedSpace, nextButton, flexibleSpace, nil];
  }
  [volumeView.toolbar setItems:items animated:NO];
}

- (BOOL)playButtonShowing {
  return _playButtonShowing;
}
- (void)setPlayButtonShowing:(BOOL)showing {
  _playButtonShowing = showing;
  [self updateToolbar];
}

- (BOOL)closedCaptionsButtonShowing {
  return _isClosedCaptionsButtonShowing;
}

- (void)setClosedCaptionsButtonShowing:(BOOL)showing {
  _isClosedCaptionsButtonShowing = showing;
  [self updateToolbar];

}

- (BOOL)videoGravityFillButtonShowing {
  return navigationItem.rightBarButtonItem == videoGravityFillButton;
}

- (void)setVideoGravityFillButtonShowing:(BOOL)videoGravityFillButtonShowing {
  if (videoGravityFillButtonShowing) {
    navigationItem.rightBarButtonItem = videoGravityFillButton;
  } else {
    navigationItem.rightBarButtonItem = videoGravityFitButton;
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
