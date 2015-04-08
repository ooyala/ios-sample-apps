//
//  SelectorViewController.h
//  AnalyticsPluginSampleApp
//
//  Created by Zhihui Chen on 1/12/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectorViewController : UITableViewController<UITableViewDataSource, UITableViewDataSource>

@property (nonatomic) NSString *selectedEmbedCode;

@end
