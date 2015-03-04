//
//  MvpdLoginViewController.h
//  AdobePassDemoApp
//
//  Created by Chris Leonavicius on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessEnabler.h"
#import "AdobePassUiDelegate.h"

@interface MvpdLoginViewController : UIViewController <UIWebViewDelegate>
- (id)initWithString:(NSString *)url delegate:(id<AdobePassUiDelegate>)delegate;
- (id)initWithUrl:(NSURL *)url delegate:(id<AdobePassUiDelegate>)delegate;
@end
