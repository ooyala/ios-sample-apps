//
//  MasterViewController.m
//  AdvancedPlaybackSampleApp
//
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "CompleteSampleAppListViewController.h"
#import "SimplePlayerViewController.h"
#import "BasicPlaybackListViewController.h"
#import "PlayerSelectionOption.h"

@interface CompleteSampleAppListViewController ()
@property NSMutableArray *options;
@end

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

@implementation CompleteSampleAppListViewController

- (void)addAllPlayerSelectionOptions {
  [self insertNewObject: [[ListSelectionOption alloc] initWithTitle:@"AdvancedPlaybackSampleApp" listViewController: [BasicPlaybackListViewController class]]];
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
