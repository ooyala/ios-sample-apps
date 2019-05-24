//
//  ContentProtectionListViewController.m
//  ContentProtectionSampleApp
//
//  Created on 2/23/15.
//  Copyright © 2015 Ooyala Inc. All rights reserved.
//

#import "ContentProtectionListViewController.h"
#import "PlayerSelectionOption.h"
#import "OptionsDataSource.h"
#import "SampleAppPlayerViewController.h"

@interface ContentProtectionListViewController ()

@property NSArray *options;
@property NSMutableArray *optionList;
@property NSMutableArray *optionEmbedCodes;

@end

@implementation ContentProtectionListViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Content Protection Sample App";
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]
       forCellReuseIdentifier:@"TableCell"];

  _options = OptionsDataSource.options;
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
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell"
                                                          forIndexPath:indexPath];

  PlayerSelectionOption *selection = self.options[indexPath.row];
  cell.textLabel.text = selection.title;
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  PlayerSelectionOption *selection = self.options[indexPath.row];
  SampleAppPlayerViewController *controller = [(SampleAppPlayerViewController *)[selection.viewController alloc] initWithPlayerSelectionOption:selection];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
