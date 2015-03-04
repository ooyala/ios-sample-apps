//
//  ViewController.h
//  AdobePassDemoApp
//
//  Created by Chris Leonavicius on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleAppPlayerViewController.h"
@class AdobePassViewController;
@class OOOoyalaPlayerViewController;

@interface AdobePassPlayerViewController : SampleAppPlayerViewController

@property (nonatomic, strong) AdobePassViewController *passController;
@property (nonatomic, strong) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
- (void)setEmbedCode;
- (void)login;
- (void)logout;
@end
