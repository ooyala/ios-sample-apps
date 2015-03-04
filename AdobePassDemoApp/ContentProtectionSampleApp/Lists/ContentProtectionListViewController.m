//
//  ContentProtectionListViewController.m
//  ContentProtectionListViewController
//
//  Created by Liusha Huang on 2/23/15.
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "ContentProtectionListViewController.h"
#import "PlayerSelectionOption.h"
#import "AdobePassPlayerViewController.h"
#import "DeviceManagementPlayerViewController.h"
#import "SampleAppPlayerViewController.h"

@interface ContentProtectionListViewController ()
@property NSMutableArray *options;
@property NSMutableArray *optionList;
@property NSMutableArray *optionEmbedCodes;
@end

@implementation ContentProtectionListViewController

- (id)init {
  self = [super init];
  self.title = @"Content Protection Sample App";
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]forCellReuseIdentifier:@"TableCell"];

  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Adobe Pass" embedCode:@"VybW5lODrJ0uM9FBo7XTT6TNjTJfr_7G" viewController: [AdobePassPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Device Management (Unplayable)" embedCode:@"" viewController: [DeviceManagementPlayerViewController class]]];
}

- (void)insertNewObject:(PlayerSelectionOption *)selectionObject {
  if (!self.options) {
    self.options = [[NSMutableArray alloc] init];
  }
  [self.options insertObject:selectionObject atIndex:0];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];

  PlayerSelectionOption *selection = self.options[indexPath.row];
  cell.textLabel.text = [selection title];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  PlayerSelectionOption *selection = self.options[indexPath.row];
  SampleAppPlayerViewController *controller = [(SampleAppPlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection];
  [self.navigationController pushViewController:controller animated:YES];
}
@end
