//
//  Alert.h
//  DownloadToOwnSampleApp
//
//  Created on 11/23/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Alert : NSObject

/**
 Show a simple alert on the given window.

 @param window the window to show the alert on.
 @param title for the alert.
 @param message for the alert.
 */
+(void)showAlertInWindow:(UIWindow *)window title:(NSString *)title andMessage:(NSString *)message;

@end
