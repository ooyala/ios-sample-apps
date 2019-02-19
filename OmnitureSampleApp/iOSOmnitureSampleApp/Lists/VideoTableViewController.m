//
//  VideoTableViewController.m
//  iOSOmnitureSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "VideoTableViewController.h"
#import "AssetDataSource.h"
#import "PlayerSelectionOption.h"
#import "BasicPlayerViewController.h"

@interface VideoTableViewController ()

@property (nonatomic) NSArray *assets; // of PlayerSelectionOption

@end

@implementation VideoTableViewController

- (NSArray *)assets {
  if (!_assets) {
    _assets = [AssetDataSource assets];
  }
  return _assets;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.assets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"assetCell"];
  
  cell.textLabel.text = ((PlayerSelectionOption *) self.assets[indexPath.row]).title;
  
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  BasicPlayerViewController *destinationVC = (BasicPlayerViewController *)segue.destinationViewController;
  NSIndexPath *selectedIndex = [self.tableView indexPathForSelectedRow];
  destinationVC.asset = self.assets[selectedIndex.row];
}

@end
