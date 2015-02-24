//
//  ChannelBrowserListViewController.m
//  ChannelBrowserSampleApp
//
//  Created by Zhihui Chen on 2/18/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

#import "ChannelBrowserListViewController.h"
#import "ChannelBrowserViewController.h"
#import "PlayerSelectionOption.h"

@interface ChannelBrowserListViewController ()

@property NSArray *channelList;

@end

@implementation ChannelBrowserListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];

  if (_channelList == nil) {
    PlayerSelectionOption *option =
      [[PlayerSelectionOption alloc] initWithTitle:@"Sample Channel" embedCode:@"txaGRiMzqQZSmFpMML92QczdIYUrcYVe" viewController:[ChannelBrowserViewController class]];
    _channelList = [NSArray arrayWithObjects:option, nil];
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.channelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];

  PlayerSelectionOption *selection = self.channelList[indexPath.row];
  cell.textLabel.text = [selection title];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // When a row is selected, load its desired PlayerViewController
  PlayerSelectionOption *selection = self.channelList[indexPath.row];
  ChannelBrowserViewController *controller = (ChannelBrowserViewController *)[[selection viewController] new];
  controller.option = selection;
  [self.navigationController pushViewController:controller animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */


@end
