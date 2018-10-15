//
//  OptionTableViewCell.h
//  DownloadToOwnSampleApp
//
//  Created on 8/23/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//
//  The OptionTableViewCell will render each asset in a UITableView.
//  It is linked to an UITableView in the Storyboard.

#import <UIKit/UIKit.h>

/**
 This is how we named the cell in the Storyboard, if you change then identifier in the storyboard you'll have to change the value of this NSString too.
 */
FOUNDATION_EXPORT NSString *const OptionCellReusableIdentifier;

@interface OptionTableViewCell : UITableViewCell

/**
 Shows the title of the asset
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 Shows the download state of the asset
 */
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

/**
 Shows the percentage progress of an active download.
 */
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgressView;

@end
