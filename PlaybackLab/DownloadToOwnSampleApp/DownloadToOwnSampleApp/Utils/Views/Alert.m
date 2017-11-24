//
//  Alert.m
//  DownloadToOwnSampleApp
//
//  Created on 11/23/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

#import "Alert.h"

@implementation Alert

+(void)showAlertInWindow:(UIWindow *)window title:(NSString *)title andMessage:(NSString *)message {
  UIAlertController* alert = [UIAlertController
                              alertControllerWithTitle:title
                              message:message
                              preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction* defaultAction = [UIAlertAction
                                  actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action) {}];

  [alert addAction:defaultAction];
  [[window rootViewController] presentViewController:alert animated: true completion: nil];
}
@end
