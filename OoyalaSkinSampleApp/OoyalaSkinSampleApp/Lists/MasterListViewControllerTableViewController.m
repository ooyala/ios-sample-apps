//
//  MasterListViewControllerTableViewController.m
//  OoyalaSkinSampleApp
//
//  Created by Zhihui Chen on 7/27/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "MasterListViewControllerTableViewController.h"
#import "LayoutListViewController.h"
#import "BasicTestsListViewController.h"
#import "FreewheelTestsListViewController.h"
#import "IMATestsListViewController.h"

@interface MasterListViewControllerTableViewController ()

@property NSArray *playlists;

@end

@implementation MasterListViewControllerTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]forCellReuseIdentifier:@"TableCell"];
  self.playlists = [NSArray arrayWithObjects:@"Layouts", @"Basic Playback", @"Freewheel", @"Google IMA", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.playlists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];

  cell.textLabel.text = [self.playlists objectAtIndex:indexPath.row];
  return cell;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // When a row is selected, load its desired PlayerViewController
  OoyalaSkinListViewController *controller;
  switch (indexPath.row) {
    case 0:
      controller = [LayoutListViewController new];
      break;
    case 1:
      controller = [BasicTestsListViewController new];
      break;
    case 2:
      controller = [FreewheelTestsListViewController new];
      break;
    case 3:
      controller = [IMATestsListViewController new];
      break;
    default:
      break;
  }
  [self.navigationController pushViewController:controller animated:YES];
}


@end
