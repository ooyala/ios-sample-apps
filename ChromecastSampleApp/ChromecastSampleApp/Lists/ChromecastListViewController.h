//
//  ChromecastListViewController.h
//  ChromecastSampleApp
//
//  Created on 9/18/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OoyalaCastSDK/OOCastManager.h>
#import <OoyalaCastSDK/OOCastMiniControllerView.h>

@interface ChromecastListViewController : UITableViewController <OOCastManagerDelegate, OOCastMiniControllerDelegate>

@end
