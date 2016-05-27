//
//  VideoItemCell.h
//  PulsePlayer
//
//  Created by Jacques du Toit on 13/10/15.
//  Copyright © 2015 Ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoItem.h"

@interface VideoItemCell : UITableViewCell

- (void)setVideoItem:(VideoItem *)videoItem;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end
