#import <UIKit/UIKit.h>

@class OOOoyalaPlayerViewController;

/**
 * A UI selector that can be used to select closed captions language
 * \detail This is part of the Old UI functionality
 * \ingroup captions
 */
@interface OOClosedCaptionsSelectorViewController : UITableViewController

- (instancetype)initWithViewController:(OOOoyalaPlayerViewController *)controller;

- (void)dismiss;

@end
