/**
 * @class      BasicPlaybackListViewController BasicPlaybackListViewController.m "BasicPlaybackListViewController.m"
 * @brief      A list of playback examples that demonstrate basic playback
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "BasicPlaybackListViewController.h"
#import "BasicSimplePlayerViewController.h"
#import "SampleAppPlayerViewController.h"
#import "QRScannerViewController.h"

#import "PlayerSelectionOption.h"

@interface BasicPlaybackListViewController ()
@property NSMutableArray *options;
@property NSMutableArray *optionList;
@property NSMutableArray *optionEmbedCodes;
@end

@implementation BasicPlaybackListViewController

- (id)init {
  self = [super init];
  self.title = @"Basic Playback";
  return self;
}

- (void)addAllBasicPlayerSelectionOptions {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"HLS Video" embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"MP4 Video" embedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"VOD with CCs" embedCode:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"4:3 Aspect Ratio" embedCode:@"FwaXZjcjrkydIftLal2cq9ymQMuvjvD8" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"VAST Ad Pre-roll" embedCode:@"Zlcmp0ZDrpHlAFWFsOBsgEXFepeSXY4c" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"VAST Ad Mid-roll" embedCode:@"pncmp0ZDp7OKlwTPJlMZzrI59j8Imefa" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"VAST Ad Post-roll" embedCode:@"Zpcmp0ZDpaB-90xK8MIV9QF973r1ZdUf" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"VAST Ad Wrapper" embedCode:@"pqaWp0ZDqo17Z-Dn_5YiVhjcbQYs5lhq" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Ad Pre-roll" embedCode:@"M4cmp0ZDpYdy8kiL4UD910Rw_DWwaSnU" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Ad Mid-roll" embedCode:@"xhcmp0ZDpnDB2-hXvH7TsYVQKEk_89di" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Ad Post-roll" embedCode:@"Rjcmp0ZDr5yFbZPEfLZKUveR_2JzZjMO" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Multi Ad combination" embedCode:@"Ftcmp0ZDoz8tALmhPcN2vMzCdg7YU9lc" viewController: [BasicSimplePlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Scan Code" embedCode:@"" viewController: [BasicSimplePlayerViewController class]]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]forCellReuseIdentifier:@"TableCell"];

  [self addAllBasicPlayerSelectionOptions];
}

- (void)insertNewObject:(PlayerSelectionOption *)selectionObject {
  if (!self.options) {
    self.options = [[NSMutableArray alloc] init];
  }
  [self.options addObject:selectionObject];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // When a row is selected, load its desired PlayerViewController
  PlayerSelectionOption *selection = self.options[indexPath.row];
  SampleAppPlayerViewController *controller;
  if (selection.embedCode.length > 0) {
    controller = [(BasicSimplePlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection];
  } else {
    controller = [[QRScannerViewController alloc] initWithPlayerSelectionOption:selection];
  }
  [self.navigationController pushViewController:controller animated:YES];
}
@end
