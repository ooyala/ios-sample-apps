/**
 * @file       OOInlineViewController.m
 * @brief      Implementation of OOInlineViewController
 * @details    OOInlineViewController.m in OoyalaSDK
 * @date       1/13/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import "OOInlineViewController.h"
#import "OOOoyalaPlayer.h"
#import "OOInlineControlsView.h"
#import "OOInlineIOS7ControlsView.h"
#import "OOUIProgressSlider.h"
#import "OOVideo.h"
#import "OOUIUtils.h"

@interface OOInlineViewController() {
  BOOL wasPlaying;
  BOOL seeking;
}

@property (nonatomic) OOInlineControlsView *controls;

- (OOInlineControlsView *)inlineControlsViewInstance;

@end

@implementation OOInlineViewController

@dynamic controls;

- (void)viewDidLoad {

  self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
  
  //add controls
  self.controls = [self inlineControlsViewInstance];

  [self.controls.pauseButton addTarget:self.player action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
  [self.controls.playButton addTarget:self.player action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
  [self.controls.fullscreenButton addTarget:self.delegate action:@selector(showFullscreen) forControlEvents:UIControlEventTouchUpInside];

  [self.controls.closedCaptionsButton addTarget:self.delegate action: @selector(closedCaptionsSelector) forControlEvents:UIControlEventTouchUpInside];

  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingStarted) forControlEvents:UIControlEventTouchDown];
  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingChanged) forControlEvents:UIControlEventValueChanged];
  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingEnded) forControlEvents:UIControlEventTouchUpInside];
  [self.controls.scrubberSlider.scrubber addTarget:self action:@selector(onScrubbingEnded) forControlEvents:UIControlEventTouchUpOutside];

  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [self.player updateClosedCaptionsViewPosition:self.controls.navigationBar.frame withControlsHide:self.controls.hidden];
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

- (void)syncUI {
  [super syncUI];
  if (!self.controls)
    return;
  
  //Hiding until we have UX to support it
  //Closed Captions button
  //[self updateClosedCaptionsButton];

  // Handle LIVE streams
  self.controls.scrubberSlider.mode = [super sliderMode];

  //Handle time
  if (seeking == NO) {
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

- (void) setFullScreenButtonShowing: (BOOL) isShowing {
    [self.controls setFullscreenButtonShowing:isShowing];
}

- (OOInlineControlsView *)inlineControlsViewInstance {
  return [[OOInlineControlsView alloc] initWithFrame:self.view.bounds];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [self updateClosedCaptionsPosition];
}

- (void)updateClosedCaptionsPosition {
  [self.player updateClosedCaptionsViewPosition:self.controls.navigationBar.frame withControlsHide:self.controls.hidden];
}

- (void)dealloc {}
@end
