/**
 * @class      BasicPlaybackListViewController BasicPlaybackListViewController.m "BasicPlaybackListViewController.m"
 * @brief      A list of playback examples that demonstrate basic playback
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "NPAWListViewController.h"
#import "NPAWDefaultPlayerViewController.h"
#import "SampleAppPlayerViewController.h"

#import "PlayerSelectionOption.h"

@interface NPAWListViewController ()
@property NSMutableArray *options;
@property NSMutableArray *optionList;
@property NSMutableArray *optionEmbedCodes;
@end

@implementation NPAWListViewController

- (id)init {
  self = [super init];
  self.title = @"Basic Playback";
  return self;
}

- (void)addAllBasicPlayerSelectionOptions {
  for(long i = [self.optionList count] - 1; i >= 0; i--) {
    [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:[self.optionList objectAtIndex:i] embedCode:[self.optionEmbedCodes objectAtIndex:i] viewController: [NPAWDefaultPlayerViewController class]]];
  }
}

- (void) initTitlesAndEmbedCodes {
  self.optionList = [[NSMutableArray alloc] initWithObjects:
                     @"HLS Video",
                     nil];
  
  self.optionEmbedCodes = [[NSMutableArray alloc] initWithObjects:
                           @"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1",
                           nil];
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]forCellReuseIdentifier:@"TableCell"];
  
  [self initTitlesAndEmbedCodes];
  [self addAllBasicPlayerSelectionOptions];
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
  SampleAppPlayerViewController *controller = [(NPAWDefaultPlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection];
  [self.navigationController pushViewController:controller animated:YES];
}
@end
