//
//  MasterListViewControllerTableViewController.m
//  PictureInPictureSampleApp
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "MasterListViewControllerTableViewController.h"
#import "LayoutListViewController.h"
#import "BasicTestsListViewController.h"
#import "BasicPlaybackListViewController.h"
#import "FreewheelTestsListViewController.h"
#import "IMATestsListViewController.h"

@interface MasterListViewControllerTableViewController ()

@property NSArray *playlists;

@end

@implementation MasterListViewControllerTableViewController

#pragma mark - View Controller Lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]
       forCellReuseIdentifier:@"TableCell"];
  self.playlists = @[/*@"Layouts",*/ @"Basic Skin Playback", @"Basic Playback"/*, @"Freewheel", @"Google IMA"*/];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playlists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
  cell.textLabel.text = self.playlists[indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // When a row is selected, load its desired PlayerViewController
  UIViewController *controller;
  switch (indexPath.row) {
    case 0:
      controller = [BasicTestsListViewController new];
      break;
    case 1:
      controller = [BasicPlaybackListViewController new];
      break;
//    case 2:
//      controller = [FreewheelTestsListViewController new];
//      break;
//    case 3:
//      controller = [IMATestsListViewController new];
//      break;
    default:
      break;
  }
  [self.navigationController pushViewController:controller animated:YES];
}


@end
