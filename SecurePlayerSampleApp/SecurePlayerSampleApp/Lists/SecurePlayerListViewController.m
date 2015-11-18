/**
 * @class      SecurePlayerListViewController SecurePlayerListViewController.m "SecurePlayerListViewController.m"
 * @brief      A list of playback examples that demonstrate playback using the SecurePlayer Integration
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "SecurePlayerListViewController.h"
#import "SecurePlayerPlayerViewController.h"
#import "SampleAppPlayerViewController.h"
#import "SecurePlayerOPTPlayerViewController.h"
#import "PlayerSelectionOption.h"
#import "QRScannerViewController.h"

@interface SecurePlayerListViewController ()
@property NSMutableArray *options;
@property NSMutableArray *optionList;
@property NSMutableArray *optionEmbedCodes;
@end

@implementation SecurePlayerListViewController

- (id)init {
  self = [super init];
  self.title = @"Secure Player Integration";
  return self;
}

- (void)addAllSecurePlayerSelectionOptions {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"VOD with CC Asset"
                                                                  embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                      pcode:@"FoeG863GnBL4IhhlFC1Q2jqbkH9m"
                                                                     domain:@"http://www.ooyala.com"
                                                             viewController:[SecurePlayerPlayerViewController class]]];


  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Encrypted HLS VOD"
                                                                  embedCode:@"ZtZmtmbjpLGohvF5zBLvDyWexJ70KsL-"
                                                                      pcode:@"FoeG863GnBL4IhhlFC1Q2jqbkH9m"
                                                                     domain:@"http://www.ooyala.com"
                                                             viewController:[SecurePlayerPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Clear HLS VOD"
                                                                  embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                      pcode:@"FoeG863GnBL4IhhlFC1Q2jqbkH9m"
                                                                     domain:@"http://www.ooyala.com"
                                                             viewController:[SecurePlayerPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Microsoft Clear Smooth VOD"
                                                                  embedCode:@"1nNGk2bTq5ECsz5cRlZ4ONAAk96drr6T"
                                                                      pcode:@"FoeG863GnBL4IhhlFC1Q2jqbkH9m"
                                                                     domain:@"http://www.ooyala.com"
                                                             viewController:[SecurePlayerPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Microsoft Playready Smooth VOD"
                                                                  embedCode:@"V2NWk2bTpI1ac0IaicMaFuMcIrmE9U-_"
                                                                      pcode:@"FoeG863GnBL4IhhlFC1Q2jqbkH9m"
                                                                     domain:@"http://www.ooyala.com"
                                                             viewController:[SecurePlayerPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Playready HLS VOD with Closed Captions"
                                                                  embedCode:@"xrcGYydDq1wU7nSmX7AQB3Uq4Fu3BjuE"
                                                                      pcode:@"FoeG863GnBL4IhhlFC1Q2jqbkH9m"
                                                                     domain:@"http://www.ooyala.com"
                                                             viewController:[SecurePlayerPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Playready Smooth VOD"
                                                                  embedCode:@"5jNzJuazpFtKmloYZQmgPeC_tqDKHX9r"
                                                                      pcode:@"FoeG863GnBL4IhhlFC1Q2jqbkH9m"
                                                                     domain:@"http://www.ooyala.com"
                                                             viewController:[SecurePlayerPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Device Limit(Unconfigured)"
                                                                  embedCode:@"0xNmpoczpeNkx6Pq8ZOPwPUu6CuzFKeY"
                                                                      pcode:@"N5dGEyOrMsKgdLgNp2B0wirtpqm7"
                                                                     domain:@"http://www.ooyala.com"
                                                             viewController:[SecurePlayerPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Device Bind to Entitlement"
                                                                  embedCode:@"Q3NmpoczpUH__SVSKRI0BbFl3A9CtHSL"
                                                                      pcode:@"N5dGEyOrMsKgdLgNp2B0wirtpqm7"
                                                                     domain:@"http://www.ooyala.com"
                                                             viewController:[SecurePlayerPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Scan code"
                                                                  embedCode:@""
                                                                      pcode:@""
                                                                     domain:@"http://www.ooyala.com"
                                                             viewController:[SecurePlayerPlayerViewController class]]];

}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]forCellReuseIdentifier:@"TableCell"];

  [self addAllSecurePlayerSelectionOptions];
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
    controller = [(SecurePlayerPlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection];
  } else {
    controller = [[QRScannerViewController alloc] initWithPlayerSelectionOption:selection];
  }
  [self.navigationController pushViewController:controller animated:YES];
}
@end
