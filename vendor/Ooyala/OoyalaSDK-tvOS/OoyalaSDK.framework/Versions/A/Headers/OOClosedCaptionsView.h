#import <UIKit/UIKit.h>

@class OOCaption;
@class OOClosedCaptionsStyle;

/**
 * A View which displasy caption text
 * \ingroup captions
 */
@interface OOClosedCaptionsView : UIView {
  OOCaption *caption;
  OOClosedCaptionsStyle *style;
}
+ (void) setArbitararyScalingFactor:(CGFloat)scalingFactor;

@property (nonatomic, strong) OOCaption *caption;

@property (nonatomic, strong) OOClosedCaptionsStyle *style;
@end
