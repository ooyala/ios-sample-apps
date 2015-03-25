//
//  OOInlineIOS7ControlsView.m
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "CustomControlsView.h"
#import "OOImagesIOS7.h"
#import "OOUIUtils.h"
#import <OoyalaSDK/iOS7ScrubberSliderFraming.h>

@interface CustomControlsView() {
}

@property (nonatomic) CGFloat playpauseScale;
@property (nonatomic) CGFloat ccScale;
@property (nonatomic) CGFloat fullscreenScale;

@property (nonatomic) UIBarButtonItem *fixedSpace;
@property (nonatomic) UIBarButtonItem *flexibleSpace;
@end

@implementation CustomControlsView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    // Setup all the constant for inline controls
    CGFloat width = self.bounds.size.width;
    CGRect navigationBarRect;
    if ([OOUIUtils isIpad]) {
      navigationBarRect = CGRectMake(0, self.bounds.size.height - 50, width, 50);
      _playpauseScale = 2.7;
      _ccScale = 3.0;
      _fullscreenScale = 4.0;
    } else {
      navigationBarRect = CGRectMake(0, self.bounds.size.height - 40, width, 40);
      _playpauseScale = 3.5;
      _ccScale = 4;
      _fullscreenScale = 5.5;
    }

    _fullscreenButtonShowing = YES;

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    // Create control bar
    self.navigationBar = [[UIToolbar alloc] initWithFrame:navigationBarRect];
    self.navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    _navigationBar.tintColor = [UIColor blackColor];
    _navigationBar.backgroundColor = [UIColor greenColor];

    _fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];

    _flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    //InitializeButtons

    _playButton = [[OOPlayPauseButton alloc] initWithScale:_playpauseScale];

    _closedCaptionsButton = [[OOClosedCaptionsButton alloc] initWithScale:_ccScale];

    _fullscreenButton = [[OOFullscreenButton alloc] initWithScale:_fullscreenScale];
      
    _scrubberSlider = [[OOUIProgressSliderIOS7 alloc] initWithFrame:[self calculateScrubberSliderFrame]];
    _scrubberSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _slider = [[UIBarButtonItem alloc] initWithCustomView:_scrubberSlider];

    [self updateNavigationBar];
    [self addSubview:_navigationBar];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}


/**
 * Update navbar when someting is added or removed
 */
- (void) updateNavigationBar{
  NSMutableArray *items = [[NSMutableArray alloc] init];
  [items addObject:_flexibleSpace];

  [items addObject:_playButton];

//  [items addObject:_slider];

  if (_closedCaptionsButtonShowing) {
    [items addObject:_closedCaptionsButton];
  }
//  [items addObject:_flexibleSpace];


//  if (_fullscreenButtonShowing) {
//    [items addObject:_fullscreenButton];
//  }

  [items addObject:_flexibleSpace];

  [_navigationBar setItems:items animated:NO];
  _slider.customView.frame = [self calculateScrubberSliderFrame];

  [self setNeedsLayout];
}


/**
 * Called when the navbar is updated, and after the views need to be layed out (layoutSubviews)
 */
-(CGRect)calculateScrubberSliderFrame {
  NSMutableArray *buttonList = [[NSMutableArray alloc] init];
  buttonList = [NSMutableArray arrayWithArray:_navigationBar.items];
  [buttonList removeObject:_slider];
  return [iOS7ScrubberSliderFraming
      calculateScrubberSliderFramewithButtons: buttonList
                                    baseWidth:_navigationBar.bounds.size.width];
}

- (void)setIsPlayShowing:(BOOL)showing {
  [_playButton setIsPlayShowing:showing];
}

- (void)setFullscreenButtonShowing:(BOOL)showing {
  if(_fullscreenButtonShowing == showing) return;
  _fullscreenButtonShowing = showing;
  [self updateNavigationBar];
}

- (void)setClosedCaptionsButtonShowing:(BOOL)showing {
  if(_closedCaptionsButtonShowing == showing) return;
  _closedCaptionsButtonShowing = showing;
  [self updateNavigationBar];
}

- (void)hide {
  _navigationBar.alpha = 0;
}

- (void)show {
  _navigationBar.alpha = 1;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  for (UIView *view in self.subviews) {
    if (CGRectContainsPoint(view.frame, point)) {
      return YES;
    }
  }
  return NO;
}

- (void)changeDoneButtonLanguage:(NSString*)language {
  // Implement this method when inline button's language need to be changed with closed caption
}
@end
