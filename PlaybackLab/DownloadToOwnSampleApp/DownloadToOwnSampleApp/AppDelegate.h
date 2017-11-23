//
//  AppDelegate.h
//  DownloadToOwnSampleApp
//
//  Created on 8/8/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) NetworkStatus netStatus;

@end

