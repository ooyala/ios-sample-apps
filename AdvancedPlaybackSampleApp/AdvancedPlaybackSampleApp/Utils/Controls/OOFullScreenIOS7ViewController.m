//
//  OOFullScreenIOS7ViewControler.m
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "OOFullScreenIOS7ViewController.h"
#import "OOFullScreenIOS7ControlsView.h"
#import "OOUIUtils.h"
#import <OoyalaSDK/OOUIProgressSliderIOS7.h>
#import <OoyalaSDK/OOVideo.h>
#import <OoyalaSDK/OODebugMode.h>
#import <OoyalaSDK/OOOptions.h>

@interface OOFullScreenIOS7ViewController ()

@end

@interface OOFullScreenIOS7ViewController() {
  BOOL wasPlaying;
  BOOL seeking;
  UIStatusBarStyle previousStatusBarStyle;
  BOOL wasPreviousStatusBarHidden;
  BOOL isStatusBarHidden;
  CGFloat bottomBarHeight;
}

@property (nonatomic) OOFullScreenIOS7ControlsView *controls;
@end

@implementation OOFullScreenIOS7ViewController

@dynamic controls;

- (id)init {
  self = [super init];
  [self setModalPresentationStyle:UIModalPresentationFullScreen];
 // [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
  [self setWantsFullScreenLayout:YES];
  return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  if (self.player == nil) {
    LOG(@"viewDidLoad while player is nil");
    return;
  }
  self.controls = [[OOFullScreenIOS7ControlsView alloc] initWithFrame:self.view.bounds];

  self.controls.playButton.target = self.player;

  self.controls.nextButton.target = self.player;
  self.controls.nextButton.action = @selector(nextVideo);
  
  self.controls.previousButton.target = self.player;
  self.controls.previousButton.action = @selector(previousVideo);
  
  self.controls.doneButton.target = self.delegate;
  self.controls.doneButton.action = @selector(onFullscreenDoneButtonClick);
  
  self.controls.videoGravityButton.target = self.delegate;
  self.controls.videoGravityButton.action = @selector(switchVideoGravity);
  
  self.controls.closedCaptionsButton.target = self.delegate;
  self.controls.closedCaptionsButton.action = @selector(closedCaptionsSelector);
  
  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingStarted) forControlEvents:UIControlEventTouchDown];
  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingChanged) forControlEvents:UIControlEventValueChanged];
  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingEnded) forControlEvents:UIControlEventTouchUpInside];
  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingEnded) forControlEvents:UIControlEventTouchUpOutside];

  [super viewDidLoad];
}

- (void)onScrubbingStarted {
  if (self.player == nil) {
    LOG(@"onScrubbingStarted while player is nil");
    return;
  }
  wasPlaying = self.player.isPlaying;
  if(wasPlaying) {
    [self.player pause];
  }
  seeking = YES;
}

- (void)onScrubbingChanged {
  if (self.player == nil) {
    LOG(@"onScrubbingChanged while player is nil");
    return;
  }
  if (self.player.seekStyle == OOSeekStyleEnhanced) {
    [self.player seek:self.controls.scrubberSlider.scrubberAbsoluteValue];
  }
}

- (void)onScrubbingEnded {
  if (self.player == nil) {
    LOG(@"onScrubbingEnded while player is nil");
    return;
  }
  if (self.player.seekStyle != OOSeekStyleEnhanced) {
    [self.player seek:self.controls.scrubberSlider.scrubberAbsoluteValue];
  }
  if (wasPlaying) {
    [self.player play];
  }
  
  seeking = NO;
  
  [self syncUI];
}

- (void)hideControls {
  if (self.player == nil) {
    LOG(@"hideControls while player is nil");
    return;
  }
  isStatusBarHidden = YES;
  if (self.hideControlsTimer != nil) [self.hideControlsTimer invalidate];
  if (self.controls == nil) return;
  [UIView animateWithDuration:0.37
                   animations: ^ {
                     //Only show/hide status bar if it was visible from the start
                     if (!wasPreviousStatusBarHidden) {
                       [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
                     }

                     [self.controls hide];
                     if (self.overlay) [self.overlay setAlpha:0];
                     [self setNeedsStatusBarAppearanceUpdate];
                   }
                   completion: ^ (BOOL finished) {
                     if (self.overlay) self.overlay.hidden = YES;
                   }];
  self.controls.hidden = YES;
  [self updateClosedCaptionsPosition];
}

- (void)showControls {
  if (self.player == nil || [self showingAdsWithHiddenControls]) {
    LOG(@"showControls while player is nil");
    return;
  }
  if (!self.isVisible) return;
  isStatusBarHidden = NO;
  if (self.hideControlsTimer != nil) [self.hideControlsTimer invalidate];
  if (self.controls == nil) return;

  self.controls.hidden = NO;
  if (self.overlay) self.overlay.hidden = NO;
  if (self.player.isPlaying)
    self.hideControlsTimer = [NSTimer scheduledTimerWithTimeInterval:CONTROLS_HIDE_TIMEOUT target:self selector:@selector(hideControls) userInfo:nil repeats:NO];

  [UIView animateWithDuration:0.37
                   animations: ^ {
                     //Only show/hide status bar if it was visible from the start
                     if (!wasPreviousStatusBarHidden) {
                       [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
                     }

                     [self.controls show];
                     if (self.overlay) [self.overlay setAlpha:1];
                     [self setNeedsStatusBarAppearanceUpdate];
                   }
                   completion: NULL];
  [self updateClosedCaptionsPosition];
}

- (void)viewWillAppear:(BOOL)animated {
  previousStatusBarStyle =  [UIApplication sharedApplication].statusBarStyle;
  wasPreviousStatusBarHidden = [UIApplication sharedApplication].statusBarHidden;
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [self updateClosedCaptionsPosition];
}

- (void)viewWillDisappear:(BOOL)animated {
  //If the status bar was visible before fullscreen, make sure it comes back when we leave.
  if (!wasPreviousStatusBarHidden) {
    [[UIApplication sharedApplication] setStatusBarHidden:wasPreviousStatusBarHidden withAnimation:UIStatusBarAnimationFade];
  }
  [[UIApplication sharedApplication] setStatusBarStyle:previousStatusBarStyle];
  [super viewWillDisappear:animated];
}

- (void)syncUI {
  [super syncUI];

  if (self.player == nil) {
    LOG(@"syncUI while player is nil");
    return;
  }

  if (!self.controls)
    return;
  
  [self updateClosedCaptionsButton];

  if (self.player.allowsExternalPlayback != self.controls.volumeButton.showsRouteButton) {
    self.controls.showsAirPlayButton = self.player.allowsExternalPlayback;
  }

  // handle gravity
  if(self.player.videoGravity == OOOoyalaPlayerVideoGravityResizeAspect) {
    [self.controls setGravityFillButtonShowing:YES];
  } else {
    [self.controls setGravityFillButtonShowing:NO];
  }
  
  // Handle LIVE streams
  self.controls.scrubberSlider.mode = [super sliderMode];
  
  //Handle time
  if (seeking == NO) {
    //LOG(@"set duraion here %f -- playhead %f", self.player.duration, self.player.playheadTime);
    self.controls.scrubberSlider.duration = self.player.duration;
    self.controls.scrubberSlider.currentTime = self.player.playheadTime;
    self.controls.scrubberSlider.currentAvailableTime = self.player.bufferedTime;
    self.controls.scrubberSlider.seekableTimeRange = [self.player seekableTimeRange];
    [self.controls.scrubberSlider updateTimeDisplay];
  }
  
  //Handle state
  if (self.player.isPlaying) {

    if ([self showingAdsWithHiddenControls]) {
      [self hideControls];
    } else if (self.controls.playButton.isPlayShowing) {
      [self.controls.playButton setIsPlayShowing:NO];
      if (self.controls.hidden == NO) {
        [self showControls];
        if (self.hideControlsTimer != nil) [self.hideControlsTimer invalidate];
      }
    }
  } else if (!self.controls.playButton.isPlayShowing) {
    [self.controls.playButton setIsPlayShowing:YES];
    if (self.controls.hidden == NO) {
      [self showControls];
      if (self.hideControlsTimer != nil) [self.hideControlsTimer invalidate];
    }
  }

  self.controls.scrubberSlider.scrubber.userInteractionEnabled = self.player.seekable;
  
  if ((self.player.state == OOOoyalaPlayerStateLoading) && seeking == NO) {
    [self.activityView startAnimating];
  } else {
    [self.activityView stopAnimating];
	}

  self.controls.scrubberSlider.cuePointsAtSeconds = [self.player getCuePointsAtSecondsForCurrentPlayer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  if ([self.delegate respondsToSelector:@selector(shouldAutorotateToInterfaceOrientation:)]) {
    return [self.delegate shouldAutorotateToInterfaceOrientation:interfaceOrientation];
  }
  return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

- (NSUInteger)supportedInterfaceOrientations {
  if ([self.delegate respondsToSelector:@selector(supportedInterfaceOrientations)]) {
    return [self.delegate supportedInterfaceOrientations];
  }
  //this only exists in ios6+, and tests wont run withoput this hackiness
  if ([super respondsToSelector:@selector(supportedInterfaceOrientations)]) {
    return (NSUInteger)[super performSelector:@selector(supportedInterfaceOrientations)];
  }
  return 0;
}

- (BOOL)prefersStatusBarHidden {
  // Always hide the status bar if controls go into hiding.  Show status bar only if our owner showed it
  return isStatusBarHidden ? YES : [self.delegate prefersStatusBarHidden];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
  return UIStatusBarStyleDefault;
}

- (void)changeButtonLanguage:(NSString*)language {
  [self.controls changeDoneButtonLanguage:language];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [self updateClosedCaptionsPosition];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self.delegate willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

// Reopen popover if it was visiable before rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self.delegate didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)updateBottomHeight {
  if (self.player == nil) {
    LOG(@"updateBottomHeight while player is nil");
    return;
  }
  if (!self.controls.hidden) {
		// Check if the bottom bar will overlap with closed captions
  	CGRect videoRect = [self.player videoRect];
    if (self.controls.bottomBarBackground.frame.origin.y < videoRect.origin.y + videoRect.size.height) {
      bottomBarHeight = self.controls.bottomBarBackground.frame.size.height;
    } else {
			bottomBarHeight = 0;
    }
  } else {
  	bottomBarHeight = 0;
  }
}

- (void)updateClosedCaptionsPosition {
  if (self.player == nil) {
    NSLog(@"Fullscreen View Controller: Trying to update Closed Captions without having a valid player");
    return;
  }
  [self.player updateClosedCaptionsViewPosition:self.controls.bottomBarBackground.frame withControlsHide:self.controls.hidden];
}

- (BOOL)showingAdsWithHiddenControls {
  return (self.player.isShowingAd && !self.player.options.showAdsControls);
}

// These three methods decleared in OOOoyalaPlayerViewController. Here is for resolving the warnings
-(void)onFullscreenDoneButtonClick {}
-(void)switchVideoGravity{
	[self updateClosedCaptionsPosition];
}
-(void)closedCaptionsSelector{}

- (void)dealloc {}
@end
