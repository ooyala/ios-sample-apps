//
//  OptionTableViewCell.h
//  DownloadToOwnSampleApp
//
//  Created on 8/23/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetPersistenceManager.h"

FOUNDATION_EXPORT NSString *const OptionCellReusableIdentifier;

@class PlayerSelectionOption;
@class OptionTableViewCell;

@protocol OptionTableViewCellDelegate <NSObject>

- (void)optionCell:(OptionTableViewCell *)cell downloadStateDidChange:(NSNumber *)state;

@end

@interface OptionTableViewCell : UITableViewCell

@property (nonatomic) PlayerSelectionOption *option;
@property (nonatomic, weak) id<OptionTableViewCellDelegate> delegate;

@end
