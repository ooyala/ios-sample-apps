//
//  ListTableViewController.h
//  ChromecastSampleApp
//
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

@import UIKit;

#import <OoyalaCastSDK/OOCastManager.h>
#import <OoyalaCastSDK/OOCastMiniControllerView.h>

extern NSString *segueName;

@interface ListTableViewController : UITableViewController <OOCastManagerDelegate>

@property (nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (nonatomic) OOCastManager *castManager;
@property (nonatomic) NSIndexPath *lastSelected;

@end

