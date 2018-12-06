//
//  MvpdListViewController.h
//  AdobePassDemoApp
//
//  Created on 5/15/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdobePassUiDelegate.h"

@interface MvpdTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
- (id)initWithMvpds:(NSArray *)mvpds delegate:(id<AdobePassUiDelegate>)delegate;
@end
