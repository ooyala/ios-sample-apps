//
//  MasterViewController.m
//  AdvancedPlaybackSampleApp
//
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "CompleteSampleAppListViewController.h"
#import "SimplePlayerViewController.h"
#import "BasicPlaybackListViewController.h"
#import "AdvancedPlaybackListViewController.h"
#import "OptionsListTableViewController.h"
#import "IMAPlaybackListViewcontroller.h"
#import "FreewheelPlaybackListViewcontroller.h"
#import "OoyalaAPIListViewController.h"
#import "PlayerSelectionOption.h"
#import "ContentProtectionListViewController.h"


#pragma mark - List Selection Option
/**
 * A list entry that represents a subsection of the complete sample app
 */
@interface ListSelectionOption : NSObject
@property NSString *title;
@property Class listViewController;
- (id)initWithTitle:(NSString *)title listViewController:(Class) viewController;
@end

@implementation ListSelectionOption
- (id)initWithTitle:(NSString *)title listViewController:(Class) listViewController {
  self = [super init];
  if (self) {
    self.title = title;
    self.listViewController = listViewController;
  }
  return self;
}

@end

#pragma mark - CompleteSampleAppListViewController

@interface CompleteSampleAppListViewController ()
@property NSMutableArray *options;
@end

@implementation CompleteSampleAppListViewController

/**
 * List all of your ListViews here here
 *
 */
- (void)addAllPlayerSelectionOptions {
  [self insertNewObject: [[ListSelectionOption alloc] initWithTitle:@"ContentProtectionSampleApp" listViewController: [ContentProtectionListViewController class]]];
  [self insertNewObject: [[ListSelectionOption alloc] initWithTitle:@"AdvancedPlaybackSampleApp" listViewController: [AdvancedPlaybackListViewController class]]];
  [self insertNewObject: [[ListSelectionOption alloc] initWithTitle:@"OptionsSampleApp" listViewController: [OptionsListTableViewController class]]];
  [self insertNewObject: [[ListSelectionOption alloc] initWithTitle:@"IMASampleApp" listViewController: [IMAPlaybackListViewcontroller class]]];
  [self insertNewObject: [[ListSelectionOption alloc] initWithTitle:@"FreewheelSampleApp" listViewController: [FreewheelPlaybackListViewcontroller class]]];
  [self insertNewObject: [[ListSelectionOption alloc] initWithTitle:@"BasicPlaybackSampleApp" listViewController: [BasicPlaybackListViewController class]]];
  [self insertNewObject: [[ListSelectionOption alloc] initWithTitle:@"OoyalaAPISampleApp" listViewController: [OoyalaAPIListViewController class]]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;

  [self addAllPlayerSelectionOptions];
}

- (void)insertNewObject:(ListSelectionOption *)selectionObject {
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
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

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
  ListSelectionOption *selection = self.options[indexPath.row];
  UITableViewController *controller = [(UITableViewController *)[[selection listViewController] alloc] init];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
