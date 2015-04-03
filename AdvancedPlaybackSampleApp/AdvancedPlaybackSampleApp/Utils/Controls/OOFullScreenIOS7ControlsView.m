/**
 * @file       OOFullScreenControlsView.m
 * @brief      Implementation of OOFullScreenControlsView
 * @details    OOFullScreenControlsView.m in OoyalaSDK
 * @date       1/10/12
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */
#import <QuartzCore/QuartzCore.h>
#import "OOFullScreenIOS7ControlsView.h"
#import <OoyalaSDK/OOTransparentToolbar.h>
#import <OoyalaSDK/OOUIProgressSliderIOS7.h>
#import "OOImagesIOS7.h"
#import "OOUIUtils.h"
#import <OoyalaSDK/iOS7ScrubberSliderFraming.h>
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>

@interface OOFullScreenIOS7ControlsView() {
}

@property (nonatomic) UIToolbar *navigationBar;
@property (nonatomic) UIView *topBarBackground;
@property (nonatomic) UIToolbar *controlsBar;
@property (nonatomic) UIToolbar *volumeBar;
@property (nonatomic) UIBarButtonItem *volumeButtonItem;
@property (nonatomic) UIBarButtonItem *airPlayButtonItem;
@property (nonatomic) UIBarButtonItem *fixedSpace;
@property (nonatomic) UIBarButtonItem *flexibleSpace;

@property (nonatomic) CGFloat playpauseScale;
@property (nonatomic) CGFloat ccScale;
@property (nonatomic) CGFloat gravityScale;
@property (nonatomic) CGFloat prevnextScale;
@property (nonatomic) CGFloat routeScale;
@property (nonatomic) CGFloat airPlayScale;
@property (nonatomic) CGFloat volumeThumbScale;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat barSize;
@property (nonatomic) CGRect sliderRect;
@property (nonatomic) CGFloat bottomBarHeight;
@property (nonatomic) CGFloat volumeSliderWidth;
@end

@implementation OOFullScreenIOS7ControlsView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    // Setup constant for controls
    [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    if ([OOUIUtils isIpad]) {
      _playpauseScale = 2;
      _ccScale = 3.0;
      _gravityScale = 4.0;
      _prevnextScale = 2.0;
      _routeScale = 3.5;
      _airPlayScale = 3.5;
      _fontSize = 25;
      _barSize = 50;
      _bottomBarHeight = 70;
      _volumeSliderWidth = 220;
    } else {
      _playpauseScale = 3;
      _ccScale = 4;
      _gravityScale = 4.5;
      _prevnextScale = 3.0;
      _routeScale = 4.5;
      _airPlayScale = 4.5;
      _fontSize = 16;
      _barSize = 35;
      _bottomBarHeight = 60;
      _volumeSliderWidth = 140;
    }
    _volumeThumbScale = 4.5;
    [self initVolumeView];
    [self initNavigationBar];

    [self initButtons];
    [self updateToolbar];
    [self updateNavigationBar];
  }
  return self;
}
- (void)initButtons {
  /**
   * Controls for the top bar
   */
  NSString* doneButtonTitle = [[OOOoyalaPlayerViewController currentLanguageSettings] objectForKey:@"Done"];
  _doneButton = [[UIBarButtonItem alloc] initWithTitle:doneButtonTitle
                                                 style:UIBarButtonItemStylePlain
                                                target:nil action:nil];

  [_doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont systemFontOfSize:_fontSize],
                                       UITextAttributeFont,
                                       [UIColor blackColor],
                                       UITextAttributeTextColor,
                                       nil]
                             forState:UIControlStateNormal];


  _closedCaptionsButton = [[OOClosedCaptionsButton alloc] initWithScale:_ccScale];

  _videoGravityButton = [[OOVideoGravityButton alloc] initWithScale:_gravityScale];


  /**
   * Controls for the bottom bar
   */
  _fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
  _fixedSpace.width = [OOUIUtils isIpad] ? 20 : 10;

  _flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];


  _playButton = [[OOPlayPauseButton alloc] initWithScale:_playpauseScale];


  _nextButton = [[UIBarButtonItem alloc]
                 initWithImage:[UIImage imageWithCGImage:[[OOImagesIOS7 forwardImage] CGImage]
                                                   scale:_prevnextScale orientation:UIImageOrientationUp]
                 style:UIBarButtonItemStylePlain
                 target:nil action:nil];

  _previousButton = [[UIBarButtonItem alloc]
                     initWithImage:[UIImage imageWithCGImage:[[OOImagesIOS7 rewindImage] CGImage]
                                                       scale:_prevnextScale orientation:UIImageOrientationUp]
                     style:UIBarButtonItemStylePlain
                     target:nil action:nil];

  _volumeButton = [[MPVolumeView alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
  _volumeButton.showsVolumeSlider = YES;
  _volumeButton.showsRouteButton = NO;

  _airPlayButton = [[MPVolumeView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
  _airPlayButton.showsVolumeSlider = NO;
  _airPlayButton.showsRouteButton = YES;


  UIImage *image = [UIImage imageWithCGImage:[[OOImagesIOS7 routeImage] CGImage]
                                       scale:_routeScale orientation:UIImageOrientationUp];
  UIImage *enabledImage = [UIImage imageWithCGImage:[[OOImagesIOS7 routeOnImage] CGImage]
                                              scale:_routeScale orientation:UIImageOrientationUp];

  [_airPlayButton setRouteButtonImage: image
                           forState:UIControlStateNormal];
  [_airPlayButton setRouteButtonImage: enabledImage
                           forState:UIControlStateSelected];

  for (id current in _volumeButton.subviews) {
    if ([current isKindOfClass:[UISlider class]]) {
      UISlider* slider = (UISlider*)current;
      slider.minimumTrackTintColor = [UIColor whiteColor];
      slider.thumbTintColor = [UIColor  whiteColor];

      // This is the workaround to a  known bug in iOS 7.1
      CGRect rect = CGRectMake(0, 0, 1, 1);
      UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
      [[UIColor blackColor] setFill];
      UIRectFill(rect);
      UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      [slider setMaximumTrackImage:image forState:UIControlStateNormal];

      // scrubber thumb
      UIImage *thumb = [OOImagesIOS7 thumbImage];
      thumb = [UIImage imageWithCGImage:[thumb CGImage] scale:_volumeThumbScale orientation:UIImageOrientationUp];
      [slider setThumbImage:thumb forState:UIControlStateNormal];
      [slider setThumbImage:thumb forState:UIControlStateHighlighted];
    }
  }

  _volumeButton.tintColor = [UIColor clearColor];
  _volumeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_volumeButton];
  _airPlayButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_airPlayButton];

  _scrubberSlider = [[OOUIProgressSliderIOS7 alloc] initWithFrame:[self calculateScrubberSliderFrame]];
  _scrubberSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  _slider = [[UIBarButtonItem alloc] initWithCustomView:_scrubberSlider];
}

  /**
   * Initialize the bottom bar of fullscreen controls
   */
// TODO:(mlen) actually position the bottom bar background, and add volume to it.
- (void)initVolumeView {
  // Background that covers the bottom toolbar
  _bottomBarBackground = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - _bottomBarHeight * 1.5, self.bounds.size.width, _bottomBarHeight * 1.5)];
  _bottomBarBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  _bottomBarBackground.alpha = 0.5;
  [self addSubview:_bottomBarBackground];

  // If this is an iphone, put the volume on another bar
  _volumeBar = [[OOTransparentToolbar alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - _bottomBarHeight * 0.5, self.bounds.size.width, _bottomBarHeight / 2)];
  _volumeBar.tintColor = [UIColor blackColor];
  _volumeBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  [self addSubview:_volumeBar];

  // The bar that holds play/pause/forward/back.  In ipads, this also holds the volume slider
  _controlsBar = [[OOTransparentToolbar alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - _bottomBarHeight * 1.5, self.bounds.size.width, _bottomBarHeight)];

  _controlsBar.tintColor = [UIColor blackColor];
  _controlsBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  [self addSubview:_controlsBar];
}

/**
 * Initialize the Top bar of fullscreen controls
 */
- (void)initNavigationBar {
  // Background that covers both navBar and statusBar.  if statusBar is hidden shift the bar upwards.
  CGFloat topViewHeight = [UIApplication sharedApplication].statusBarHidden ? 0 : 20;

  _topBarBackground = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _barSize + topViewHeight)];
  _topBarBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  _topBarBackground.alpha = 0.5;

  // Setup the navigationBar
  _navigationBar = [[OOTransparentToolbar alloc] initWithFrame:CGRectMake(0, topViewHeight, self.bounds.size.width, _barSize)];
  _navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  _navigationBar.clipsToBounds = YES;
  _navigationBar.layer.borderWidth = 0;
  _navigationBar.tintColor = [UIColor blackColor];
  [self addSubview:_topBarBackground];
  [self addSubview:_navigationBar];
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

- (void)layoutSubviews {
  [self updateToolbar];
  [super layoutSubviews];
}

  /**
   * Initialize and update Bottom bar when button(s) is added or removed
   */
- (void) updateToolbar {
  _airPlayButton.showsRouteButton = YES;
  NSArray *items;
   NSArray* volumeSlider;
  [_controlsBar setItems:nil animated:NO];
  [_volumeBar setItems:nil animated:NO];
  if (![OOUIUtils isIpad] && ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait))  {
    [_controlsBar setFrame:CGRectMake(0, self.bounds.size.height - _bottomBarHeight * 1.5, self.bounds.size.width, _bottomBarHeight)];

    items = [[NSArray alloc] initWithObjects:_flexibleSpace, _previousButton, _fixedSpace, _playButton, _fixedSpace,  _nextButton, _flexibleSpace, nil];
    [_volumeButton setFrame:CGRectMake(0, self.bounds.size.height - _bottomBarHeight * 0.5, self.bounds.size.width - 120, _bottomBarHeight / 2)];
    [_bottomBarBackground setFrame:CGRectMake(0, self.bounds.size.height - _bottomBarHeight * 1.5, self.bounds.size.width, _bottomBarHeight * 1.5)];

    if (_showsAirPlayButton) {
      volumeSlider = [[NSArray alloc] initWithObjects:_flexibleSpace, _volumeButtonItem, _flexibleSpace, _airPlayButtonItem, nil];
    } else {
      volumeSlider = [[NSArray alloc] initWithObjects:_flexibleSpace, _volumeButtonItem, _flexibleSpace, nil];
    }

    [_volumeBar setItems:volumeSlider animated:NO];
    _volumeBar.hidden = NO;
  } else {
    [_controlsBar setFrame:CGRectMake(0, self.bounds.size.height - _bottomBarHeight, self.bounds.size.width, _bottomBarHeight)];
    _volumeBar.hidden = YES;
    [_volumeButton setFrame:CGRectMake(0, self.bounds.size.height - _bottomBarHeight, _volumeSliderWidth, _bottomBarHeight / 2)];
    [_bottomBarBackground setFrame:CGRectMake(0, self.bounds.size.height - _bottomBarHeight, self.bounds.size.width, _bottomBarHeight)];

    if (_showsAirPlayButton) {
      items = [[NSArray alloc] initWithObjects:_volumeButtonItem, _flexibleSpace, _previousButton, _fixedSpace, _playButton, _fixedSpace,  _nextButton, _flexibleSpace, _airPlayButtonItem, nil];
    } else {
      items = [[NSArray alloc] initWithObjects:_volumeButtonItem, _flexibleSpace, _previousButton, _fixedSpace, _playButton, _fixedSpace,  _nextButton, _flexibleSpace, nil];
    }
  }
  [_controlsBar setItems:items animated:NO];
}
/**
 * Update Top bar when someting is added or removed
 */
- (void) updateNavigationBar {
  NSArray *items;

  if (_closedCaptionsButtonShowing) {
    items = [[NSArray alloc] initWithObjects: _flexibleSpace, _doneButton, _slider, _closedCaptionsButton, _flexibleSpace,  _videoGravityButton, _flexibleSpace, nil];
  } else {
    items = [[NSArray alloc] initWithObjects: _flexibleSpace, _doneButton, _slider, _videoGravityButton, _flexibleSpace, nil];
  }

  [_navigationBar setItems:items animated:NO];
  _slider.customView.frame = [self calculateScrubberSliderFrame];

  [self setNeedsLayout];
}

-(CGRect)calculateScrubberSliderFrame {

  NSMutableArray *buttonList = [[NSMutableArray alloc] init];

  [buttonList addObject: _doneButton];
  if (_closedCaptionsButtonShowing) {
    [buttonList addObject: _closedCaptionsButton];
  }

  [buttonList addObject: _videoGravityButton];

  return [iOS7ScrubberSliderFraming calculateScrubberSliderFramewithButtons: buttonList
                                                           baseWidth:_navigationBar.bounds.size.width];
}

- (void)setIsPlayShowing:(BOOL)showing {
  [_playButton setIsPlayShowing:showing];
}

- (void)setClosedCaptionsButtonShowing:(BOOL)showing {
  if(_closedCaptionsButtonShowing == showing) return;
  _closedCaptionsButtonShowing = showing;
  [self updateNavigationBar];
  
}
- (void)setGravityFillButtonShowing:(BOOL)showing {
  [_videoGravityButton setIsGravityFillShowing:showing];
}

- (void)hide {
  _navigationBar.alpha = 0;
  _topBarBackground.alpha = 0;
  _bottomBarBackground.alpha = 0;
  _controlsBar.alpha = 0;
  _volumeBar.alpha = 0;
}

- (void)show {
  _navigationBar.alpha = 0.8;
  _topBarBackground.alpha = 0.5;
  _bottomBarBackground.alpha = 0.5;
  _controlsBar.alpha = 0.8;
  _volumeBar.alpha = 1;

}

- (void)changeDoneButtonLanguage:(NSString*)language {
  _doneButton.title = [[OOOoyalaPlayerViewController currentLanguageSettings] objectForKey:@"Done"];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  for (UIView *view in self.subviews) {
    if (CGRectContainsPoint(view.frame, point)) {
      return YES;
    }
  }
  return NO;
}
@end
