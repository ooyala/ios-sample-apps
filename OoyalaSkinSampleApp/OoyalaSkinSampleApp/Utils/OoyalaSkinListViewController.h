/**
 * @class      BasicPlaybackListViewController BasicPlaybackListViewController.h "BasicPlaybackListViewController.h"
 * @brief      A list of playback examples that demonstrate basic playback
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "PlayerSelectionOption.h"

@interface OoyalaSkinListViewController : UITableViewController <UITableViewDelegate>

@property (nonatomic) NSArray *options;

- (void)addTestCases;

@end
