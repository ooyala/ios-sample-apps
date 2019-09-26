//
//  OOSamplePlayer.m
//  PluginSampleApp
//
//  Created on 9/2/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "OOSampleAdPlayer.h"
#import "OOSampleAdSpot.h"

@interface OOSampleAdPlayer ()

@property NSTimer *refreshTimer;
@property OOStateNotifier *stateNotifier;
@property Float64 playheadTime;
@property NSString *adText;

@end

@implementation OOSampleAdPlayer

#pragma mark - Consts

static const Float64 duration   = 5;
static const double refreshRate = 0.25;

#pragma mark - ivars

@synthesize seekable = _seekable;
@synthesize seekableTimeRange = _seekableTimeRange;
@synthesize allowsExternalPlayback = _allowsExternalPlayback;
@synthesize externalPlaybackActive = _externalPlaybackActive;
@synthesize rate = _rate; // playback rate
@synthesize bitrate = _bitrate;
@synthesize ooPlayerState;
@synthesize supportsVideoGravityButton;

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame notifier:(OOStateNotifier *)notifier {
  if (self = [super initWithFrame:frame]) {
    _stateNotifier = notifier;
    _seekable = NO;
    _seekableTimeRange = CMTimeRangeMake(CMTimeMake(0, 1), CMTimeMake(duration, 1));
    _allowsExternalPlayback = NO;
    _externalPlaybackActive = NO;
    _rate = 0;
    _bitrate = 0;
    _stateNotifier.notifierState = OOOoyalaPlayerStateLoading;
    _playheadTime = 0;
  }
  self.textColor = UIColor.blackColor;
  self.backgroundColor = UIColor.blueColor;
  return self;
}

- (OOOoyalaPlayerState)ooPlayerState {
  return _stateNotifier.notifierState;
}

- (void)loadAd:(OOSampleAdSpot *)ad {
  self.adText = ad.text;
  self.text = [NSString stringWithFormat:@"%@ - %f", self.adText, duration];
  self.stateNotifier.notifierState = OOOoyalaPlayerStateReady;
}

#pragma mark player

- (void)play {
  self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:refreshRate
                                                       target:self
                                                     selector:@selector(onTimer:)
                                                     userInfo:nil
                                                      repeats:YES];
  self.stateNotifier.notifierState = OOOoyalaPlayerStatePlaying;
}

- (void)pause {
  [self.refreshTimer invalidate];
  self.refreshTimer = nil;
  [self.stateNotifier setNotifierState:OOOoyalaPlayerStatePaused];
}

- (void)stop {}

- (Float64)duration {
  return duration;
}

- (Float64)buffer {
  return 0;
}

- (void)seekToTime:(Float64)time {}

- (BOOL)hasCustomControls {
  return NO;
}

#pragma mark Timer

- (void)onTimer:(NSTimer *)timer {
  self.playheadTime += refreshRate;
  if (self.playheadTime >= duration) {
    [self.refreshTimer invalidate];
    self.refreshTimer = nil;
    self.playheadTime = duration;
    self.stateNotifier.notifierState = OOOoyalaPlayerStateCompleted;
  }
  [self setText:[NSString stringWithFormat:@"%@ - %d", self.adText, (int)round(duration - self.playheadTime)]];
  [self.stateNotifier notifyPlayheadChange];
}

#pragma mark LifeCycle

- (void)destroy {
  [_refreshTimer invalidate];
  _refreshTimer = nil;
}

- (void)suspend {}

- (void)resume {}

- (void)resume:(Float64)time stateToResume:(OOOoyalaPlayerState)state {}

- (void)reset {
  // do nothing
}

- (void)setVideoGravity:(OOOoyalaPlayerVideoGravity)gravity {}

- (BOOL)isLiveClosedCaptionsAvailable {
  return NO;
}

@end
