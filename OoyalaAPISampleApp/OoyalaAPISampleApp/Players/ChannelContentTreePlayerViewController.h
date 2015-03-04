/**
 * @class      ChannelBrowserViewController ChannelBrowserViewController.h "ChannelBrowserViewController.h"
 * @brief      A view that displays the list of videos in a channel
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "PlayerSelectionOption.h"

@interface ChannelContentTreePlayerViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) PlayerSelectionOption *option;

@end
