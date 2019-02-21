/**
 * @class      CocoaPodsListViewController CocoaPodsListViewController.m "CocoaPodsListViewController.m"
 * @brief      The BasicPlaybackSampleApp, repurposed to demonstrate CocoaPods integration
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "CocoaPodsListViewController.h"
#import "BasicSimplePlayerViewController.h"
#import "SampleAppPlayerViewController.h"

#import "PlayerSelectionOption.h"

@interface CocoaPodsListViewController ()

@property NSMutableArray *options;
@property NSArray *optionList;
@property NSArray *optionEmbedCodes;

@end

@implementation CocoaPodsListViewController

- (void)addAllBasicPlayerSelectionOptions {
  for (long i = self.optionList.count - 1; i >= 0; i--) {
    [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:self.optionList[i]
                                                              embedCode:self.optionEmbedCodes[i]
                                                         viewController:BasicSimplePlayerViewController.class]];
  }
}

- (void)initTitlesAndEmbedCodes {
  self.optionList = @[
                     @"HLS Video",
                     @"MP4 Video",
                     @"VOD with CCs",
                     @"4:3 Aspect Ratio"
                     ];
  
  self.optionEmbedCodes = @[
                           @"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1",
                           @"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx",
                           @"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww",
                           @"FwaXZjcjrkydIftLal2cq9ymQMuvjvD8"
                           ];
  
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Basic Playback";
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]
       forCellReuseIdentifier:@"TableCell"];
  
  [self initTitlesAndEmbedCodes];
  [self addAllBasicPlayerSelectionOptions];
}

- (void)insertNewObject:(PlayerSelectionOption *)selectionObject {
  if (!self.options) {
    self.options = [NSMutableArray array];
  }
  [self.options insertObject:selectionObject atIndex:0];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  // When a row is selected, load its desired PlayerViewController
  PlayerSelectionOption *selection = self.options[indexPath.row];
  SampleAppPlayerViewController *controller = [(BasicSimplePlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
