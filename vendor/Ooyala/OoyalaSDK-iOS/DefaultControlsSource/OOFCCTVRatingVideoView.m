//
//  OOFCCTVRatingVideoView.m
//  OoyalaSDK
//
//  Created by Jon Slenk on 8/20/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "OOFCCTVRatingVideoView.h"
#import "OOFCCTVRatingStampView.h"
#import "OOPlayer.h"

@interface OOFCCTVRatingVideoView ()
@property (nonatomic) OOFCCTVRatingStampView *stampView;
@end

@implementation OOFCCTVRatingVideoView
-(id) initWithCoder:(NSCoder *)aDecoder {
  @throw [NSException exceptionWithName:@"NSInternalConsistencyException"
                                 reason:@"initWithCoder is not supported by OOFCCTVRatingVideoView"
                               userInfo:nil];
}

-(id) initWithFrame:(CGRect)frame {
  if( self = [super initWithFrame:frame] ) {
    self.layer.backgroundColor = [UIColor blackColor].CGColor;
    self.userInteractionEnabled = YES;
    self.isAccessibilityElement = NO;
    self.clipsToBounds = NO;
  }
  return self;
}

-(void) layoutSubviews {
  self.stampView.frame = self.stampView.player.videoRect;
  [self.stampView setNeedsDisplay];
}

-(BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  if( self.stampView.hidden ) {
    return YES;
  }
  else {
    BOOL inside = self.stampView != nil && [self.stampView pointInside:point withEvent:event];
    return inside;
  }
}

// I tried to do this in the OOFCCTVRatingStampView itself but couldn't get it to work that way.
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  for( UITouch *touch in event.allTouches ) {
    if( touch.phase == UITouchPhaseEnded ) {
      CGPoint l = [touch locationInView:self.stampView];
      BOOL insideStamp = [self.stampView pointInside:l];
      if( insideStamp && self.stampView.tvRating.clickthroughUrl ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.stampView.tvRating.clickthroughUrl]];
      }
    }
  }
}

-(void) setContentPlayerAndSubview:(OOPlayer*)player {
  [super addSubview:player.view];
  if( self.stampView != nil ) {
    [self.stampView removeFromSuperview];
  }
  self.stampView = [OOFCCTVRatingStampView new];
  self.stampView.tvRating = self.tvRating;
  self.stampView.tvRatingConfiguration = self.tvRatingConfiguration;
  self.stampView.player = player;
  [super addSubview:self.stampView];
}

-(void) setAdPlayerAndSubview:(OOPlayer*)player {
  [super addSubview:player.view];
  // do not show ratings over ads.
  if( self.stampView != nil ) {
    [self.stampView removeFromSuperview];
    self.stampView = nil;
  }
}

-(void) setTvRating:(OOFCCTVRating *)tvRating {
  _tvRating = tvRating;
  if( self.stampView != nil ) {
    self.stampView.tvRating = tvRating;
    self.stampView.videoGravity = self.videoGravity;
  }
}

-(void) setTvRatingConfiguration:(OOFCCTVRatingConfiguration*)tvRatingConfiguration {
  _tvRatingConfiguration = tvRatingConfiguration;
  if( self.stampView != nil ) {
    self.stampView.tvRatingConfiguration = tvRatingConfiguration;
  }
}

-(void) setVideoGravity:(OOOoyalaPlayerVideoGravity)videoGravity {
  _videoGravity = videoGravity;
  if( self.stampView != nil ) {
    self.stampView.videoGravity = videoGravity;
  }
}

@end
