//
//  MvpdLoginViewController.h
//  ContentProtectionSampleApp
//
//  Created on 5/15/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessEnabler.h"
#import "AdobePassUiDelegate.h"

@interface MvpdLoginViewController : UIViewController <UIWebViewDelegate>

- (instancetype)initWithString:(NSString *)url delegate:(id<AdobePassUiDelegate>)theDelegate;
- (instancetype)initWithUrl:(NSURL *)url delegate:(id<AdobePassUiDelegate>)theDelegate;

@end
