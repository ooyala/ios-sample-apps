/**
 * @class iOS7ScrubberSliderFraming iOS7ScrubberSliderFraming.h "iOS7ScrubberSliderFraming.h"
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Version macros
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 * A class which helps measure the correct size for the scrubber, after all buttons have been measured
 */
@interface iOS7ScrubberSliderFraming : NSObject

/**
 Measure the Scrubber Slider with buttons
 @param[in] buttonArray the array of buttons used in the scrubber
 @param[in] baseWidth the width of the scrubber to use for caluclations
 @param[in] fullscreen indicates if we are currently in fullscreen mode
 @returns the frame where you can plase the scrubber
 */
+(CGRect)calculateScrubberSliderFramewithButtons:(NSArray *)buttonArray
                                       baseWidth:(CGFloat)baseWidth
                                      fullscreen:(BOOL)fullscreen;
@end
