//
//  iOS7ScrubberSliderFraming.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface iOS7ScrubberSliderFraming : NSObject
+(CGRect)calculateScrubberSliderFramewithButtons:(NSArray *)buttonArray
                                           baseWidth:(CGFloat)baseWidth;
@end
