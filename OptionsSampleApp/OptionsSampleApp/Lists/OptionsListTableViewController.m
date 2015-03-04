//
//  OptionsListTableViewController.m
//  OptionsSampleApp
//
//  Created by Zhihui Chen on 12/18/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "OptionsListTableViewController.h"
#import "TVRatingsPlayerViewController.h"
#import "OptionsViewController.h"
#import "PlayerSelectionOption.h"

@interface OptionsListTableViewController ()
@property NSMutableArray *options;
@end

@implementation OptionsListTableViewController

static NSString *cellId = @"pickerCell";

- (id)init {
  self = [super init];
  self.title = @"Options Configuration";
  return self;
}

- (void)addAllPlayerSelectionOptions {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Preload/Promo Image with Preroll" embedCode:@"Zlcmp0ZDrpHlAFWFsOBsgEXFepeSXY4c" viewController: [OptionsViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Preload/Promo Image with Midroll" embedCode:@"pncmp0ZDp7OKlwTPJlMZzrI59j8Imefa" viewController: [OptionsViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Preload/Promo Image with Postroll" embedCode:@"Zpcmp0ZDpaB-90xK8MIV9QF973r1ZdUf" viewController: [OptionsViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Preload/Promo Image with HLS Video" embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1" viewController: [OptionsViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Preload/Promo Image with InitialTime" embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1" viewController: [OptionsViewController class]]];
  PlayerSelectionOption *option = [[PlayerSelectionOption alloc] initWithTitle:@"HLS Video with timeout" embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1" viewController: [OptionsViewController class]];
  option.nib = @"PlayerDoubleText";
  [self insertNewObject: option];

  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"TV Ratings Configuration" embedCode:@"c4eHZjcjqNetoCDCmzY_ApifO3qBuWpi" viewController: [TVRatingsPlayerViewController class]]];
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

#pragma mark - Table view data source

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
  if ([selection.title rangeOfString:@"initialPlayTime"].location != NSNotFound) {
    ((OptionsViewController *)controller).initialTime = 20;
  }
  [self.navigationController pushViewController:controller animated:YES];
}

@end
