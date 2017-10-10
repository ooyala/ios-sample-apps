//
//  ContentProtectionListViewController.m
//  ContentProtectionListViewController
//
//  Created by Liusha Huang on 2/23/15.
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "ContentProtectionListViewController.h"
#import "PlayerSelectionOption.h"
#import "AdobePassPlayerViewController.h"
#import "OoyalaPlayerTokenPlayerViewController.h"
#import "FairplayPlayerViewController.h"
#import "DeviceManagementPlayerViewController.h"
#import "SampleAppPlayerViewController.h"

@interface ContentProtectionListViewController ()
@property NSMutableArray *options;
@property NSMutableArray *optionList;
@property NSMutableArray *optionEmbedCodes;
@end

@implementation ContentProtectionListViewController

- (id)init {
  self = [super init];
  self.title = @"Content Protection Sample App";
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]forCellReuseIdentifier:@"TableCell"];

// Adobe's sample Adobe Pass MVPD doesn't respect App Transport Security.  Commented out for now
//  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Adobe Pass"
//                                                            embedCode:@"VybW5lODrJ0uM9FBo7XTT6TNjTJfr_7G"
//                                                                pcode:@"B3MDExOuTldXc1CiXbzAauYN7Iui"
//                                                               domain:@"http://www.ooyala.com"
//                                                       viewController: [AdobePassPlayerViewController class]]];
// TODO: [PBA-5945] Fix asset configuration
//  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Device Management (Unconfigured)"
//                                                            embedCode:@""
//                                                                pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
//                                                               domain:@"http://www.ooyala.com"
//                                                       viewController: [DeviceManagementPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Player Token (Unconfigured)"
                                                            embedCode:@"0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52"
                                                                pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                               domain:@"http://www.ooyala.com"
                                                       viewController: [OoyalaPlayerTokenPlayerViewController class]]];
// TODO: [PBA-5945] Fix asset configuration
//  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"FairPlay (Unconfigured)"
//                                                            embedCode:@"BuMjEwMDE6b8-bX45pBkcgFieNehCcln"
//                                                                pcode:@"RkcjMxOtMYDwJzrPy3sWJLl6blS1"
//                                                               domain:@"http://www.ooyala.com"
//                                                       viewController: [FairplayPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"FairPlay Ooyala Player Token (Unconfigured)"
                                                            embedCode:@"c1cGpjMzE6-7Fi9nhZ01iK3Gfsyrddiu"
                                                                pcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                                               domain:@"http://www.ooyala.com"
                                                       viewController: [FairplayPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Fairplay Baseline Profile (Unconfigured)"
                                                            embedCode:@"V3NDdnMzE6tPCchL9wYTFZY8jAE8_Y21"
                                                                pcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                                               domain:@"http://www.ooyala.com"
                                                       viewController: [FairplayPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Fairplay Main Profile (Unconfigured)"
                                                            embedCode:@"cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ"
                                                                pcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                                               domain:@"http://www.ooyala.com"
                                                       viewController: [FairplayPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Fairplay High Profile (Unconfigured)"
                                                            embedCode:@"d2dzhnMzE6h-LTaIavPD5k2eqLeCTMC5"
                                                                pcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                                               domain:@"http://www.ooyala.com"
                                                       viewController: [FairplayPlayerViewController class]]];
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
    // Dispose of any resources that can be recreated.
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
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];

  PlayerSelectionOption *selection = self.options[indexPath.row];
  cell.textLabel.text = [selection title];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  PlayerSelectionOption *selection = self.options[indexPath.row];
  SampleAppPlayerViewController *controller = [(SampleAppPlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection];
  [self.navigationController pushViewController:controller animated:YES];
}
@end
