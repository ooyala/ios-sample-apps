/**
 * @class ScrubberSliderFraming ScrubberSliderFraming.h "ScrubberSliderFraming.h"
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef ScrubberSliderFraming_h
#define ScrubberSliderFraming_h

/**
 * A class which helps measure the correct size for the scrubber, after all buttons have been measured
 */
@interface ScrubberSliderFraming : NSObject

/**
 Measure the Scrubber Slider with buttons
 @param buttonArray the array of buttons used in the scrubber
 @param baseWidth the width of the scrubber to use for caluclations
 @return the frame where you can plase the scrubber
 */
+ (CGRect)calculateScrubberSliderFrameWithButtons:(NSArray *)buttonArray
                                        baseWidth:(CGFloat)baseWidth;
@end

#endif /* ScrubberSliderFraming_h */
