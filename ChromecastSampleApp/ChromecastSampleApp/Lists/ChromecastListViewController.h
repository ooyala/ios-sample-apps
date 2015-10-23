//
//  ChromecastListViewController.h
//  ChromecastSampleApp
//
//  Created by Liusha Huang on 9/18/14.
//  Copyright (c) 2014 Liusha Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OoyalaCastSDK/OOCastManager.h>
#import <OoyalaCastSDK/OOCastMiniControllerProtocol.h>

@interface ChromecastListViewController : UITableViewController <OOCastManagerDelegate,OOCastMiniControllerDelegate>


@end

