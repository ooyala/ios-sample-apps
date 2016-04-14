//
//  MainTableViewController.m
//  MultipleLayoutsTVSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "MainTableViewController.h"
#import "VideoTableViewController.h"
#import "AssetDataSource.h"

@interface MainTableViewController ()

@property (nonatomic, strong) NSMutableArray *options;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self populateOptions];
}

- (NSMutableArray *)options {
  if (!_options) {
    _options = [NSMutableArray array];
  }
  return _options;
}

- (void)populateOptions {
  [self.options addObject:@"Encodings"];
  [self.options addObject:@"Layouts"];
  
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell" forIndexPath:indexPath];
  
  NSString *option = self.options[indexPath.row];
  cell.textLabel.text = option;
  
  return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  VideoTableViewController *destinationVC = nil;
  if ([segue.destinationViewController isKindOfClass:[VideoTableViewController class]]) {
    destinationVC = (VideoTableViewController *) segue.destinationViewController;
  }
  
  // Send asset info
  switch ([self.tableView indexPathForSelectedRow].row) {
    case 0:
      destinationVC.assets = [AssetDataSource assets:AssetDataSourceTypeEncoding];
      break;
    case 1:
      destinationVC.assets = [AssetDataSource assets:AssetDataSourceTypeLayout];
      break;
    default:
      break;
  }
}

@end
