/**
 * @file       OOFullScreenViewController.m
 * @brief      Implementation of OOFullScreenViewController
 * @details    OOFullScreenViewController.m in OoyalaSDK
 * @date       1/12/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import "OOFullScreenViewController.h"
#import "OOFullScreenControlsView.h"
#import "OOOoyalaPlayer.h"
#import "OOUIProgressSlider.h"
#import "OOVolumeView.h"
#import "OOVideo.h"
#import "OOUIUtils.h"


@interface OOFullScreenViewController() {
  BOOL wasPlaying;
  BOOL seeking;
  UIStatusBarStyle previousStatusBarStyle;
}

@property (nonatomic) OOFullScreenControlsView *controls;

- (OOFullScreenControlsView *)fullscreenControlsViewInstance;

@end

@implementation OOFullScreenViewController

@dynamic controls;

- (id)init {
  self = [super init];
  [self setModalPresentationStyle:UIModalPresentationFullScreen];
  [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
  [self setWantsFullScreenLayout:YES];
  return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  //add controls
  self.controls = [self fullscreenControlsViewInstance];

  self.controls.pauseButton.target = self.player;
  self.controls.pauseButton.action = @selector(pause);
  self.controls.playButton.target = self.player;
  self.controls.playButton.action = @selector(play);

  self.controls.nextButton.target = self.player;
  self.controls.nextButton.action = @selector(nextVideo);

  self.controls.previousButton.target = self.player;
  self.controls.previousButton.action = @selector(previousVideo);

  self.controls.doneButton.target = self.delegate;
  self.controls.doneButton.action = @selector(onFullscreenDoneButtonClick);

  self.controls.videoGravityFillButton.target = self.delegate;
  self.controls.videoGravityFillButton.action = @selector(switchVideoGravity);

  self.controls.videoGravityFitButton.target = self.delegate;
  self.controls.videoGravityFitButton.action = @selector(switchVideoGravity);

  self.controls.closedCaptionsButton.target = self.delegate;
  self.controls.closedCaptionsButton.action = @selector(closedCaptionsSelector);

  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingStarted) forControlEvents:UIControlEventTouchDown];
  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingChanged) forControlEvents:UIControlEventValueChanged];
  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingEnded) forControlEvents:UIControlEventTouchUpInside];
  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingEnded) forControlEvents:UIControlEventTouchUpOutside];

  [super viewDidLoad];
}

- (void)onScrubbingStarted {
  wasPlaying = self.player.isPlaying;
  if(wasPlaying) {
    [self.player pause];
  }
  seeking = YES;
}

- (void)onScrubbingChanged {
  if (self.player.seekStyle == OOSeekStyleEnhanced) {
    [self.player seek:self.controls.scrubberSlider.scrubberAbsoluteValue];
  }
}

- (void)onScrubbingEnded {
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
  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
  [super hideControls];
  [self updateClosedCaptionsPosition];
}

- (void)showControls {
  if (!self.isVisible) return;
  [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
  [super showControls];
  [self updateClosedCaptionsPosition];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  previousStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
  [self updateClosedCaptionsPosition];

  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
  else
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];

  [self syncUI];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];

  [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
  [[UIApplication sharedApplication] setStatusBarStyle:previousStatusBarStyle];
}

- (void)syncUI {
  [super syncUI];

  if (!self.controls)
    return;

  [self updateClosedCaptionsButton];

  if (self.player.allowsExternalPlayback != self.controls.volumeView.volumeSlider.showsRouteButton) {
    self.controls.volumeView.volumeSlider.showsRouteButton = self.player.allowsExternalPlayback;
  }

  // handle gravity
  if(self.player.videoGravity == OOOoyalaPlayerVideoGravityResizeAspect) {
    [self.controls setVideoGravityFillButtonShowing:YES];
  } else {
    [self.controls setVideoGravityFillButtonShowing:NO];
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
    if (self.controls.playButtonShowing) {
      [self.controls setPlayButtonShowing:NO];
      if (self.controls.hidden == NO) {
        [self showControls];
      }
    }
  } else {
    if (!self.controls.playButtonShowing) {
      [self.controls setPlayButtonShowing:YES];
      [self showControls];
      if (self.hideControlsTimer != nil) [self.hideControlsTimer invalidate];
    }
  }

  self.controls.scrubberSlider.scrubber.userInteractionEnabled = self.player.seekable;

  if ((self.player.state == OOOoyalaPlayerStateLoading) && seeking == NO)
    [self.activityView startAnimating];
  else
    [self.activityView stopAnimating];
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

- (OOFullScreenControlsView *)fullscreenControlsViewInstance {
  return [[OOFullScreenControlsView alloc] initWithFrame:self.view.bounds];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [self updateClosedCaptionsPosition];
}

- (void)updateClosedCaptionsPosition {
  [self.player updateClosedCaptionsViewPosition:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0) withControlsHide:self.controls.hidden];
}

- (void)dealloc {}
@end
