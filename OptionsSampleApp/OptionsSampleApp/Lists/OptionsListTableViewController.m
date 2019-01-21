//
//  OptionsListTableViewController.m
//  OptionsSampleApp
//
//  Created on 12/18/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "IQConfigurationPlayerViewController.h"
#import "OptionsListTableViewController.h"
#import "TVRatingsPlayerViewController.h"
#import "OptionsViewController.h"
#import "PlayerSelectionOption.h"

@interface OptionsListTableViewController ()

@property (nonatomic) NSArray *options;
@property BOOL qaLogEnabled;

@end

@implementation OptionsListTableViewController

static NSString *cellId = @"pickerCell";

- (NSArray *)playerSelectionOptions {
  NSMutableArray *optionsArray = [[NSMutableArray alloc] initWithArray:@[
    [[PlayerSelectionOption alloc] initWithTitle:@"IQ Configuration Sample"
                                       embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                           pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                          domain:@"http://www.ooyala.com"
                                  viewController:IQConfigurationPlayerViewController.class],
    [[PlayerSelectionOption alloc] initWithTitle:@"Preload/Promo Image with InitialTime"
                                       embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                           pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                          domain:@"http://www.ooyala.com"
                                  viewController:OptionsViewController.class],
    [[PlayerSelectionOption alloc] initWithTitle:@"Preload/Promo Image with HLS Video"
                                       embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                           pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                          domain:@"http://www.ooyala.com"
                                  viewController:OptionsViewController.class],
    [[PlayerSelectionOption alloc] initWithTitle:@"Preload/Promo Image with Preroll"
                                       embedCode:@"Zlcmp0ZDrpHlAFWFsOBsgEXFepeSXY4c"
                                           pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                          domain:@"http://www.ooyala.com"
                                  viewController:OptionsViewController.class],
    [[PlayerSelectionOption alloc] initWithTitle:@"Preload/Promo Image with Midroll"
                                       embedCode:@"pncmp0ZDp7OKlwTPJlMZzrI59j8Imefa"
                                           pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                          domain:@"http://www.ooyala.com"
                                  viewController:OptionsViewController.class],
    [[PlayerSelectionOption alloc] initWithTitle:@"Preload/Promo Image with Postroll"
                                       embedCode:@"Zpcmp0ZDpaB-90xK8MIV9QF973r1ZdUf"
                                           pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                          domain:@"http://www.ooyala.com"
                                  viewController:OptionsViewController.class],
    [[PlayerSelectionOption alloc] initWithTitle:@"TV Ratings Configuration"
                                       embedCode:@"c4eHZjcjqNetoCDCmzY_ApifO3qBuWpi"
                                           pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                          domain:@"http://www.ooyala.com"
                                  viewController:TVRatingsPlayerViewController.class]]
                             ];
  PlayerSelectionOption *option = [[PlayerSelectionOption alloc] initWithTitle:@"HLS Video with timeout"
                                                                     embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                         pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                        domain:@"http://www.ooyala.com"
                                                                viewController:OptionsViewController.class];
  option.nib = @"PlayerDoubleText";
  [optionsArray addObject:option];
  return optionsArray;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.navigationController.navigationBar.translucent = NO;
  self.title = @"Options Configuration";

  _options = [NSArray array];
  _options = [self playerSelectionOptions];

  UISwitch *swtLog = [UISwitch new];
  [swtLog addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
  UILabel *lblLog = [[UILabel alloc] initWithFrame:CGRectMake(0,0,44,44)];
  lblLog.text = @"QA";
  UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:swtLog];
  UIBarButtonItem *lbl = [[UIBarButtonItem alloc] initWithCustomView:lblLog];
  self.navigationItem.rightBarButtonItems = @[btn, lbl] ;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];
}

- (void)changeSwitch:(id)sender{
  if ([sender isOn]) {
    self.qaLogEnabled=YES;
  } else {
    self.qaLogEnabled=NO;
  }
//  self.qaLogEnabled = [sender isOn];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
  // When a row is selected, load its desired PlayerViewController
  PlayerSelectionOption *selection = self.options[indexPath.row];
  SampleAppPlayerViewController *controller =
  [(SampleAppPlayerViewController *)[selection.viewController alloc] initWithPlayerSelectionOption:selection
                                                                                     qaModeEnabled:self.qaLogEnabled];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
