//
//  OOClosedCaptionsSelectorViewController.h
//  OoyalaSDK
//
//  Created by Michael Len on 2/6/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//
//  This class represents the view that lets users select a closed captions, or enabling subtitles.
//
//

#import <UIKit/UIKit.h>
#import "OOOoyalaPlayer.h"

@interface OOClosedCaptionsSelectorViewController : UITableViewController

- (id)initWithPlayer:(OOOoyalaPlayer *)p;

  /**
   * Sets the popover that launched this viewcontroller
   */
- (void)setPopover:(UIPopoverController *)pop;
-(void) dismiss;
@end
