/**
 * @file       OOVolumeView.m
 * @brief      Implementation of OOVolumeView
 * @details    OOVolumeView.m in OoyalaSDK
 * @date       1/9/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import "OOVolumeView.h"
#import <QuartzCore/QuartzCore.h>

@interface TransparentToolbar : UIToolbar

@end

@implementation TransparentToolbar

- (id)init {
  self = [super init];
  self.backgroundColor = [UIColor clearColor];
  self.opaque = NO;
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  self.backgroundColor = [UIColor clearColor];
  self.opaque = NO;
  return self;
}

- (void)drawRect:(CGRect)rect {
  //empty method implementation
}

@end


@implementation OOVolumeView

@synthesize toolbar, volumeSlider;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    
    //init toolbar
    self.toolbar = [[TransparentToolbar alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 5, self.frame.size.width, self.frame.size.height / 5)];
    self.toolbar.barStyle = UIBarStyleBlack;
    self.toolbar.translucent = YES;
    [self addSubview:toolbar];

    self.volumeSlider = [[MPVolumeView alloc] initWithFrame:CGRectMake(20, 3 * self.bounds.size.height / 5, self.bounds.size.width - 40, 2 * self.bounds.size.height / 5)];
    [self addSubview:volumeSlider];
  }
  
  return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // Drawing code

  if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  // Drawing with a white stroke color
  CGContextSetRGBStrokeColor(context, .7, 0.7, 0.7, 0.5);
  // And draw with a blue fill color
  CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.0 );
  // Draw them with a 2.0 stroke width so they are a bit more visible.
  CGContextSetLineWidth(context, 1.0);

  CGFloat radius = 10.0;
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

  CGContextAddPath(context, path);

  CGContextClip(context);

  CGGradientRef gradient;
  CGColorSpaceRef colorspace;
  size_t num_locations = 2;
  CGFloat locations[2] = { 0.0, 1.0 };
  CGFloat components[8] = { 0.5, 0.5, 0.5, .6,  // Start color
                            0.0, 0.0, 0.0, .6 }; // End color
  colorspace = CGColorSpaceCreateDeviceRGB();
  gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
  CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, self.frame.size.height), 0);

  CGContextAddPath(context, path);
  CGContextDrawPath(context, kCGPathFillStroke);

  CFRelease(colorspace);
  CFRelease(gradient);
  CFRelease(path);
  }
}

@end
