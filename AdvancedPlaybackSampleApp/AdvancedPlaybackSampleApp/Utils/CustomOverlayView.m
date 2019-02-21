//
//  CustomOverlay.m
//  AdvancedPlaybackSampleApp
//
//

#import "CustomOverlayView.h"

/**
 * This is an example of creating an Overlay.
 *
 * Using this method may be "heavy" for many users.  You can simply insert views into the OOOoyalaPlayerLayout
 *   if that solves your use case
 */
@implementation CustomOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
  frame.size.height = 50;
  if (self = [super initWithFrame:frame]) {
    self.text = @"This is an overlay";
    self.backgroundColor = UIColor.redColor;
    self.editable = NO;
    self.selectable = NO;
  }
  return self;
}

@end
