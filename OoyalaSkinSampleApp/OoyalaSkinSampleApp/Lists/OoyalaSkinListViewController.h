/**
 * @class      BasicPlaybackListViewController BasicPlaybackListViewController.h "BasicPlaybackListViewController.h"
 * @brief      A list of playback examples that demonstrate basic playback
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "PlayerSelectionOption.h"

@interface OoyalaSkinListViewController : UITableViewController <UITableViewDelegate>

- (void)addTestCases;
- (void)insertNewObject:(PlayerSelectionOption *)selectionObject;
- (void)addCommonWithTitle:(NSString*)title embedCode:(NSString*)embedCode;

@end
