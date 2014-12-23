//
//  OptionsListTableViewController.m
//  OptionsSampleApp
//
//  Created by Zhihui Chen on 12/18/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "OptionsListTableViewController.h"
#import "OptionsViewController.h"

@interface OptionsListTableViewController ()

@property (nonatomic) NSArray *titles;
@property (nonatomic) NSArray *embedCodes;

@end

@implementation OptionsListTableViewController

static NSString *cellId = @"pickerCell";

- (void)viewDidLoad {
  [super viewDidLoad];

  _titles = [NSArray arrayWithObjects:@"VAST Preroll", @"VAST Midroll", @"VAST postroll", @"Plain HLS Video", @"HLS Video with initialPlayTime", nil];
  _embedCodes = [NSArray arrayWithObjects:
                 @"Zlcmp0ZDrpHlAFWFsOBsgEXFepeSXY4c",
                 @"pncmp0ZDp7OKlwTPJlMZzrI59j8Imefa",
                 @"Zpcmp0ZDpaB-90xK8MIV9QF973r1ZdUf",
                 @"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1",
                 @"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1", nil];
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  [(UITableView*)self.view registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
  }
  cell.textLabel.text = [_titles objectAtIndex:indexPath.row];
  return cell;
}

- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  OptionsViewController *playerController;
  // Override point for customization after application launch.
  playerController = [[OptionsViewController alloc] initWithNibName:@"PlayerDoubleSwitch" bundle:nil];

  playerController.embedCode = [_embedCodes objectAtIndex:indexPath.row];
  NSString *title = [_titles objectAtIndex:indexPath.row];
  if ([title rangeOfString:@"initialPlayTime"].location != NSNotFound) {
    playerController.initialTime = 20;
  }
  [self.navigationController pushViewController:playerController animated:YES];
}


@end
