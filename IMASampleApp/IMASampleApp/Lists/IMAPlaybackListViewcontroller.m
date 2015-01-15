/**
 * @class      IMAPlaybackListViewcontroller IMAPlaybackListViewcontroller.m
 "IMAPlaybackListViewcontroller.m"
 * @brief      A list of playback examples that demonstrate IMA Ad playback
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "IMAPlaybackListViewcontroller.h"
#import "IMAPlayerViewController.h"
#import "PlayerSelectionOption.h"

@interface IMAPlaybackListViewcontroller ()
@property NSMutableArray *options;
@end

@implementation IMAPlaybackListViewcontroller

- (id)init {
  self = [super init];
  self.title = @"IMA Playback";
  return self;
}
- (void)addAllPlayerSelectionOptions {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ad-Rules Preroll" embedCode:@"EzZ29lcTq49IswgZYkMknnU4Ukb9PQMH" viewController: [IMAPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ad-Rules Midroll" embedCode:@"VlaG9lcTqeUU18adfd1DVeQ8YekP3H4l" viewController: [IMAPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ad-Rules Postroll" embedCode:@"BnaG9lcTqLXQNyod7ON8Yv3eDas2Oog6" viewController: [IMAPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Podded Preroll" embedCode:@"1wNjE3cDox0G3hQIWxTjsZ8MPUDLSkDY" viewController: [IMAPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Podded Midroll" embedCode:@"1yNjE3cDodUEfUfp2WNzHkCZCMb47MUP" viewController: [IMAPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Podded Postroll" embedCode:@"1sNjE3cDoN3ZewFm1238ce730J4BMrEJ" viewController: [IMAPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Podded Pre-Mid-Post" embedCode:@"ZrOTE3cDoXo2sLOWzQPxjS__M-Qk32Co" viewController: [IMAPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Skippable" embedCode:@"FhbGRjbzq8tfaoA3dhfxc2Qs0-RURJfO" viewController: [IMAPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Pre, Mid and Post Skippable" embedCode:@"10NjE3cDpj8nUzYiV1PnFsjC6nEvPQAE" viewController: [IMAPlayerViewController class]]];
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
