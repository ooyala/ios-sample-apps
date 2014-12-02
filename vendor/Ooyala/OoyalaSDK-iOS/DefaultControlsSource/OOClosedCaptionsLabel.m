//
//  OOClosedCaptionsLabel.m
//  OoyalaSDK
//
//  Created by Liusha Huang on 2/18/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "OOClosedCaptionsLabel.h"

@interface OOClosedCaptionsLabel()
@property (nonatomic) bool isUniformEdge;
@end

@implementation OOClosedCaptionsLabel

- (id)initWithFrame:(CGRect)frame isUniformEdge:(BOOL)isUniformEdge
{
  self = [super initWithFrame:frame];
  if (self) {
    self.textAlignment = UITextAlignmentCenter;
    self.isUniformEdge = isUniformEdge;
    // Initialization code
  }
  return self;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) setText:(NSString *)text {
  [super setText:text];
  [self setNeedsDisplay];
}


- (void)drawTextInRect:(CGRect)rect {
  // Draw outline for roll-up presentation with uniform edge style
  if (self.isUniformEdge) {
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;

    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 2);
    CGContextSetLineJoin(c, kCGLineJoinRound);

    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = [UIColor blackColor];
    [super drawTextInRect:rect];

    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];

    self.shadowOffset = shadowOffset;
  }
  else {
    [super drawTextInRect:rect];
  }
}

@end
