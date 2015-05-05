/**
 * @class      BasicPlaybackListViewController BasicPlaybackListViewController.m "BasicPlaybackListViewController.m"
 * @brief      A list of playback examples that demonstrate basic playback
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "BasicPlaybackListViewController.h"
#import "BasicSimplePlayerViewController.h"
#import "SampleAppPlayerViewController.h"

#import "PlayerSelectionOption.h"

@interface BasicPlaybackListViewController ()
@property NSMutableArray *options;
@property NSMutableArray *optionList;
@property NSMutableArray *optionEmbedCodes;
@end

@implementation BasicPlaybackListViewController

- (id)init {
  self = [super init];
  self.title = @"Basic Playback";
  return self;
}

- (void)addAllBasicPlayerSelectionOptions {
  for(long i = [self.optionList count] - 1; i >= 0; i--) {
    [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:[self.optionList objectAtIndex:i] embedCode:[self.optionEmbedCodes objectAtIndex:i] viewController: [BasicSimplePlayerViewController class]]];
  }
}

- (void) initTitlesAndEmbedCodes {
  self.optionList = [[NSMutableArray alloc] initWithObjects:
                     @"HLS Video",
                     @"MP4 Video",
                     @"VOD with CCs",
                     @"4:3 Aspect Ratio",
                     @"VAST Ad Pre-roll",
                     @"VAST Ad Mid-roll",
                     @"VAST Ad Post-roll",
                     @"VAST Ad Wrapper",
                     @"Ooyala Ad Pre-roll",
                     @"Ooyala Ad Mid-roll",
                     @"Ooyala Ad Post-roll",
                     @"Multi Ad combination", nil];
  
  self.optionEmbedCodes = [[NSMutableArray alloc] initWithObjects:
                           @"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1",
                           @"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx",
                           @"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww",
                           @"FwaXZjcjrkydIftLal2cq9ymQMuvjvD8",
                           @"Zlcmp0ZDrpHlAFWFsOBsgEXFepeSXY4c", // VAST Preroll
                           @"pncmp0ZDp7OKlwTPJlMZzrI59j8Imefa", // VAST Midroll
                           @"Zpcmp0ZDpaB-90xK8MIV9QF973r1ZdUf", // VAST Postroll
                           @"pqaWp0ZDqo17Z-Dn_5YiVhjcbQYs5lhq", // VAST Wrapper
                           @"M4cmp0ZDpYdy8kiL4UD910Rw_DWwaSnU", // OOYALA Preroll
                           @"xhcmp0ZDpnDB2-hXvH7TsYVQKEk_89di", // OOYALA Midroll
                           @"Rjcmp0ZDr5yFbZPEfLZKUveR_2JzZjMO", // OOYALA Postroll
                           @"Ftcmp0ZDoz8tALmhPcN2vMzCdg7YU9lc", // Multi Ad combination
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
  SampleAppPlayerViewController *controller = [(BasicSimplePlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection];
  [self.navigationController pushViewController:controller animated:YES];
}
@end
