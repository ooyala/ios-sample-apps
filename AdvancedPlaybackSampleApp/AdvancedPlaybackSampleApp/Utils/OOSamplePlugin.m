//
//  OOSamplePlugin.m
//  PluginSampleApp
//
//  Created by Zhihui Chen on 9/2/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "OOSamplePlugin.h"
#import "OOSampleAdSpot.h"
#import "OOSampleAdPlayer.h"

@interface OOSamplePlugin ()

@property (nonatomic, weak) OOOoyalaPlayer *ooplayer;

@property (nonatomic) OOSampleAdSpot *preroll;
@property (nonatomic) OOSampleAdSpot *midroll;
@property (nonatomic) OOSampleAdSpot *postroll;
@property (nonatomic) OOSampleAdSpot *adToPlay;

@property (nonatomic) OOSampleAdPlayer *adPlayer;
@property (nonatomic) OOStateNotifier *notifier;

@end

@implementation OOSamplePlugin

- (instancetype)initWithPlayer:(OOOoyalaPlayer*)player {
  if (self = [super init]) {
    _ooplayer = player;
    _notifier = [player createStateNotifier];
    [_notifier addObserver:self forKeyPath:@"state" options:(NSKeyValueObservingOptionNew) context:nil];
  }
  return self;
}

- (id<OOPlayerProtocol>)player {
  return self.adPlayer;
}

- (void)onAdModeEntered {
  if (self.adToPlay) {
    [self playAd:self.adToPlay];
    self.adToPlay.played = YES;
    self.adToPlay = nil;
  } else {
    [self.ooplayer exitAdMode:self];
  }
}

- (BOOL)onContentChanged {
  self.preroll = [OOSampleAdSpot spotWithTime:0 text:@"preroll"];
  self.midroll = [OOSampleAdSpot spotWithTime:6 text:@"midroll"];
  self.postroll = [OOSampleAdSpot spotWithTime:999999 text:@"postroll"];
  return NO;
}

- (BOOL)onInitialPlay {
  if (!self.preroll.played) {
    self.adToPlay = self.preroll;
    return YES;
  }
  return NO;
}

- (BOOL)onPlayheadUpdate:(Float64)playhead {
  if (playhead > [self.midroll.time floatValue] && !self.midroll.played) {
    self.adToPlay = self.midroll;
    return YES;
  }
  return NO;
}

- (BOOL)onCuePoint:(int)cuePointIndex {
  return NO;
}

- (BOOL)onContentFinished {
  if (!self.postroll.played) {
    self.adToPlay = self.postroll;
    return YES;
  }

  return NO;
}

- (BOOL)onContentError:(int)errorCode {
  return NO;
}

- (void)resetAds {
  self.preroll.played = NO;
  self.midroll.played = NO;
  self.postroll.played = NO;
}

- (void)skipAd {

}

- (NSSet*/*<NSNumber int seconds>*/)getCuePointsAtSeconds {
  NSMutableSet *set = [NSMutableSet new];
  if (self.midroll && !self.midroll.played) {
    [set addObject:self.midroll.time];
  }
  if (self.postroll && !self.postroll.played) {
    [set addObject:self.postroll.time];
  }
  return set;
}


- (void)playAd:(OOSampleAdSpot *)ad {
  CGRect rect = self.ooplayer.view.frame;
  self.adPlayer = [[OOSampleAdPlayer alloc] initWithFrame:rect notifier:self.notifier];
  [self.adPlayer setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
  [self.ooplayer.view addSubview:self.adPlayer];

  [self.adPlayer loadAd:ad];
  [self.adPlayer play];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if (![keyPath isEqualToString:@"state"] || !self.adPlayer) {
    return;
  }

  switch ((OOOoyalaPlayerState)[[change objectForKey:NSKeyValueChangeNewKey] intValue]) {
    case OOOoyalaPlayerStateCompleted:
      [self.adPlayer removeFromSuperview];
      [self.adPlayer destroy];
      self.adPlayer = nil;
      [self.ooplayer exitAdMode:self];
      break;
    default:
      break;
  }
}

#pragma mark lifecycle

- (void)destroy {
  [self.adPlayer destroy];
  
  // remove observer to make notifier consistent when dealloc
  [_notifier removeObserver:self forKeyPath:@"state" context: nil];
}

- (void)reset {

}

- (void)suspend {

}

- (void)resume {

}

- (void)resume:(Float64)time stateToResume:(OOOoyalaPlayerState)state {
  
}

@end
