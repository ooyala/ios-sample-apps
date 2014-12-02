//
//  iOS7ScrubberSliderFraming.h
//  OoyalaSDK
//
//  Created by Jon Slenk on 11/7/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface iOS7ScrubberSliderFraming : NSObject
+(CGRect)calculateScrubberSliderFramewithButtons:(NSArray *)buttonArray
                                           baseWidth:(CGFloat)baseWidth;
@end
