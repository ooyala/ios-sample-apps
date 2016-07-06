/**
 * @class      OOClosedCaptionsSelectorViewController OOClosedCaptionsSelectorViewController.h "OOClosedCaptionsSelectorViewController.h"
 * @brief      OOClosedCaptionsSelectorViewController
 * @details    OOClosedCaptionsSelectorViewController.h in OoyalaSDK
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>

@class OOOoyalaPlayerViewController;

@interface OOClosedCaptionsSelectorViewController : UITableViewController

- (id)initWithViewController:(OOOoyalaPlayerViewController *)c;

  /**
   * Sets the popover that launched this viewcontroller
   */
- (void)setPopover:(UIPopoverController *)pop;
-(void) dismiss;

@end
