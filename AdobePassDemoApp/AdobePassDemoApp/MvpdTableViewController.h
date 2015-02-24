//
//  MvpdListViewController.h
//  AdobePassDemoApp
//
//  Created by Chris Leonavicius on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdobePassUiDelegate.h"

@interface MvpdTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
- (id)initWithMvpds:(NSArray *)mvpds delegate:(id<AdobePassUiDelegate>)delegate;
@end
