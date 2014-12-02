//
//  iOS7ScrubberSliderFraming.m
//  OoyalaSDK
//
//  Created by Jon Slenk on 11/7/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import "iOS7ScrubberSliderFraming.h"
#import "OOUIUtils.h"
#import "OOImagesIOS7.h"

@implementation iOS7ScrubberSliderFraming

+(CGRect)calculateScrubberSliderFramewithButtons:(NSArray *)buttonArray
                                       baseWidth:(CGFloat)baseWidth {

  CGFloat buttonsOffset = 0;
  //Calculate size of each button (with margins)
  for (UIBarButtonItem *button in buttonArray) {
    UIView *buttonView = [button valueForKey:@"view"];
    buttonsOffset += buttonView ? [buttonView frame].size.width + 6 : (CGFloat)0.0;
  }

  //Add some extra space for sides
  buttonsOffset += 38;

  CGRect frame;
  if ([OOUIUtils isIpad]) {
    frame = CGRectMake(0, 0, baseWidth - buttonsOffset, 40);
  } else {
    frame = CGRectMake(0, 0, baseWidth - buttonsOffset, 40);
  }
  return frame;
}

@end
