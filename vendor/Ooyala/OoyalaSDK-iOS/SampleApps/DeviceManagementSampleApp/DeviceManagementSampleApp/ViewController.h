//
//  ViewController.h
//  DeviceManagementSampleApp
//
//  Created by Shuo Wang on 7/31/13.
//
//

#import <UIKit/UIKit.h>
#import "OOEmbedTokenGenerator.h"

@class OOOoyalaPlayerViewController;

@interface ViewController : UIViewController <OOEmbedTokenGenerator>

@property (nonatomic, strong) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

- (void)notificationReceived:(NSNotification*)notification;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
