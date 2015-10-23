//
//  OOCastMenuViewController.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 9/8/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOCastManager.h"
#import "OOCastMiniControllerProtocol.h"

@interface OOCastMenuViewController : UITableViewController<OOCastMiniControllerDelegate>

/**
 * Initiate and return a OOCastMenuViewController with given OOCastManager
 */
- (id)initWithCastManager:(OOCastManager *)castManager;

@end
