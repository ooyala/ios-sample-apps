/**
 * @file       OOUIProgressSlider.m
 * @brief      Implementation of OOUIProgressSlider
 * @details    OOUIProgressSlider.m in OoyalaSDK
 * @date       1/9/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import "OOUIProgressSlider.h"
#import "OOUIUtils.h"

#import "OOOoyalaPlayerViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface OOThickUISlider : UISlider
@end

@implementation OOThickUISlider
-(CGRect)trackRectForBounds:(CGRect)bounds {
  return CGRectInset(bounds, 0, 6);
}

@end

@interface OOUIProgressSlider()
@property (nonatomic) UILabel *currentTimeLabel;
@property (nonatomic) UILabel *currentTimeInverseLabel;
@property (nonatomic) UILabel *liveIndicator;

- (void)updateLabels;
- (void)onTouchDrag;
- (void)drawLiveIndicator;
- (float)getLivePlayhead;
@end

@implementation OOUIProgressSlider

@synthesize duration, currentTime, currentAvailableTime, seekableTimeRange;
@synthesize currentTimeLabel, currentTimeInverseLabel, liveIndicator, scrubber;

- (id) initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  return self;
}

- (id)init {
  self = [super init];
  return self;
}

- (void)setMode:(OOUIProgressSliderMode)aMode {
  mode = aMode;

  switch (aMode) {
    case OOUIProgressSliderModeLiveNoSrubber:
      currentTimeLabel.hidden = currentTimeInverseLabel.hidden = scrubber.hidden = YES;
      liveIndicator.hidden = NO;
      break;
    case OOUIProgressSliderModeLive:
      currentTimeLabel.hidden = currentTimeInverseLabel.hidden = scrubber.hidden = NO;
      liveIndicator.hidden = YES;
      [currentTimeInverseLabel setText:liveIndicator.text];
      break;

    case OOUIProgressSliderModeNormal:
      currentTimeLabel.hidden = currentTimeInverseLabel.hidden = scrubber.hidden = NO;
      liveIndicator.hidden = YES;
      break;

    case OOUIProgressSliderModeAdInLive:
      currentTimeLabel.hidden = currentTimeInverseLabel.hidden = scrubber.hidden = YES;
      liveIndicator.hidden = NO;
      break;

    default:
      break;
  }
}

- (OOUIProgressSliderMode)mode {
  return mode;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  if (self) {
    self.contentMode = UIViewContentModeRedraw;
    self.autoresizesSubviews = YES;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];

    // scrubber
    scrubber = [[OOThickUISlider alloc] initWithFrame:CGRectMake(45, -1, self.bounds.size.width-90, self.bounds.size.height)];
    scrubber.backgroundColor = [UIColor clearColor];
    scrubber.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    if ([scrubber respondsToSelector:@selector(setMaximumTrackTintColor:)])
      scrubber.maximumTrackTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.2];
    [scrubber addTarget:self action:@selector(onTouchDrag) forControlEvents:UIControlEventTouchDragInside];
    [scrubber addTarget:self action:@selector(onTouchDrag) forControlEvents:UIControlEventTouchDragOutside];
    scrubber.hidden = YES;
    [self addSubview:scrubber];
    
    // scrubber thumb
    UIImage *thumb = [OOUIUtils imageFromBase64String:@"iVBORw0KGgoAAAANSUhEUgAAACQAAAAlCAMAAAAdgrsPAAAAA3NCSVQICAjb4U/gAAABgFBMVEX////R09T////////V19jT1NX7+/v7+/vf4eHX2dnT1db////b3N3Z29v////r6+vh4uP////j5OXh4eHX19fJycnj4+P5+fny8/Pt7e3s7e3b29vR0dHMzMz39/f09fXj5OXd39/Nz9CJiYmCg4N2dnZsbGxpaWr////////19fX09fXw8fHr6+vp6urf39/Z2dnT09PPz8/BwcG9vb25ubmtra2jo6ObnJ34+fnz8/Tw8fHt7e3s7e3p6enn6Onl5uff39/c3d7MzMzJy8yoqamRkpKQkZJ6enpvcHDf39/39/f19vbz8/Pn6Onn5+fl5eXHx8fFxcW1tbXy8/Pv7+/u7+/n5+fl5eXFx8i/wcK+v8C1trezs7OxsrOvsLGWlpaPj4+FhoaDhIV8fHz////7+/vl5ufDw8P4+fnx8fHv7+/l5ufj4+Pc3d7b3N3T1NXDw8O+v8C1trexsbGrq6uVlZWTk5ORkpKNjY35+fn19vb19fXx8fHp6urj5eVqtVnyAAAAgHRSTlMA/+7////u/////4j//8z//yLu7u7u/+7u7u7u7u7/////////////M1Xu7u7u7u7u7u7u7u7u7u7//////////////////////yLu7u7u7u7u7u7//////////////////////xEziMzu7u7u7u7u7u7u7u7u7u7u7v///////xk3mKsAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAAedEVYdFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzUuMasfSOsAAAKSSURBVDiNhZTnV+JQEMVDaMHQEzooEkKU6tLVtexKaHbRVSFCRBTsropl67++L6EYEs7Z+zHzm/vm5by5ECTQLKqX89Kjs9BYmVBYDg8lt6EmKTOCwLAqGHa2xTb6EQSGbVdRM4aVhcwMLJIq5DTf4Q+4gLoQM/B6eCuGuz2e+JAyBW0ixmaP3Lrclr1EwjKg9A77ukrIXG46bmJ4fDeZekp1ekz7aCd6HfygVOt2xzYGjBKp53T6ib9jOea6x7Yd9uClipNtIxSObGNzPuakwVRzSq2ZO7CtdH/CYztRR9i+GQptXl07txAfTdPMsU8mk01oEM7Kbdn1uPF7bGcrGnE6I1HvFyafp2scAaRUaM3gtNxjMmGJP8zdYdit2Yzo6s0CXe0jPatZqJ2sVFIJYPaAz7lcSqZFDF36VtNtqFNJp59Tj3sWT9y9dtwssvWcbETcebVuJtN9fkom9r5XG+TZqA0P6bwQk8lmM9105eSEYQMEfSwTa0JnhOrZ15dsJgPunC+dNnISBkxuhOiX9/e3PMvSzVKhviZletBb039GnLJ+wIjH+YDeW2TLT7QCp41xPtxMVqhLkCWyVaQIesw8g1/QIchAiaT8Y+7FS6kBP7OcJymKItmatKycUCg0OuQQrFe2SFGBAiOpanTar9PTiHfFAV5B5yxANfsD9Zu5MoIYrX9XD5cNByj36F6LfrYqbDZavUerK8t/DEufvy0ubPBL2qHpmkLQvLJsAOWDxd/7U78m59Vo75F31rRWQfPB4v7C1M/J+R9qNRcL/W0p3ywZDLw33wy6+TIveJgIFxtTC4JmgeAZwQqr1OKyhAFhoB+DyPXi9AHRI7ZBpQFlGsXgcSHG6f9xOND5ueTTP79WgJvpn3XWAAAAAElFTkSuQmCC"];
    thumb = [UIImage imageWithCGImage:[thumb CGImage] scale:2.7 orientation:UIImageOrientationUp];
    [scrubber setThumbImage:thumb forState:UIControlStateNormal];

    //current time label
    currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 36, self.bounds.size.height)];
    currentTimeLabel.backgroundColor = [UIColor clearColor];
    currentTimeLabel.textColor = [UIColor whiteColor];
    currentTimeLabel.font = [UIFont boldSystemFontOfSize:12];
    currentTimeLabel.textAlignment = UITextAlignmentRight;
    currentTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    currentTimeLabel.adjustsFontSizeToFitWidth = YES;
    currentTimeLabel.hidden = YES;
    [self addSubview:currentTimeLabel];
    
    //current time inverse label
    currentTimeInverseLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 36, 0, 36, self.bounds.size.height)];
    currentTimeInverseLabel.backgroundColor = [UIColor clearColor];
    currentTimeInverseLabel.textColor = [UIColor whiteColor];
    currentTimeInverseLabel.font = [UIFont boldSystemFontOfSize:12];
    currentTimeInverseLabel.textAlignment = UITextAlignmentLeft;
    currentTimeInverseLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    currentTimeInverseLabel.adjustsFontSizeToFitWidth = YES;
    currentTimeInverseLabel.hidden = YES;
    [self addSubview:currentTimeInverseLabel];
    
    
    // live indicator
    liveIndicator = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 46)/ 2, 0, 46, self.frame.size.height)];
    liveIndicator.backgroundColor = [UIColor clearColor];
    liveIndicator.textColor = [OOUIUtils colorByDarkening:[UIColor whiteColor] by:0.8];
    liveIndicator.font = [UIFont boldSystemFontOfSize:10.5];
    liveIndicator.textAlignment = UITextAlignmentCenter;
    liveIndicator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    liveIndicator.text = [[OOOoyalaPlayerViewController currentLanguageSettings] objectForKey:@"LIVE"];
    liveIndicator.hidden = YES;
    [self addSubview:liveIndicator];
  }
  
  return self;
}

- (void)drawRect:(CGRect)rect {
  if(!liveIndicator.hidden) {     // drawing is for live indicator only
    [self drawLiveIndicator];
  }

  if(!scrubber.hidden) {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    rect = CGRectOffset(CGRectInset([scrubber trackRectForBounds:rect], 46, 0), 1, 1);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0.6 * self.alpha);
    CGFloat radius = rect.size.height / 2;
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);

    CGMutablePathRef path = CGPathCreateMutable();
    CGContextMoveToPoint(context, minx, midy);
    CGPathMoveToPoint(path, NULL, minx, midy);
    CGPathAddArcToPoint(path, NULL, minx, miny, midx, miny, radius);
    CGPathAddArcToPoint(path, NULL, maxx, miny, maxx, midy, radius);
    CGPathAddArcToPoint(path, NULL, maxx, maxy, midx, maxy, radius);
    CGPathAddArcToPoint(path, NULL, minx, maxy, minx, midy, radius);
    CGPathCloseSubpath(path);

    CGRect bounds = rect;
    bounds.size.width *= (duration ? currentAvailableTime / duration : 0);
    CGContextClipToRect(context, bounds);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGPathRelease(path);
  }
}

- (void)drawLiveIndicator {
  liveIndicator.text = [[OOOoyalaPlayerViewController currentLanguageSettings] objectForKey:@"LIVE"];
  CGSize bestSize = [liveIndicator sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
  [liveIndicator setFrame:CGRectMake((self.frame.size.width - bestSize.width)/2, 0, bestSize.width, self.frame.size.height)];

  float darkeningFactor = mode == OOUIProgressSliderModeAdInLive ? 0.4 : 0.8;
  UIColor *liveColor = [OOUIUtils colorByDarkening:[UIColor whiteColor] by:darkeningFactor];
  liveIndicator.textColor = liveColor;
}

- (void)updateTimeDisplay {
  if (isfinite(duration) && isfinite(currentTime)) {
    [scrubber setMinimumValue:0];
    if (self.mode == OOUIProgressSliderModeLive) {
      Float64 seekLength = CMTimeGetSeconds(self.seekableTimeRange.duration);
      if (!isfinite(seekLength)) { seekLength = 0; }
      [scrubber setMaximumValue:seekLength];
      [scrubber setValue:[self getLivePlayhead]];

    } else {
      [scrubber setMaximumValue:duration];
      [scrubber setValue:currentTime];
    }
    [self updateLabels];
    [self setNeedsDisplay];
  }
}

/**
 * For Live, we return the playhead as relative seconds to the current live playhead.
 * Will show as a negative value when trying to seek back.
 */
- (float) getLivePlayhead {
  Float64 seekStart = CMTimeGetSeconds(self.seekableTimeRange.start);
  Float64 seekLength = CMTimeGetSeconds(self.seekableTimeRange.duration);
  if (!isfinite(seekStart) || !isfinite(seekLength)) { return 0; }
  if (self.currentTime > seekStart + seekLength) {
    return seekLength;
  }
  return (self.currentTime - seekStart);
}

- (void)updateLabels {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
  if (self.mode == OOUIProgressSliderModeLive) {
    float livePlayhead = [self getLivePlayhead];
    Float64 seekLength = CMTimeGetSeconds(self.seekableTimeRange.duration);
    float timeToLive = seekLength - livePlayhead;
    timeToLive = isnormal(timeToLive) ? timeToLive : 0;
    [formatter setDateFormat:timeToLive < .5 ? @"m:ss" : timeToLive < 3600 ? @"-m:ss" : @"-H:mm:ss"];
    [currentTimeLabel setText:[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:round(timeToLive)]]];
    [currentTimeInverseLabel setText:liveIndicator.text];
  } else {
    float timeRemainingSeconds = round(scrubber.maximumValue) - round(scrubber.value);
    [formatter setDateFormat:scrubber.maximumValue < 3600 ? @"m:ss" : @"H:mm:ss"];
    [currentTimeLabel setText:[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:round(scrubber.value)]]];

    [formatter setDateFormat:scrubber.maximumValue < 3600 ? @"-m:ss" : @"-H:mm:ss"];
    [currentTimeInverseLabel setText:[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeRemainingSeconds]]];    
  }
}

- (void)onTouchDrag {
  [self updateLabels];
}

- (Float64)scrubberAbsoluteValue {
  if (self.mode == OOUIProgressSliderModeLive) {
    Float64 seekStart = CMTimeGetSeconds(self.seekableTimeRange.start);
    if (!isfinite(seekStart)) { seekStart = 0; }
    return self.scrubber.value + seekStart; 
  }
  return self.scrubber.value;
}

@end
