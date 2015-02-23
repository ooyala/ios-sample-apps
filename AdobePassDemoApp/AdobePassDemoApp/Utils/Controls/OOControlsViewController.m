/**
 * @file       OOControlsViewController.m
 * @brief      Implementation of OOControlsViewController
 * @details    OOControlsViewController.m in OoyalaSDK
 * @date       2/23/12
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOControlsViewController.h"
#import "OOOoyalaPlayer.h"
#import "OOVideo.h"
#import "OOUIUtils.h"
#import "OOOptions.h"

@interface OOUnselectableActivityIndicatorView : UIActivityIndicatorView
@end

@implementation OOUnselectableActivityIndicatorView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  return NO;
}

@end

@interface OOControlsViewController() {
  BOOL wasPlaying;
  BOOL seeking;
  BOOL hasObservers;
  __unsafe_unretained id delegate;
  __unsafe_unretained OOOoyalaPlayer *_player;
  __unsafe_unretained UIView *_overlay;
}
@property (nonatomic) OOOoyalaPlayerControlType controlsType;

- (void)addObservers;
- (void)removeObservers;
@end

@implementation OOControlsViewController

- (id) initWithControlsType:(OOOoyalaPlayerControlType)controlsType player:(OOOoyalaPlayer *)player  overlay:(UIView *) overlay delegate:(id)dele{
  self = [self init];

  self.controlsType = controlsType;
  self.player = player;
  self.delegate = dele;
  self.overlay = overlay;

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor blackColor];
  self.view.clipsToBounds = YES;
  self.isVisible = YES;

  //add player's view
  [self.player.view setFrame:self.view.bounds];
  [self.view addSubview:self.player.view];

  //init activity view
  self.activityView = [[OOUnselectableActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  self.activityView.center = self.view.center;
  self.activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
  [self.view addSubview:self.activityView];

  //add controls
  [self.view addSubview:self.controls];

  //add overlay
  [self.view addSubview:self.overlay];

  // register for events
  [self addObservers];

}

- (void)addObservers {
  if (hasObservers) {
    return;
  }
  hasObservers = YES;
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncUI) name:OOOoyalaPlayerStateChangedNotification object:_player];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncUI) name:OOOoyalaPlayerTimeChangedNotification object:_player];
}

- (void)removeObservers {
  if (!hasObservers) {
    return;
  }
  hasObservers = NO;
  if (self.hideControlsTimer != nil) [self.hideControlsTimer invalidate];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:OOOoyalaPlayerStateChangedNotification object:self.player];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:OOOoyalaPlayerTimeChangedNotification object:self.player];
}

- (void)viewDidUnload {
  [self removeObservers];
}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.player.view setFrame:self.view.bounds];
  [self.view addSubview:self.player.view];
  [self.view sendSubviewToBack:self.player.view];
  [self syncUI];
  [self addObservers];
}

//- (void)viewDidAppear:(BOOL)animated {
//  [super viewDidAppear:animated];
//  [self syncUI];
//  [self addObservers];
//}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self removeObservers];
}

//- (void)viewDidDisappear:(BOOL)animated {
//  [super viewDidDisappear:animated];
//  [self removeObservers];
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

- (void)hideControls {
  if (self.hideControlsTimer != nil) [self.hideControlsTimer invalidate];
  if (self.controls == nil) return;

  [UIView animateWithDuration:0.37
                   animations: ^ {
                     [self.controls setAlpha:0];
                     if (self.overlay) [self.overlay setAlpha:0];
                     [self setNeedsStatusBarAppearanceUpdate];
                   }
                   completion: ^ (BOOL finished) {
                     self.controls.hidden = YES;
                     if (self.overlay) self.overlay.hidden = YES;
                     [self updateClosedCaptionsPosition];
                   }];
}

- (void)showControls {
  if (!self.isVisible) return;
  if (self.hideControlsTimer != nil) [self.hideControlsTimer invalidate];
  if (self.controls == nil) return;

  self.controls.hidden = NO;
  if (self.overlay) self.overlay.hidden = NO;
  if (self.player.isPlaying)
    self.hideControlsTimer = [NSTimer scheduledTimerWithTimeInterval:CONTROLS_HIDE_TIMEOUT target:self selector:@selector(hideControls) userInfo:nil repeats:NO];

  [UIView animateWithDuration:0.37
                   animations: ^ {
                     [self.controls setAlpha:1];
                     if (self.overlay) [self.overlay setAlpha:1];
                     [self setNeedsStatusBarAppearanceUpdate];
                   }
                   completion: nil];
 [self updateClosedCaptionsPosition];
}

- (void)syncUI {
}

- (id) delegate {
  return delegate;
}

- (void) setDelegate:(id)_delegate {
  delegate = _delegate;
}

- (OOOoyalaPlayer *)player {
  return _player;
}

- (void) setPlayer:(OOOoyalaPlayer *)player {
  [self removeObservers];
  _player = player;
  [_player layoutSubviews];
  [self addObservers];
}

- (UIView *)overlay {
  return _overlay;
}

- (void) setOverlay:(UIView *)theOverlay {
  if(self.overlay.superview) {
    [self.overlay removeFromSuperview];
  }

  _overlay = theOverlay;

  if(self.controls.superview) {
    [self.view addSubview:self.overlay];
    self.overlay.hidden = self.controls.hidden;
  }
}

- (OOUIProgressSliderMode) sliderMode {
  if  (self.player.isShowingAd && self.player.currentItem.live) {
    return OOUIProgressSliderModeAdInLive;
  }
  
  if (self.player.currentItem.live) {
    if (![self.player.options showLiveContentScrubber]) {
      return OOUIProgressSliderModeLiveNoSrubber;
    }
    return OOUIProgressSliderModeLive;
  }
  return OOUIProgressSliderModeNormal;
}

- (void)dealloc {
  [self.view.layer removeAllAnimations];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self toggleControls];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
}

- (void)toggleControls {
  if (self.controls.hidden) {
    [self showControls];
  } else {
    [self hideControls];
  }
}

- (void) setFullScreenButtonShowing: (BOOL) isShowing {
  // subclass need to implement this method
}

- (void)changeButtonLanguage:(NSString*)language {
  // subclass need to implement this method
}

- (void)updateClosedCaptionsPosition {
}

- (void)switchVideoGravity {
  // subclass to override if need be.
}

-(void)updateClosedCaptionsButton {
  // todo: fix inheritance tree so we can call methods directly.
  BOOL available = self.player.isClosedCaptionsTrackAvailable;
  BOOL alreadyShowing = [self.controls performSelector:@selector(closedCaptionsButtonShowing)];
  BOOL contentShowing = ! self.player.isShowingAd;
  BOOL shouldShow = available && contentShowing;
  if( alreadyShowing != shouldShow ) {
    SEL sel = @selector(setClosedCaptionsButtonShowing:);
    NSInvocation *i = [NSInvocation invocationWithMethodSignature:[self.controls methodSignatureForSelector:sel]];
    [i setSelector:sel];
    [i setTarget:self.controls];
    [i setArgument:&shouldShow atIndex:2];
    [i invoke];
  }
}

@end
