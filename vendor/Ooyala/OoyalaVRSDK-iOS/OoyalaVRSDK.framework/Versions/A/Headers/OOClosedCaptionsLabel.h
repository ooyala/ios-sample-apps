
#import <UIKit/UIKit.h>
/**
 * A text label which may have the uniform edge style
 * \ingroup captions
 */
@interface OOClosedCaptionsLabel : UILabel

/**
 * Initialize the Closed Captions Label
 *
 */
- (id)initWithFrame:(CGRect)frame isUniformEdge:(BOOL)isUniformEdge;
@end
