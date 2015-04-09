/**
 * @class      NielsenPlaybackListViewcontroller NielsenPlaybackListViewcontroller.m
 "NielsenPlaybackListViewcontroller.m"
 * @brief      A list of playback examples that demonstrate Nielsen analytics playback
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "NielsenPlaybackListViewcontroller.h"
#import "NielsenPlayerViewController.h"
#import "PlayerSelectionOption.h"

@interface NielsenPlaybackListViewcontroller ()
@property NSMutableArray *options;
@end

@implementation NielsenPlaybackListViewcontroller

- (id)init {
  self = [super init];
  self.title = @"IMA Playback";
  return self;
}
- (void)addAllPlayerSelectionOptions {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"ID3-Demo" embedCode:@"84aDVmcTqN3FrdLXClZgJq-GfFEDhS1a" viewController: [NielsenPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"CMS-Demo" embedCode:@"ZhMmkycjr4jlHIjvpIIimQSf_CjaQs48" viewController: [NielsenPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"CMS-WithAds" embedCode:@"x3YjJzczqREV-5RDiemsrdqki1FYu2NT" viewController: [NielsenPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"CMS-14min" embedCode:@"JyanIxdDoj9MhKbVEmTJEG8O4QF5xExb" viewController: [NielsenPlayerViewController class]]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]forCellReuseIdentifier:@"TableCell"];

  [self addAllPlayerSelectionOptions];
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
  SampleAppPlayerViewController *controller = [(SampleAppPlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
