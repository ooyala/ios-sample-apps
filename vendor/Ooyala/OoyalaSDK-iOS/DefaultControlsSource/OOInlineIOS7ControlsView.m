//
//  OOInlineIOS7ControlsView.m
//  OoyalaSDK
//
//  Created by Liusha Huang on 8/22/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import "OOInlineIOS7ControlsView.h"
#import "OOUIProgressSliderIOS7.h"
#import "OOImagesIOS7.h"
#import "OOVolumeView.h"
#import "OOUIUtils.h"
#import "iOS7ScrubberSliderFraming.h"

@interface OOInlineIOS7ControlsView() {
}

@property (nonatomic) CGFloat playpauseScale;
@property (nonatomic) CGFloat ccScale;
@property (nonatomic) CGFloat fullscreenScale;

@property (nonatomic) UIBarButtonItem *slider;
@property (nonatomic) UIBarButtonItem *fixedSpace;
@property (nonatomic) UIBarButtonItem *flexibleSpace;
@end

@implementation OOInlineIOS7ControlsView

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
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    _navigationBar.tintColor = [UIColor blackColor];
#endif
    _flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    //InitializeButtons
    _playButton = [[UIBarButtonItem alloc]
                   initWithImage:[UIImage imageWithCGImage:[[OOImagesIOS7 playImage] CGImage]
                                                     scale:_playpauseScale
                                               orientation:UIImageOrientationUp]
                   style:UIBarButtonItemStylePlain
                   target:nil action:nil];

    _pauseButton = [[UIBarButtonItem alloc]
                    initWithImage:[UIImage imageWithCGImage:[[OOImagesIOS7 pauseImage] CGImage]
                                                      scale:_playpauseScale
                                                orientation:UIImageOrientationUp]
                    style:UIBarButtonItemStylePlain
                    target:nil action:nil];

    _closedCaptionsButton = [[UIBarButtonItem alloc]
                             initWithImage:[UIImage imageWithCGImage:[ [OOImagesIOS7 closedCaptionsImage] CGImage]
                                                               scale:_ccScale orientation:UIImageOrientationUp]
                             style:UIBarButtonItemStylePlain
                             target:nil action:nil];

    _fullscreenButton = [[UIBarButtonItem alloc]
                         initWithImage:[UIImage imageWithCGImage:[ [OOImagesIOS7 expandImage] CGImage]
                                                           scale: _fullscreenScale
                                                     orientation:UIImageOrientationUp]
                         style:UIBarButtonItemStylePlain
                         target:nil action:nil];
      
    _scrubberSlider = [[OOUIProgressSliderIOS7 alloc] initWithFrame:[self calculateScrubberSliderFrame]];
    _scrubberSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _slider = [[UIBarButtonItem alloc] initWithCustomView:_scrubberSlider];

    [self addSubview:_navigationBar];
    [self updateNavigationBar];
  }
  return self;
}

- (void)layoutSubviews {
  _slider.customView.frame = [self calculateScrubberSliderFrame];
  [super layoutSubviews];
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
  UIGraphicsBeginImageContext( newSize );
  [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

/**
 * Update navbar when someting is added or removed
 */
- (void) updateNavigationBar{
  NSMutableArray *items = [[NSMutableArray alloc] init];
  [items addObject:_flexibleSpace];
  [items addObject:_playButtonShowing ? _playButton : _pauseButton];

  [items addObject:_slider];

  if (_closedCaptionsButtonShowing) {
    [items addObject:_closedCaptionsButton];
  }

  [items addObject:_flexibleSpace];

  if (_fullscreenButtonShowing) {
    [items addObject:_fullscreenButton];
  }

  [items addObject:_flexibleSpace];

  [self setNeedsLayout];
  [_navigationBar setItems:items animated:NO];
}


/**
 * Called when the navbar is updated, and after the views need to be layed out (layoutSubviews)
 */
-(CGRect)calculateScrubberSliderFrame {
  NSMutableArray *buttonList = [[NSMutableArray alloc] init];
  [buttonList addObject:_playButtonShowing ? _playButton : _pauseButton];

  if (_closedCaptionsButtonShowing) {
    [buttonList addObject:_closedCaptionsButton];
  }

  if (_fullscreenButtonShowing) {
    [buttonList addObject:_fullscreenButton];
  }

  return [iOS7ScrubberSliderFraming
      calculateScrubberSliderFramewithButtons: buttonList
                                    baseWidth:_navigationBar.bounds.size.width];
}

- (void)setPlayButtonShowing:(BOOL)showing {
  if(_playButtonShowing == showing) return;
  _playButtonShowing = showing;
  [self updateNavigationBar];
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
