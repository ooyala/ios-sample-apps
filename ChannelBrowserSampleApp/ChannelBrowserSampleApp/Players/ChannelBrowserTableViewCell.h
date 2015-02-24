//
//  ChannelBrowserCellTableViewCell.h
//  ChannelBrowserSampleApp
//
//  Created by Zhihui Chen on 2/23/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelBrowserTableViewCell : UITableViewCell

@property (nonatomic) IBOutlet UIImageView *thumbnail;
@property (nonatomic) IBOutlet UILabel *title;
@property (nonatomic) IBOutlet UILabel *duration;

@end
