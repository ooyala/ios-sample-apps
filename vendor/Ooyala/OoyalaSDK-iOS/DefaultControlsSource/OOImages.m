/**
 * @file       OOImages.m
 * @brief      Implementation of OOImages
 * @details    OOImages.m in OoyalaSDK
 * @date       1/12/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import "OOImages.h"
#import "OOUIUtils.h"

void strokePath(CGPoint *points, int count);
void fillPath(CGPoint *points, int count);

@implementation OOImages

+ (UIImage *)playImage:(CGSize)size {
  UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
  CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0 );
  CGContextSetLineWidth(context, 1.0);
  
  CGPoint p[] = {
    CGPointMake(.05, 0),
    CGPointMake(.95 * size.width, .5 * size.height),
    CGPointMake(.05, size.height)
  };
  fillPath(p, 3);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)pauseImage:(CGSize)size {
  UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
  CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0 );
  CGContextSetLineWidth(context, .25 * size.width);
  
  CGPoint l1[] = {
    CGPointMake(.25 * size.width, 0),
    CGPointMake(.25 * size.width, size.height),
  };
  strokePath(l1, 2);
  
  CGPoint l2[] = {
    CGPointMake(.75 * size.width, 0),
    CGPointMake(.75 * size.width, size.height),
  };
  strokePath(l2, 2);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}
+ (UIImage *)maximizeImage:(CGSize)size {
  UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
  CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0 );
  CGContextSetLineWidth(context, .1 * size.width);
  CGContextSetLineCap(context, kCGLineCapSquare);
  
  CGPoint t1[] = {
    CGPointMake(.1 * size.width, .1 * size.height),
    CGPointMake(.5 * size.width, .1 * size.height),
    CGPointMake(.1 * size.width, .5 * size.height),
  };
  fillPath(t1, 3);
  
  CGPoint l1[] = {
    CGPointMake(.1 * size.width, .1 * size.height),
    CGPointMake(.45 * size.width, .45 * size.height),
  };
  strokePath(l1, 2);
  
  CGPoint t2[] = {
    CGPointMake(.9 * size.width, .9 * size.height),
    CGPointMake(.9 * size.width, .5 * size.height),
    CGPointMake(.5 * size.width, .9 * size.height),
  };
  fillPath(t2, 3);
  
  CGPoint l2[] = {
    CGPointMake(.9 * size.width, .9 * size.height),
    CGPointMake(.55 * size.width, .55 * size.height),
  };
  strokePath(l2, 2);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)nextImage:(CGSize)size {
  UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
  CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0 );
  CGContextSetLineWidth(context, 1.0);
  
  CGPoint t1[] = {
    CGPointMake(0, .15 * size.height),
    CGPointMake(.4125 * size.width, .5 * size.height),
    CGPointMake(0, .85 * size.height),
  };
  fillPath(t1, 3);
  
  CGPoint t2[] = {
    CGPointMake(.4375 * size.width, .15 * size.height),
    CGPointMake(.85 * size.width, .5 * size.height),
    CGPointMake(.4375 * size.width, .85 * size.height),
  };
  fillPath(t2, 3);
  
  CGContextSetLineWidth(context, .125 * size.width);
  CGPoint l1[] = {
    CGPointMake(.9375 * size.width, .15 * size.height),
    CGPointMake(.9375 * size.width, .85 * size.height),
  };
  strokePath(l1, 2);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}
+ (UIImage *)previousImage:(CGSize)size {
  UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
  CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0 );
  CGContextSetLineWidth(context, 1.0);
  
  CGPoint t1[] = {
    CGPointMake(size.width, .15 * size.height),
    CGPointMake(.5375 * size.width, .5 * size.height),
    CGPointMake(size.width, .85 * size.height),
  };
  fillPath(t1, 3);
  
  CGPoint t2[] = {
    CGPointMake(.5625 * size.width, .15 * size.height),
    CGPointMake(.15 * size.width, .5 * size.height),
    CGPointMake(.5625 * size.width, .85 * size.height),
  };
  fillPath(t2, 3);
  
  CGContextSetLineWidth(context, .125 * size.width);
  CGPoint l1[] = {
    CGPointMake(.0625 * size.width, .15 * size.height),
    CGPointMake(.0625 * size.width, .85 * size.height),
  };
  strokePath(l1, 2);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *) closedCaptionsImage {
  return [OOUIUtils imageFromBase64String:@"iVBORw0KGgoAAAANSUhEUgAAAGEAAABVCAMAAABuM3oqAAAEJGlDQ1BJQ0MgUHJvZmlsZQAAOBGFVd9v21QUPolvUqQWPyBYR4eKxa9VU1u5GxqtxgZJk6XtShal6dgqJOQ6N4mpGwfb6baqT3uBNwb8AUDZAw9IPCENBmJ72fbAtElThyqqSUh76MQPISbtBVXhu3ZiJ1PEXPX6yznfOec7517bRD1fabWaGVWIlquunc8klZOnFpSeTYrSs9RLA9Sr6U4tkcvNEi7BFffO6+EdigjL7ZHu/k72I796i9zRiSJPwG4VHX0Z+AxRzNRrtksUvwf7+Gm3BtzzHPDTNgQCqwKXfZwSeNHHJz1OIT8JjtAq6xWtCLwGPLzYZi+3YV8DGMiT4VVuG7oiZpGzrZJhcs/hL49xtzH/Dy6bdfTsXYNY+5yluWO4D4neK/ZUvok/17X0HPBLsF+vuUlhfwX4j/rSfAJ4H1H0qZJ9dN7nR19frRTeBt4Fe9FwpwtN+2p1MXscGLHR9SXrmMgjONd1ZxKzpBeA71b4tNhj6JGoyFNp4GHgwUp9qplfmnFW5oTdy7NamcwCI49kv6fN5IAHgD+0rbyoBc3SOjczohbyS1drbq6pQdqumllRC/0ymTtej8gpbbuVwpQfyw66dqEZyxZKxtHpJn+tZnpnEdrYBbueF9qQn93S7HQGGHnYP7w6L+YGHNtd1FJitqPAR+hERCNOFi1i1alKO6RQnjKUxL1GNjwlMsiEhcPLYTEiT9ISbN15OY/jx4SMshe9LaJRpTvHr3C/ybFYP1PZAfwfYrPsMBtnE6SwN9ib7AhLwTrBDgUKcm06FSrTfSj187xPdVQWOk5Q8vxAfSiIUc7Z7xr6zY/+hpqwSyv0I0/QMTRb7RMgBxNodTfSPqdraz/sDjzKBrv4zu2+a2t0/HHzjd2Lbcc2sG7GtsL42K+xLfxtUgI7YHqKlqHK8HbCCXgjHT1cAdMlDetv4FnQ2lLasaOl6vmB0CMmwT/IPszSueHQqv6i/qluqF+oF9TfO2qEGTumJH0qfSv9KH0nfS/9TIp0Wboi/SRdlb6RLgU5u++9nyXYe69fYRPdil1o1WufNSdTTsp75BfllPy8/LI8G7AUuV8ek6fkvfDsCfbNDP0dvRh0CrNqTbV7LfEEGDQPJQadBtfGVMWEq3QWWdufk6ZSNsjG2PQjp3ZcnOWWing6noonSInvi0/Ex+IzAreevPhe+CawpgP1/pMTMDo64G0sTCXIM+KdOnFWRfQKdJvQzV1+Bt8OokmrdtY2yhVX2a+qrykJfMq4Ml3VR4cVzTQVz+UoNne4vcKLoyS+gyKO6EHe+75Fdt0Mbe5bRIf/wjvrVmhbqBN97RD1vxrahvBOfOYzoosH9bq94uejSOQGkVM6sN/7HelL4t10t9F4gPdVzydEOx83Gv+uNxo7XyL/FtFl8z9ZAHF4bBsrEwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAqlQTFRF/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////P38/////////////////////////////P38/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////v7+/////////////////////v7+/////////////////////////////////////////////////////////////////////////////////////////////////////v7+////////////////////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"];
}
@end


void strokePath(CGPoint *points, int count) {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextBeginPath(context);
  CGContextAddLines(context, points, count);
  CGContextClosePath(context);
  CGContextDrawPath(context, kCGPathStroke);
}

void fillPath(CGPoint *points, int count) {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextBeginPath(context);
  CGContextAddLines(context, points, count);
  CGContextClosePath(context);
  CGContextDrawPath(context, kCGPathFill);
}
