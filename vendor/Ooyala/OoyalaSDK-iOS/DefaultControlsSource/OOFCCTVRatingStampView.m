//
//Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "OOUIUtils.h"
#import "OOUtils.h"
#import "OOPlayer.h"
#import "OOFCCTVRatingVideoView.h"
#include "OOFCCTVRatingStampView.h"

#define FADE_OUT_DURATION 1
#define MINIMUM_PLAYHEAD_TIME 0.25
#define STAMP_OFFSET_SIZE_1x 5
#define STAMP_BORDER_SIZE_1x 1
#define STAMP_BORDER_CHANNELS 1, 1, 1, 1
#define MAX_SCALE .9
#define STAMP_VERTICAL_PADDING_SIZE_1x 2
#define STAMP_BG_CHANNELS 0, 0, 0, 1
#define TV_TEXT_CHANNELS 1, 1, 1, 1
#define LABELS_TEXT_CHANNELS 1, 1, 1, 1
#define RATING_TEXT_CHANNELS 1, 1, 1, 1
#define FONT_SIZE_FACTOR 0.8
#define MINI_SCALE 0.22
#define FONT_NAME @"HelveticaNeue-CondensedBold" // TODO: pick something better?

@interface OOFCCTVRatingStampView()
@property (nonatomic) BOOL playStarted;
@property (nonatomic) CGRect touchRect;
@end

@implementation OOFCCTVRatingStampView

-(int)calculateMinimumSizeInPixels {
  UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:48];
  NSStringDrawingContext *context = [NSStringDrawingContext new];
  NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
  if ([@"X" respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
    CGRect dimensions = [@"X" boundingRectWithSize:CGSizeMake(500,500) options:0 attributes:attributes context:context];
    return dimensions.size.height;
  }
  else {
    CGSize size = [@"X" sizeWithFont:font];
    return size.height;
  }

}

-(id) initWithCoder:(NSCoder *)aDecoder {
  @throw [NSException exceptionWithName:@"NSInternalConsistencyException"
                                 reason:@"initWithCoder is not supported by OOFCCTVRatingStampView"
                               userInfo:nil];
}

-(instancetype) init {
  if( self = [super init] ) {
    self.hidden = YES;
    self.opaque = NO;
    self.touchRect = CGRectZero;
    self.userInteractionEnabled = NO;
    self.clipsToBounds = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStarted:) name:OOOoyalaPlayerPlayStartedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reshow:) name:OOOoyalaPlayerAdCompletedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reshow:) name:OOOoyalaPlayerAdSkippedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reshow:) name:OOOoyalaPlayerAdErrorNotification object:nil];
  }
  return self;
}

-(void) playStarted:(NSNotification*)notification {
  self.playStarted = YES;
  [self reshow:notification];
}

-(void) reshow:(NSNotification*)notification {
  [CATransaction begin];
  [self.layer removeAllAnimations];
  [CATransaction commit];
  if( [self canShow] ) {
    self.alpha = 1;
    self.hidden = NO;
    [self setNeedsDisplay];
    [self startFadeOut];
  }
}

-(BOOL) canShow {
  return
  self.player != nil &&
  self.tvRatingConfiguration != nil &&
  self.tvRatingConfiguration.durationSeconds != OOFCCTVRATINGCONFIGURATION_DURATION_NONE &&
  self.tvRating != nil &&
  self.playStarted;
}

-(void) setPlayer:(OOPlayer*)player {
  _player = player;
  self.frame = player.view.frame;
}

-(BOOL) pointInside:(CGPoint)point {
  return self.hidden ? NO : CGRectContainsPoint( self.touchRect, point );
}

-(void) drawRect:(CGRect)rect {
  if( rect.size.width > 0 && rect.size.height > 0 ) {
      [self drawInVideoRect:rect];
  }
}

-(void) startFadeOut {
  if( self.tvRatingConfiguration.durationSeconds != OOFCCTVRATINGCONFIGURATION_DURATION_FOR_EVER ) {
    [UIView animateWithDuration:FADE_OUT_DURATION
                          delay:self.tvRatingConfiguration.durationSeconds
                       options:UIViewAnimationOptionCurveLinear
                    animations:^{
                      self.alpha = 0;
                    }
                    completion:^(BOOL finished) {
                      self.hidden = YES;
                    }];
  }
}

-(void) drawInVideoRect:(CGRect)rect {
  CGContextRef cont = UIGraphicsGetCurrentContext();
  [self pushDoPopContext:cont block:^(CGContextRef cgr) {
    CGContextClearRect( cgr, rect );
      [self drawStamp:(CGRect)rect context:cgr];
  }];
}

-(void) drawStamp:(CGRect)videoRect context:(CGContextRef)cont {
  CGRect outerStampRect = CGRectZero;
  CGRect innerStampRect = CGRectZero;
  CGRect paddedInnerStampRect = CGRectZero;
  [self updateStampRectsIn:videoRect outerStampRect:&outerStampRect innerStampRect:&innerStampRect paddedInnerStampRect:&paddedInnerStampRect];
  [self drawStampBackground:outerStampRect innerStampRect:innerStampRect paddedInnerStampRect:paddedInnerStampRect context:cont];
  [self drawTVText:paddedInnerStampRect context:cont];
  [self drawLabelsText:paddedInnerStampRect context:cont];
  [self drawRatingText:paddedInnerStampRect context:cont];
  self.touchRect = outerStampRect;
}

-(void) pushDoPopContext:(CGContextRef)cont block:(void(^)(CGContextRef))block {
  CGContextSaveGState( cont );
  block( cont );
  CGContextRestoreGState( cont );
}

-(void) doClippedToRect:(CGRect)rect context:(CGContextRef)cont block:(void(^)(CGContextRef))block {
  [self pushDoPopContext:cont block:^(CGContextRef cgr) {
    CGContextBeginPath( cgr );
    CGContextAddRect( cgr, rect );
    CGContextClosePath( cgr );
    CGContextClip( cgr );
    block( cgr );
  }];
}

-(void) drawStampBackground:(CGRect)outerStampRect innerStampRect:(CGRect)innerStampRect paddedInnerStampRect:(CGRect)paddedInnerStampRect context:(CGContextRef)cont {
  [self doClippedToRect:outerStampRect context:cont block:^(CGContextRef cgr) {
    CGContextSetRGBFillColor( cgr, STAMP_BORDER_CHANNELS );
    CGContextFillRect( cgr, outerStampRect );
    CGContextSetRGBFillColor( cgr, STAMP_BG_CHANNELS );
    CGContextFillRect( cgr, innerStampRect );
  }];
}

-(void) drawTVText:(CGRect)innerStampRect context:(CGContextRef)cont {
  CGRect tvTextRect = [self calculateTVTextRectIn:innerStampRect];
  [self doClippedToRect:tvTextRect context:cont block:^(CGContextRef cgr) {
    CGContextSetRGBFillColor( cgr, TV_TEXT_CHANNELS );
    [self drawTextCenteredInRect:tvTextRect text:@"TV" context:cgr];
  }];
}

-(void) drawLabelsText:(CGRect)innerStampRect context:(CGContextRef)cont {
  CGRect labelsTextRect = [self calculateLabelsTextRectIn:innerStampRect];
  [self doClippedToRect:labelsTextRect context:cont block:^(CGContextRef cgr) {
    CGContextSetRGBFillColor( cgr, LABELS_TEXT_CHANNELS );
    [self drawTextCenteredInRect:labelsTextRect text:self.tvRating.labels context:cgr];
  }];
}

-(void) drawRatingText:(CGRect)innerStampRect context:(CGContextRef)cont {
  CGRect ratingTextRect = [self calculateRatingTextRectIn:innerStampRect];
  [self doClippedToRect:ratingTextRect context:cont block:^(CGContextRef cgr) {
    CGContextSetRGBFillColor( cgr, RATING_TEXT_CHANNELS );
    [self drawTextCenteredInRect:ratingTextRect text:self.tvRating.ageRestriction context:cgr];
  }];
}

-(void) drawTextCenteredInRect:(CGRect)rect text:(NSString*)text context:(CGContextRef)cont {
  CGFloat fontSize = [self calculateFontSizeInRect:rect text:text];
  UIFont *font = [UIFont fontWithName:FONT_NAME size:fontSize];
  CGSize renderedSize = [text sizeWithFont:font];
  // if these go outside 'rect' we assume it was already set up as a clipping region.
  CGFloat px = (rect.size.width - renderedSize.width)*0.5;
  CGFloat py = (rect.size.height - renderedSize.height)*0.5;
  CGFloat tx = rect.origin.x + px;
  CGFloat ty = rect.origin.y + py;
  CGRect textRect = CGRectMake( tx, ty, renderedSize.width, renderedSize.height );
  [text drawInRect:textRect
          withFont:font
     lineBreakMode:NSLineBreakByTruncatingTail
         alignment:NSTextAlignmentCenter];
}

-(CGFloat) calculateFontSizeInRect:(CGRect)rect text:(NSString*)text {
  UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:100];
  CGSize size;

  if ([@"X" respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
    NSStringDrawingContext *context = [NSStringDrawingContext new];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect dimensions = [@"X" boundingRectWithSize:CGSizeMake(1000,1000) options:0 attributes:attributes context:context];
    size = dimensions.size;
  }
  else {
    size = [@"X" sizeWithFont:font];
  }

  return rect.size.height / size.height * 100;
}

-(BOOL) isSquareish:(CGRect)rect {
  CGFloat ratio = rect.size.width / rect.size.height;
  return ratio > 0.9 && ratio < 1.1;
}

-(void) updateStampRectsIn:(CGRect)videoRect outerStampRect:(CGRect*)outerStampRect innerStampRect:(CGRect*)innerStampRect paddedInnerStampRect:(CGRect*)paddedInnerStampRect {
  [self sizeOuterStampRect:outerStampRect inVideoRect:videoRect];
  [self constrainOuterStampRect:outerStampRect];
  [self updateOuterStampRect:outerStampRect videoRect:videoRect];

  int stampBorderSize = STAMP_BORDER_SIZE_1x * ([OOUIUtils is1xDensity] ? 1 : 2);
  *innerStampRect = CGRectInset( *outerStampRect, stampBorderSize, stampBorderSize );

  int stampVerticalPaddingSize = STAMP_VERTICAL_PADDING_SIZE_1x * ([OOUIUtils is1xDensity] ? 1 : 2);
  *paddedInnerStampRect = CGRectInset( *innerStampRect, 0, stampVerticalPaddingSize );
}

// Generate the outer stamp rectangle based on the halved video
-(void) sizeOuterStampRect:(CGRect*)outerStampRect inVideoRect:(CGRect)videoRect {
  CGFloat scale = self.tvRatingConfiguration == nil ? OOFCCTVRATINGCONFIGURATION_DEFAULT_SCALE : self.tvRatingConfiguration.scale;

  // Base the square off the halved video
  CGFloat w = videoRect.size.width;
  CGFloat h = videoRect.size.height;
  if (videoRect.size.width > videoRect.size.height) {
    w = w / 2;
  } else {
    h = h / 2;
  }
  *outerStampRect = CGRectMake( 0, 0, w * scale, h * scale );
}

-(void) updateOuterStampRect:(CGRect*)outerStampRect videoRect:(CGRect)videoRect {

  int oxSign;
  int oySign;

  switch( self.tvRatingConfiguration.position ) {
    default:
    case OOFCCTvRatingsPositionTopLeft:
      outerStampRect->origin.x = videoRect.origin.x;
      outerStampRect->origin.y = videoRect.origin.y;
      oxSign = 1;
      oySign = 1;
      break;

    case OOFCCTvRatingsPositionTopRight:
      outerStampRect->origin.x = videoRect.origin.x + videoRect.size.width - outerStampRect->size.width;
      outerStampRect->origin.y = videoRect.origin.y;
      oxSign = -1;
      oySign = 1;
      break;

    case OOFCCTvRatingsPositionBottomLeft:
      outerStampRect->origin.x = videoRect.origin.x;
      outerStampRect->origin.y = videoRect.origin.y + videoRect.size.height - outerStampRect->size.height;
      oxSign = 1;
      oySign = -1;
      break;

    case OOFCCTvRatingsPositionBottomRight:
      outerStampRect->origin.x = videoRect.origin.x + videoRect.size.width - outerStampRect->size.width;
      outerStampRect->origin.y = videoRect.origin.y + videoRect.size.height - outerStampRect->size.height;
      oxSign = -1;
      oySign = -1;
      break;
  }

  int stampOffsetSize = STAMP_OFFSET_SIZE_1x * ([OOUIUtils is1xDensity] ? 1 : 2);
  *outerStampRect = CGRectOffset( *outerStampRect, oxSign*stampOffsetSize, oySign*stampOffsetSize );
}

-(void) constrainOuterStampRect:(CGRect*)outerStampRect {
  CGFloat width = outerStampRect->size.width;
  CGFloat height = outerStampRect->size.height;

  // Ensure width and height are of minimum size
  int minimumSize = [self calculateMinimumSizeInPixels];
  width = MAX( width, minimumSize );
  height = MAX( height, minimumSize );

  //Square the stamp
  height = MIN( height, width );
  width = height;

  outerStampRect->size.width = width;
  outerStampRect->size.height = height;
}

-(CGRect) calculateTVTextRectIn:(CGRect)innerStampRect {
  return CGRectMake( innerStampRect.origin.x, innerStampRect.origin.y, innerStampRect.size.width, innerStampRect.size.height * MINI_SCALE );
}

-(CGRect) calculateLabelsTextRectIn:(CGRect)innerStampRect {
  if( [self hasLabels] ) {
    CGFloat height = innerStampRect.size.height * MINI_SCALE;
    return CGRectMake( innerStampRect.origin.x, innerStampRect.origin.y+innerStampRect.size.height-height, innerStampRect.size.width, height );
  }
  else {
    return CGRectZero;
  }
}

-(CGRect) calculateRatingTextRectIn:(CGRect)innerStampRect {
  CGFloat verticalInset = innerStampRect.size.height * MINI_SCALE;
  CGFloat left = innerStampRect.origin.x;
  CGFloat top = innerStampRect.origin.y + verticalInset;
  CGFloat width = innerStampRect.size.width;
  CGFloat height = innerStampRect.size.height - verticalInset - ([self hasLabels] ? verticalInset : 0);
  return CGRectMake( left, top, width, height );
}

-(BOOL) hasLabels {
  return ! [OOUtils isStringNilOrEmpty:self.tvRating.labels];
}

-(void) setVideoGravity:(OOOoyalaPlayerVideoGravity)videoGravity {
  [self setNeedsDisplay];
}

-(void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end