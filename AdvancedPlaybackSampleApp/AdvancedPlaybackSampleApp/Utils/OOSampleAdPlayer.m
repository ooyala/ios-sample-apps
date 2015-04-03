//
//  OOSamplePlayer.m
//  PluginSampleApp
//
//  Created by Zhihui Chen on 9/2/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import"OOSampleAdPlayer.h"

#define DURATION 5
#define REFRESH_RATE 0.25

@interface OOSampleAdPlayer ()

@property NSTimer *refreshTimer;
@property OOStateNotifier *stateNotifier;
@property Float64 playheadTime;
@property NSString *adText;

@end

@implementation OOSampleAdPlayer

@synthesize seekable = _seekable;
@synthesize seekableTimeRange = _seekableTimeRange;
@synthesize allowsExternalPlayback = _allowsExternalPlayback;
@synthesize externalPlaybackActive = _externalPlaybackActive;
@synthesize rate = _rate; // playback rate
@synthesize bitrate = _bitrate;


- (instancetype)initWithFrame:(CGRect)frame notifier:(OOStateNotifier *)notifier {
  self = [super initWithFrame:frame];
  if (self) {
    _stateNotifier = notifier;
    _seekable = NO;
    _seekableTimeRange = CMTimeRangeMake(CMTimeMake(0, 1), CMTimeMake(DURATION, 1));
    _allowsExternalPlayback = NO;
    _externalPlaybackActive = NO;
    _rate = 0;
    _bitrate = 0;
    [_stateNotifier setState:OOOoyalaPlayerStateLoading];
    _playheadTime = 0;
  }
  self.textColor = [UIColor blackColor];
  self.backgroundColor = [UIColor blueColor];
  return self;
}

- (OOOoyalaPlayerState)state {
  return _stateNotifier.state;
}

- (void)loadAd:(OOSampleAdSpot *)ad {
  self.adText = ad.text;
  self.text = [NSString stringWithFormat:@"%@ - %d", self.adText, DURATION];
  [self.stateNotifier setState:OOOoyalaPlayerStateReady];
}

#pragma mark player

- (void)play {
  self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:REFRESH_RATE target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
  [self.stateNotifier setState:OOOoyalaPlayerStatePlaying];
}

- (void)pause {
  [self.refreshTimer invalidate];
  self.refreshTimer = nil;
  [self.stateNotifier setState:OOOoyalaPlayerStatePaused];
}

- (void)stop {
  
}

- (Float64)duration {
  return DURATION;
}

- (Float64)buffer {
  return 0;
}

- (void)seekToTime:(Float64)time {
  
}

- (BOOL)hasCustomControls {
  return NO;
}

#pragma mark Timer

- (void)onTimer:(NSTimer *)timer {
  _playheadTime += REFRESH_RATE;
  if (_playheadTime >= DURATION) {
    [_refreshTimer invalidate];
    _refreshTimer = nil;
    _playheadTime = DURATION;
    [self.stateNotifier setState:OOOoyalaPlayerStateCompleted];
  }
  [self setText:[NSString stringWithFormat:@"%@ - %d", self.adText, (int)round(DURATION - _playheadTime)]];
  [self.stateNotifier notifyPlayheadChange];
}

#pragma mark LifeCycle

- (void)destroy {
  [_refreshTimer invalidate];
  _refreshTimer = nil;
}

- (void)suspend {

}

- (void)resume {

}

- (void)resume:(Float64)time stateToResume:(OOOoyalaPlayerState)state {

}

- (void)reset {
  // do nothing
}

- (void)setVideoGravity:(OOOoyalaPlayerVideoGravity)gravity {
  
}
@end
