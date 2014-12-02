/**
 * @class      OOFullScreenViewController OOFullScreenViewController.h "OOFullScreenViewController.h"
 * @brief      OOFullScreenViewController
 * @details    OOFullScreenViewController.h in OoyalaSDK
 * @date       1/12/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "OOControlsViewController.h"

@interface OOFullScreenViewController : OOControlsViewController

@end

@protocol OOFullScreenControllerDelegate <NSObject>

- (void)fullScreenViewControllerWillResign:(OOFullScreenViewController*)controller;

@end
