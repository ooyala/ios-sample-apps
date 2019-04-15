//
//  TableViewEmbedCell.m
//  DiscoverySampleApp
//
//  Created on 15/04/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import "TableViewEmbedCell.h"

@implementation TableViewEmbedCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
  NSLog(@"nib awake");
  self.titleLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:14.0];
  self.titleLabel.textColor = UIColor.whiteColor;
  self.titleLabel.numberOfLines = 2;
  self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

@end
