//
//  CoreSDKOnlyListViewController.h
//  ChromecastSampleApp
//
//  Created on 9/18/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

@import UIKit;

#import <OoyalaCastSDK/OOCastManager.h>
#import <OoyalaCastSDK/OOCastMiniControllerView.h>

@interface CoreSDKOnlyListViewController : UITableViewController <OOCastManagerDelegate, OOCastMiniControllerDelegate>

@end
