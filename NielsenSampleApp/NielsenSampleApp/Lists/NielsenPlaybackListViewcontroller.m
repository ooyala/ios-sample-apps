/**
 * @class      NielsenPlaybackListViewcontroller NielsenPlaybackListViewcontroller.m
 "NielsenPlaybackListViewcontroller.m"
 * @brief      A list of playback examples that demonstrate Nielsen analytics playback
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "NielsenPlaybackListViewcontroller.h"
#import "NielsenPlayerViewController.h"
#import "PlayerSelectionOption.h"

@interface NielsenPlaybackListViewcontroller ()

@property NSArray *options;

@end

@implementation NielsenPlaybackListViewcontroller

- (NSArray *)allPlayerSelectionOptions {
  return @[
           [[PlayerSelectionOption alloc] initWithTitle:@"ID3-Demo"
                                              embedCode:@"84aDVmcTqN3FrdLXClZgJq-GfFEDhS1a"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                         viewController:NielsenPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"ID3-Live"
                                              embedCode:@"p4ZXNwdDrfdg2vz04LdpbRg94XXb7d_c"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                         viewController:NielsenPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"CMS-Demo"
                                              embedCode:@"ZhMmkycjr4jlHIjvpIIimQSf_CjaQs48"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                         viewController:NielsenPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"CMS-WithAds"
                                              embedCode:@"x3YjJzczqREV-5RDiemsrdqki1FYu2NT"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                         viewController:NielsenPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"CMS-14min"
                                              embedCode:@"JyanIxdDoj9MhKbVEmTJEG8O4QF5xExb"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                         viewController:NielsenPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"CMS-Live"
                                              embedCode:@"RuZXNwdDpcWdrXskPkw73Mosq6sw6Fux"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                         viewController:NielsenPlayerViewController.class]
           ];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"IMA Playback";
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];

  _options = [NSArray arrayWithArray:self.allPlayerSelectionOptions];
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
  cell.textLabel.text = [selection title];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // When a row is selected, load its desired PlayerViewController
  PlayerSelectionOption *selection = self.options[indexPath.row];
  SampleAppPlayerViewController *controller = [(SampleAppPlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
