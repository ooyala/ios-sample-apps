//
// Created by Jon Slenk on 9/26/14.
// Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "OOCuePointsView.h"
#import "OOUIUtils.h"

@interface OOCuePointsView()
@property (nonatomic, readonly) float padding;
@property (nonatomic, readonly, weak) id<OOCuePointViewDurationDataSource> durationDataSource;
@property (nonatomic, readonly) float diameter;
@end

@implementation OOCuePointsView

- (instancetype)initWithFrame:(CGRect)frame {
  [NSException raise:@"Not implemented" format:@"unavailable"];
  return nil;
}

- (instancetype)initWithFrame:(CGRect)frame padding:(float)padding durationDataSource:(id <OOCuePointViewDurationDataSource>)durationDataSource diameter:(float)diameter {
  if( self = [super initWithFrame:frame] ) {
    _padding = padding;
    _durationDataSource = durationDataSource;
    _diameter = diameter;
    self.opaque = NO;
    self.userInteractionEnabled = NO;
    self.bounds;
  }
  return self;
}

-(void)drawRect:(CGRect)rect {
  // just for testing!
//  NSMutableSet *test_set = [NSMutableSet setWithSet:self.cuePointsAtSeconds];
//  [test_set addObject:[NSNumber numberWithInt:(int)floor(0)]];
//  [test_set addObject:[NSNumber numberWithInt:(int)floor(self.durationDataSource.duration*0.25)]];
//  [test_set addObject:[NSNumber numberWithInt:(int)floor(self.durationDataSource.duration*0.5)]];
//  [test_set addObject:[NSNumber numberWithInt:(int)floor(self.durationDataSource.duration*0.55)]];
//  [test_set addObject:[NSNumber numberWithInt:(int)floor(self.durationDataSource.duration)]];
//  self.cuePointsAtSeconds = test_set;

  CGRect sliderRect = CGRectInset( self.bounds, self.padding, self.padding );
  [OOUIUtils doSafeGStateBlock:^(CGContextRef cref) {
    [[UIColor clearColor] set];
    CGContextFillRect( cref, rect );
    for (NSNumber *time in self.cuePointsAtSeconds) {
      [self drawCuePointInRect:sliderRect time:[time intValue] context:cref];
    }
  }];
}

-(void)drawCuePointInRect:(CGRect)rect time:(int)time context:(CGContextRef)context {
  float positionFactor = self.durationDataSource.duration == 0 ? 0 : time / self.durationDataSource.duration;
  positionFactor = MIN( 1, MAX( 0, positionFactor ) );

  CGRect centeredRect = CGRectMake(
    rect.origin.x + rect.size.width * positionFactor - self.diameter/2,
    rect.origin.y + rect.size.height / 2 - self.diameter/2,
    self.diameter,
    self.diameter );

  CGSize shadowOffset = CGSizeMake( 2, 2 );
  CGContextSetShadow( context, shadowOffset, 1 );
  [[UIColor whiteColor] set];
  CGContextFillEllipseInRect( context, centeredRect );
}

@end