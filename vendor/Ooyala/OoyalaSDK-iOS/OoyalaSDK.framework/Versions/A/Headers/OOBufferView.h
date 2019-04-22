/**
 * @class OOBufferView OOBufferView.h "OOBufferView.h"
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "OOProgressSliderView.h"

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
 @param frame the CGFrame to render the View in
 @param slider the existing UIProgressSlider render with
 @return an initialized OOBufferView, or nil
 */
- (instancetype)initWithFrame:(CGRect)frame slider:(OOProgressSliderView *)slider;

@end
