//
//  MvpdListViewController.h
//  ContentProtectionSampleApp
//
//  Created on 5/15/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdobePassUiDelegate.h"

@interface MvpdTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithMvpds:(NSArray *)theMvpds
                     delegate:(id<AdobePassUiDelegate>)theDelegate;

@end
