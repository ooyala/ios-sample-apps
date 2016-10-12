/**
 * @class OOBufferView OOBufferView.h "OOBufferView.h"
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "OOUIProgressSliderIOS7.h"

/**
 A wrappper of the Progress Slider that allows a view for the buffering duration to appear
 */
@interface OOBufferView : UIView
/**
 Initialize with a frame.  This method is not available.  Use initWithFrame:slider: instead
 */
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("Use initWithFrame:slider: instead")));

/**
 Initialize the Buffer View with an existing Progress Slider
 @param[in] frame the CGFrame to render the View in
 @param[in] slider the existing UIProgressSlider render with
 @returns an initialized OOBufferView, or nil
 */
- (instancetype)initWithFrame:(CGRect)frame slider:(OOUIProgressSliderIOS7*)slider;
@end
