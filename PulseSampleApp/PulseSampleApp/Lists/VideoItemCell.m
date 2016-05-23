//
//  VideoItemCell.m
//  PulsePlayer
//
//  Created by Jacques du Toit on 13/10/15.
//  Copyright © 2015 Ooyala. All rights reserved.
//

#import "VideoItemCell.h"

@implementation VideoItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setVideoItem:(VideoItem *)videoItem
{
  self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  self.titleLabel.text = videoItem.title ?: @"";
  
  NSString *subTitle = @"";
  if (videoItem.category) {
    subTitle = [NSString stringWithFormat:@"[%@] ", videoItem.category];
  }
  self.tagLabel.text = [NSString stringWithFormat:@"%@ %@", subTitle, [videoItem.tags componentsJoinedByString:@", "] ?: @""];
}

@end
