/**
 * @class      ChannelContentTreeTableViewCell ChannelContentTreeTableViewCell.h "ChannelContentTreeTableViewCell.h"
 * @brief      A view that displays information about a video in a channel
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface ChannelContentTreeTableViewCell : UITableViewCell

@property (nonatomic) IBOutlet UIImageView *thumbnail;
@property (nonatomic) IBOutlet UILabel *title;
@property (nonatomic) IBOutlet UILabel *duration;

@end
