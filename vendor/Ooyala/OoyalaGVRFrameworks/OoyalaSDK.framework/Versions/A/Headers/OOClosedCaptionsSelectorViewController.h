#import <UIKit/UIKit.h>

@class OOOoyalaPlayerViewController;

/**
 * A UI selector that can be used to select closed captions language
 * \detail This is part of the Old UI functionality
 * \ingroup captions
 */
@interface OOClosedCaptionsSelectorViewController : UITableViewController

- (id)initWithViewController:(OOOoyalaPlayerViewController *)c;

  /**
   * Sets the popover that launched this viewcontroller
   */
- (void)setPopover:(UIPopoverController *)pop;
-(void) dismiss;

@end
