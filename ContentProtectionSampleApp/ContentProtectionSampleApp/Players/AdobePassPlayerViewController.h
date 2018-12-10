//
//  ViewController.h
//  AdobePassDemoApp
//
//  Created on 5/15/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleAppPlayerViewController.h"

@class AdobePassViewController;
@class OOOoyalaPlayerViewController;

@interface AdobePassPlayerViewController : SampleAppPlayerViewController

@property (nonatomic) AdobePassViewController *passController;
@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

- (void)login;
- (void)logout;

@end
