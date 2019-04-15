//
//  TableViewEmbedCell.h
//  DiscoverySampleApp
//
//  Created on 15/04/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@interface TableViewEmbedCell : UITableViewCell

@property (nonatomic) IBOutlet UIImageView *thumbnail;
@property (nonatomic) IBOutlet NSString *title;
@property (nonatomic) IBOutlet NSString *duration;
@property (nonatomic) IBOutlet NSString *embedcode;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
