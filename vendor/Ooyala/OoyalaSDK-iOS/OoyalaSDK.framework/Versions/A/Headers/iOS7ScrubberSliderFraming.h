/**
 * @class iOS7ScrubberSliderFraming iOS7ScrubberSliderFraming.h "iOS7ScrubberSliderFraming.h"
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * A class which helps measure the correct size for the scrubber, after all buttons have been measured
 */
@interface iOS7ScrubberSliderFraming : NSObject

/**
 Measure the Scrubber Slider with buttons
 @param[in] buttonArray the array of buttons used in the scrubber
 @param[in] baseWidth the width of the scrubber to use for caluclations
 @returns the frame where you can plase the scrubber
 */
+(CGRect)calculateScrubberSliderFramewithButtons:(NSArray *)buttonArray
                                           baseWidth:(CGFloat)baseWidth;
@end
