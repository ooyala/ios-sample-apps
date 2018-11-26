//
//  MasterListViewControllerTableViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "MasterListViewControllerTableViewController.h"
#import "LayoutListViewController.h"
#import "BasicTestsListViewController.h"
#import "FreewheelTestsListViewController.h"
#import "IMATestsListViewController.h"
#import "SetAssetListViewController.h"
#import "GeoblockingTableViewController.h"
#import "MultiAudioListViewController.h"
#import "SSAIListViewController.h"
#import "AudioOnlyListViewController.h"


@interface MasterListViewControllerTableViewController ()

@property (nonatomic) NSArray *playlists;

@end

@implementation MasterListViewControllerTableViewController

#pragma mark - UIViewController override

- (void)viewDidLoad {
  
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]forCellReuseIdentifier:@"TableCell"];
  self.playlists = @[@"Layouts",
                     @"Basic Playback",
                     @"Freewheel",
                     @"Google IMA",
                     @"Set asset",
                     @"Geoblocking",
                     @"Multi audio",
                     @"Ooyala SSAI",
                     @"Audio only"];
}

#pragma mark - UITableViewDataSource

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

#pragma mark - UITableViewDelegate

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
    case 4:
      controller = [SetAssetListViewController new];
      break;
    case 5:
      controller = [GeoblockingTableViewController new];
      break;
    case 6:
      controller = [MultiAudioListViewController new];
      break;
    case 7:
      controller = [SSAIListViewController new];
      break;
    case 8:
      controller = [AudioOnlyListViewController new];
      break;
    default:
      break;
  }
  [self.navigationController pushViewController:controller animated:YES];
}


@end
