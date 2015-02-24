//
//  ChannelBrowserViewController.h
//  ChannelBrowserSampleApp
//
//  Created by Zhihui Chen on 2/18/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerSelectionOption.h"

@interface ChannelBrowserViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) PlayerSelectionOption *option;

@end
