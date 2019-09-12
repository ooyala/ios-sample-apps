@import UIKit;

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

+ (void)setArbitararyScalingFactor:(CGFloat)scalingFactor;

@property (nonatomic) OOCaption *caption;

@property (nonatomic) OOClosedCaptionsStyle *style;

@end
