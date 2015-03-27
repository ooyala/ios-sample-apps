/**
 * @class      IMAPlaybackListViewcontroller IMAPlaybackListViewcontroller.m
 "IMAPlaybackListViewcontroller.m"
 * @brief      A list of playback examples that demonstrate IMA Ad playback
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "FreewheelPlaybackListViewcontroller.h"
#import "FreewheelPlayerViewController.h"
#import "PlayerSelectionOption.h"

@interface FreewheelPlaybackListViewcontroller ()
@property NSMutableArray *options;
@end

@implementation FreewheelPlaybackListViewcontroller

- (id)init {
  self = [super init];
  self.title = @"IMA Playback";
  return self;
}
- (void)addAllPlayerSelectionOptions {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Freewheel Preroll" embedCode:@"Q5MXg2bzq0UAXXMjLIFWio_6U0Jcfk6v" viewController: [FreewheelPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Freewheel Midroll" embedCode:@"NwcGg4bzrwxc6rqAZbYij4pWivBsX57a" viewController: [FreewheelPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Freewheel Postroll" embedCode:@"NmcGg4bzqbeqXO_x9Rfj5IX6gwmRRrse" viewController: [FreewheelPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Freewheel PreMidPost" embedCode:@"NqcGg4bzoOmMiV35ZttQDtBX1oNQBnT-" viewController: [FreewheelPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Freewheel Overlay" embedCode:@"NucGg4bzrVrilZrMdlSA9tyg6Vty46DN" viewController: [FreewheelPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Freewheel PreMidPost Overlay" embedCode:@"NscGg4bzpO9s5rUMyW-AAfoeEA7CX6hP" viewController: [FreewheelPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Freewheel Multi Midroll" embedCode:@"htdnB3cDpMzXVL7fecaIWdv9rTd125As" viewController: [FreewheelPlayerViewController class]]];
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
