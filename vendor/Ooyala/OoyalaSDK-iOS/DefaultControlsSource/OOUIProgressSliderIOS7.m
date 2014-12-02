//
//  OOUIProgressSliderIOS7.m
//  OoyalaSDK
//
//  Created by Liusha Huang on 8/22/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import "OOUIProgressSliderIOS7.h"
#import "OOImagesIOS7.h"
#import "OOUIUtils.h"
#import "OOOoyalaPlayerViewController.h"
#import "OOBufferView.h"
#import "OOCuePointsView.h"

#define BUFFER_RECT_HEIGHT (2)
#define CUE_POINT_HEIGHT (BUFFER_RECT_HEIGHT*5)
#define PAD_FOR_CUE_POINTS (CUE_POINT_HEIGHT*1.1)

#pragma mark OOThickUISliderIOS7

@interface OOThickUISliderIOS7 : UISlider
@end
@implementation OOThickUISliderIOS7
-(CGRect)trackRectForBounds:(CGRect)bounds {
  return CGRectInset(bounds, 0, 18);
}
@end

#pragma mark OOUIProgressSliderIOS7

@interface OOUIProgressSliderIOS7()
@property (nonatomic) UILabel *currentTimeLabel;
@property (nonatomic) UILabel *currentTimeInverseLabel;
@property (nonatomic) OOBufferView *bufferView;
@property (nonatomic) OOCuePointsView *cuePointsView;
@property (nonatomic) UIImageView *thumbImageView;
@property (nonatomic) UIView *emptySliderBar;
@end

@implementation OOUIProgressSliderIOS7

- (id) initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  return self;
}

- (id)init {
  self = [super init];
  return self;
}

-(void)setCuePointsAtSeconds:(NSSet *)cuePointsAtSeconds {
  if( self.cuePointsView ) {
    self.cuePointsView.cuePointsAtSeconds = cuePointsAtSeconds;
  }
}

- (void)setMode:(OOUIProgressSliderMode)aMode {
  mode = aMode;
  
  switch (aMode) {
    case OOUIProgressSliderModeLiveNoSrubber:
      self.thumbImageView.hidden = self.currentTimeLabel.hidden = self.currentTimeInverseLabel.hidden = self.scrubber.hidden = self.bufferView.hidden = self.emptySliderBar.hidden = YES;
      self.liveIndicator.hidden = NO;
      break;

    case OOUIProgressSliderModeLive:
      self.thumbImageView.hidden = self.currentTimeLabel.hidden = self.currentTimeInverseLabel.hidden = self.scrubber.hidden = self.bufferView.hidden = self.emptySliderBar.hidden = NO;
      self.liveIndicator.hidden = YES;
      [self.currentTimeInverseLabel setText:self.liveIndicator.text];
      break;
      
    case OOUIProgressSliderModeNormal:
      self.thumbImageView.hidden = self.currentTimeLabel.hidden = self.currentTimeInverseLabel.hidden = self.scrubber.hidden = self.bufferView.hidden = self.emptySliderBar.hidden = NO;
      self.liveIndicator.hidden = YES;
      break;
      
    case OOUIProgressSliderModeAdInLive:
      self.thumbImageView.hidden = self.currentTimeLabel.hidden = self.currentTimeInverseLabel.hidden = self.scrubber.hidden = self.bufferView.hidden = self.emptySliderBar.hidden = YES;
      self.liveIndicator.hidden = NO;
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

  // setup constant for different devices
  if (self) {
    CGRect sliderBackgroundRect;
    CGRect sliderRect;
    CGRect timeLabelRect;
    CGRect inverseTimeLabelRect;
    CGFloat thumbImageSize;
    CGFloat fontSize;
    if ([OOUIUtils isIpad]) {
      fontSize = 22;
      sliderRect = CGRectMake(85, 0, self.bounds.size.width - 170, self.bounds.size.height);
      sliderBackgroundRect = CGRectMake(86, 18, self.bounds.size.width - 170, 4);
      timeLabelRect = CGRectMake(0, 0, 72, self.bounds.size.height);
      inverseTimeLabelRect = CGRectMake(self.bounds.size.width - 72, 0, 72, self.bounds.size.height);
      thumbImageSize = 2.7;
    } else {
      fontSize = 12;
      sliderRect = CGRectMake(42, 0.5, self.bounds.size.width - 88, self.bounds.size.height);
      sliderBackgroundRect = CGRectMake(45, 18.5, self.bounds.size.width - 90, 4);
      timeLabelRect = CGRectMake(0, 0, 36, self.bounds.size.height);
      inverseTimeLabelRect = CGRectMake(self.bounds.size.width - 30, 0, 30, self.bounds.size.height);
      thumbImageSize = 4.5;
    }
    self.contentMode = UIViewContentModeRedraw;
    self.autoresizesSubviews = YES;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];

    
    // This view is for the background of UISlider bar
    self.emptySliderBar = [[UIView alloc] initWithFrame:sliderBackgroundRect];
    self.emptySliderBar.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.3 alpha:0.0];
    [self.emptySliderBar.layer setCornerRadius:2.0f];
    [self.emptySliderBar.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.emptySliderBar.layer setBorderWidth:1.3f];
    self.emptySliderBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.emptySliderBar.alpha = 0.5;
    [self addSubview:self.emptySliderBar];

    self.scrubber = [[OOThickUISliderIOS7 alloc] initWithFrame:sliderRect];
    self.scrubber.backgroundColor = [UIColor clearColor];
    self.scrubber.minimumTrackTintColor = [UIColor whiteColor];
    self.scrubber.maximumTrackTintColor = [UIColor clearColor];
    self.scrubber.thumbTintColor =  [UIColor whiteColor];
    self.scrubber.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.scrubber setAlpha:1];
    [self.scrubber addTarget:self action:@selector(onTouchDrag) forControlEvents:UIControlEventTouchDragInside];
    [self.scrubber addTarget:self action:@selector(onTouchDrag) forControlEvents:UIControlEventTouchDragOutside];
    // note: we're going to double-draw it, so that iOS gives us the right grabbing but the cue points appear to draw underneath.
    UIImage *thumbImage = [UIImage imageWithCGImage:[[OOImagesIOS7 thumbImage] CGImage] scale:thumbImageSize orientation:UIImageOrientationUp];
    [self.scrubber setThumbImage:thumbImage forState:UIControlStateNormal];
    [self.scrubber setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [self.scrubber setThumbImage:thumbImage forState:UIControlStateApplication];
    [self.scrubber setThumbImage:thumbImage forState:UIControlStateDisabled];
    [self.scrubber setThumbImage:thumbImage forState:UIControlStateReserved];
    [self.scrubber setThumbImage:thumbImage forState:UIControlStateReserved];
    [self addSubview:self.scrubber];

    // View for drawing available content(buffered content)
    CGRect bufferRect = CGRectMake(self.scrubber.frame.origin.x, self.scrubber.frame.origin.y + 19, self.scrubber.frame.size.width, BUFFER_RECT_HEIGHT);
    self.bufferView = [[OOBufferView alloc] initWithFrame:bufferRect slider:self];
    self.bufferView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.bufferView];

    // cue points draw on top of slider.
    CGRect cuePointsRect = CGRectInset( bufferRect, -PAD_FOR_CUE_POINTS, -PAD_FOR_CUE_POINTS );
    self.cuePointsView = [[OOCuePointsView alloc] initWithFrame:cuePointsRect padding:PAD_FOR_CUE_POINTS durationDataSource:self diameter:CUE_POINT_HEIGHT];
    self.cuePointsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.cuePointsView];

    // cue points must draw on top of slider but under the thumb,
    // so we have to put another thumb image on top of it all.
    self.thumbImageView = [[UIImageView alloc] initWithImage:thumbImage highlightedImage:thumbImage];
    [self addSubview:self.thumbImageView];

    //current time label
    self.currentTimeLabel = [[UILabel alloc] initWithFrame:timeLabelRect];
    self.currentTimeLabel.backgroundColor = [UIColor clearColor];
    self.currentTimeLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    self.currentTimeLabel.font = [UIFont systemFontOfSize:fontSize];
    self.currentTimeLabel.textAlignment = UITextAlignmentRight;
    self.currentTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    self.currentTimeLabel.adjustsFontSizeToFitWidth = YES;
    self.currentTimeLabel.hidden = YES;
    [self addSubview:self.currentTimeLabel];

    //current time inverse label
    self.currentTimeInverseLabel = [[UILabel alloc] initWithFrame:inverseTimeLabelRect];
    self.currentTimeInverseLabel.backgroundColor = [UIColor clearColor];
    self.currentTimeInverseLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    self.currentTimeInverseLabel.font = [UIFont systemFontOfSize:fontSize];
    self.currentTimeInverseLabel.textAlignment = UITextAlignmentLeft;
    self.currentTimeInverseLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.currentTimeInverseLabel.adjustsFontSizeToFitWidth = YES;
    self.currentTimeInverseLabel.hidden = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    [self addSubview:self.currentTimeInverseLabel];
    
    // live indicator
    self.liveIndicator = [[UILabel alloc] init];
    self.liveIndicator.adjustsFontSizeToFitWidth = YES;
    self.liveIndicator.backgroundColor = [UIColor clearColor];
    self.liveIndicator.textColor = [UIColor blackColor];
    self.liveIndicator.font = [UIFont boldSystemFontOfSize:[OOUIUtils isIpad] ? 24 : 10.5];
    self.liveIndicator.textAlignment = UITextAlignmentCenter;
    self.liveIndicator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.liveIndicator.text = [[OOOoyalaPlayerViewController currentLanguageSettings] objectForKey:@"LIVE"];
    self.liveIndicator.hidden = YES;
    [self addSubview:self.liveIndicator];
  }
  return self;
}

-(void) updateThumbImageView {
  CGRect bound = self.scrubber.bounds;
  CGRect trackRect = [self.scrubber trackRectForBounds:bound];
  CGRect thumbRect = [self.scrubber thumbRectForBounds:bound trackRect:trackRect value:self.scrubber.value];
  thumbRect = CGRectOffset( thumbRect, self.scrubber.frame.origin.x, self.scrubber.frame.origin.y );
  self.thumbImageView.frame = thumbRect;
}

- (void)drawRect:(CGRect)rect {
  [self updateThumbImageView];
  [self.bufferView setNeedsDisplay];
  [self.cuePointsView setNeedsDisplay];
}

- (void)drawLiveIndicator {
  self.liveIndicator.text = [[OOOoyalaPlayerViewController currentLanguageSettings] objectForKey:@"LIVE"];
  CGSize bestSize = [self.liveIndicator sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
  [self.liveIndicator setFrame:CGRectMake((self.frame.size.width - bestSize.width)/2, 0, bestSize.width, self.frame.size.height)];
  
  float darkeningFactor = mode == OOUIProgressSliderModeAdInLiveIOS7 ? 0.4 : 0.8;
  UIColor *liveColor = [OOUIUtils colorByDarkening:[UIColor blackColor] by:darkeningFactor];
  self.liveIndicator.textColor = liveColor;
}

- (void)updateTimeDisplay {
  if (isfinite(self.duration) && isfinite(self.currentTime)) {
    [self.scrubber setMinimumValue:0];
    if (self.mode == OOUIProgressSliderModeLive) {
      Float64 seekLength = CMTimeGetSeconds(self.seekableTimeRange.duration);
      if (!isfinite(seekLength)) { seekLength = 0; }
      [self.scrubber setMaximumValue:seekLength];
      [self.scrubber setValue:[self getLivePlayhead]];
      
    } else {
      [self.scrubber setMaximumValue:self.duration];
      [self.scrubber setValue:self.currentTime];
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
    [self.currentTimeLabel setText:[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:round(timeToLive)]]];
    [self.currentTimeInverseLabel setText:self.liveIndicator.text];
  } else {
    float timeRemainingSeconds = round(self.scrubber.maximumValue) - round(self.scrubber.value);
    [formatter setDateFormat:self.scrubber.maximumValue < 3600 ? @"m:ss" : @"H:mm:ss"];
    [self.currentTimeLabel setText:[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:round(self.scrubber.value)]]];
    
    [formatter setDateFormat:self.scrubber.maximumValue < 3600 ? @"-m:ss" : @"-H:mm:ss"];
    [self.currentTimeInverseLabel setText:[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeRemainingSeconds]]];
  }

  [self updateThumbImageView];
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

- (void)dealloc {}
@end
