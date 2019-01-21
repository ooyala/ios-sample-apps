/**
 * @class      BasicPlaybackListViewController BasicPlaybackListViewController.m "BasicPlaybackListViewController.m"
 * @brief      A list of playback examples that demonstrate basic playback
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "OoyalaSkinListViewController.h"
#import "DefaultSkinPlayerViewController.h"
#import "SampleAppPlayerViewController.h"

#import "PlayerSelectionOption.h"

@interface OoyalaSkinListViewController ()

@property (nonatomic) BOOL qaLogEnabled;

@end

@implementation OoyalaSkinListViewController

- (void)addTestCases {
  // subclasses need to override this to add test cases.
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.navigationController.navigationBar.translucent = NO;
  self.title = @"Ooyala Skin Sample App";
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]
       forCellReuseIdentifier:@"TableCell"];
  
  UISwitch *swtLog = [UISwitch new];
  [swtLog addTarget:self
             action:@selector(changeSwitch:)
   forControlEvents:UIControlEventValueChanged];
  UILabel *lblLog = [[UILabel alloc] initWithFrame:CGRectMake(0,0,44,44)];
  lblLog.text = @"QA";
  
  UIBarButtonItem * btn = [[UIBarButtonItem alloc] initWithCustomView:swtLog];
  UIBarButtonItem * lbl = [[UIBarButtonItem alloc] initWithCustomView:lblLog];
  self.navigationItem.rightBarButtonItems = @[btn, lbl];

  [self addTestCases];
}

- (void)changeSwitch:(id)sender{
  if ([sender isOn]) {
    self.qaLogEnabled = YES;
  } else{
    self.qaLogEnabled = NO;
  }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // When a row is selected, load its desired PlayerViewController
  PlayerSelectionOption *selection = self.options[indexPath.row];
  SampleAppPlayerViewController *controller = [(SampleAppPlayerViewController *)[selection.viewController alloc] initWithPlayerSelectionOption:selection qaModeEnabled:self.qaLogEnabled];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
