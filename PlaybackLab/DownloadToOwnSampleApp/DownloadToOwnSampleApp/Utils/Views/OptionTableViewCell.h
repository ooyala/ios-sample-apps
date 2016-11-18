//
//  OptionTableViewCell.h
//  DownloadToOwnSampleApp
//
//  Created on 8/23/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//
//  The OptionTableViewCell will render each asset in a UITableView.
//  It is linked to an UITableView in the Storyboard.
//
//  It uses the PlayerSelectionOption to show components like the title of the asset and uses
//  the embed code to update itself if necessary.
//
//  It listens to notifications broadcasted by AssetPersistenceManager
//  (e.g. AssetPersistenceStateChangedNotification) and notifies its OptionTableViewCellDelegate
//  about changes of the downloaded state for the embed code that this cell is interested in.

#import <UIKit/UIKit.h>
#import "AssetPersistenceManager.h"

/**
 This is how we named the cell in the Storyboard, if you change then identifier in the storyboard you'll have to change the value of this NSString too.
 */
FOUNDATION_EXPORT NSString *const OptionCellReusableIdentifier;

@class PlayerSelectionOption;
@class OptionTableViewCell;

/**
 Notifies the delegate of this view about the download state of the asset (embed code) it manages.
 */
@protocol OptionTableViewCellDelegate <NSObject>


/**
 Notifies the delegate about the download state of a given cell's embed code.

 @param cell OptionTableViewCell that is calling this method.
 @param state of the download process.
 */
- (void)optionCell:(OptionTableViewCell *)cell downloadStateDidChange:(NSNumber *)state;

@end

@interface OptionTableViewCell : UITableViewCell


/**
 The option contains the info concerning this cell. The cell cares a lot about the embed code to know what to do when it gets the embed code through a notification, for example.
 */
@property (nonatomic) PlayerSelectionOption *option;

/**
 Calls the delegate when it needs to, to notify it about changes about the download process.
 */
@property (nonatomic, weak) id<OptionTableViewCellDelegate> delegate;

@end
