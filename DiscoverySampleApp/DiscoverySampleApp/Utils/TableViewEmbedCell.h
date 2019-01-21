/**
 * @class      TableViewEmbedCell TableViewEmbedCell.h "TableViewEmbedCell.h"
 * @brief      A view that displays information about a video in a channel
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface TableViewEmbedCell : UITableViewCell

@property (nonatomic) IBOutlet UIImageView *thumbnail;
@property (nonatomic) IBOutlet NSString *title;
@property (nonatomic) IBOutlet NSString *duration;
@property (nonatomic) IBOutlet NSString *embedcode;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
