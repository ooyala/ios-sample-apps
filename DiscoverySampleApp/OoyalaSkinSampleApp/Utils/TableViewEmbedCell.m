/**
 * @class      TableViewEmbedCell TableViewEmbedCell.m "TableViewEmbedCell.m"
 * @brief      A view that displays information about a video in a channel
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "TableViewEmbedCell.h"

@implementation TableViewEmbedCell

- (void)awakeFromNib {
  [super awakeFromNib];
    // Initialization code
    NSLog(@"nib awake");
    self.titleLabel.font=[UIFont fontWithName:@"Roboto-Bold" size:14.0 ];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
