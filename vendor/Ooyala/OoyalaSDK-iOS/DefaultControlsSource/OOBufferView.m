//
//  OOBufferView.m
//  OoyalaSDK
//
//  Created by Liusha Huang on 12/27/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

/**
 * This view make sure the available part (black) can be draw on the view
 */
#import "OOBufferView.h"
#import "OOUIUtils.h"

@interface OOBufferView()
@property (nonatomic, readonly) OOUIProgressSliderIOS7 *slider;
@end


@implementation OOBufferView

- (instancetype)initWithFrame:(CGRect)frame {
  [NSException raise:@"Not implemented" format:@"Use initWithFrame:slider: instead"];
  return nil;
}

- (instancetype)initWithFrame:(CGRect)frame slider:(OOUIProgressSliderIOS7*)slider {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    _slider = slider;
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  if(!self.slider.liveIndicator.hidden) {
    [self.slider drawLiveIndicator];
  }
  if(!self.slider.scrubber.hidden) {
    [self drawBufferedInRect:rect];
  }
}

-(void) drawBufferedInRect:(CGRect)rect {
  UISlider *slider = self.slider.scrubber;
  CGRect bound = slider.bounds;
  CGRect trackRect = [slider trackRectForBounds:bound];
  CGRect thumbPosition = [slider thumbRectForBounds:bound trackRect:trackRect value:slider.value];
  [OOUIUtils doSafeGStateBlock:^(CGContextRef cref) {
    CGContextSetRGBFillColor(cref, 0, 0, 0, 1);
    CGFloat radius = rect.size.height / 2;
    CGFloat minx = CGRectGetMinX(rect) + thumbPosition.origin.x + thumbPosition.size.width - 1,
    midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);

    CGMutablePathRef path = CGPathCreateMutable();
    CGContextMoveToPoint(cref, minx, midy);
    CGPathMoveToPoint(path, NULL, minx, midy);
    CGPathAddArcToPoint(path, NULL, minx, miny, midx, miny, radius);
    CGPathAddArcToPoint(path, NULL, maxx, miny, maxx, midy, radius);
    CGPathAddArcToPoint(path, NULL, maxx, maxy, midx, maxy, radius);
    CGPathAddArcToPoint(path, NULL, minx, maxy, minx, midy, radius);
    CGPathCloseSubpath(path);

    CGRect bounds = rect;
    bounds.size.width *= (self.slider.duration ? self.slider.currentAvailableTime / self.slider.duration : 0);
    CGContextClipToRect(cref, bounds);
    CGContextAddPath(cref, path);
    CGContextFillPath(cref);
    CGPathRelease(path);
  }];
}

@end
