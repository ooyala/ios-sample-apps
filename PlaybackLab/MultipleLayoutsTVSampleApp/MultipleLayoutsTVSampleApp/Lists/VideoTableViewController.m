//
//  VideoTableViewController.m
//  MultipleLayoutsTVSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "VideoTableViewController.h"
#import "AbstractPlayerViewController.h"
#import "FullscreenPlayerViewController.h"
#import "PlayerSelectionOption.h"

@interface VideoTableViewController ()

@end

@implementation VideoTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.assets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell" forIndexPath:indexPath];
  
  PlayerSelectionOption *asset = self.assets[indexPath.row];
  cell.textLabel.text = asset.title;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *segueId = @"";
  PlayerSelectionOption *asset = self.assets[indexPath.row];
  if ([asset.hostVC isSubclassOfClass:[FullscreenPlayerViewController class]]) {
    segueId = @"fullscreenSegue";
  } else if ([asset.hostVC isSubclassOfClass:[AbstractPlayerViewController class]]) {
    segueId = @"childSegue";
  }
  
  [self performSegueWithIdentifier:segueId sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
  UIViewController *destinationVC = segue.destinationViewController;
  if ([destinationVC isKindOfClass:[FullscreenPlayerViewController class]]) {
    ((FullscreenPlayerViewController *)destinationVC).option = self.assets[indexPath.row];
  } else if ([destinationVC isKindOfClass:[AbstractPlayerViewController class]]) {
    ((AbstractPlayerViewController *)destinationVC).option = self.assets[indexPath.row];
  }
}

@end
