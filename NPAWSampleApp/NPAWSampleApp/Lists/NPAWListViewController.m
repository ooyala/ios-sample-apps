/**
 * @class      BasicPlaybackListViewController BasicPlaybackListViewController.m "BasicPlaybackListViewController.m"
 * @brief      A list of playback examples that demonstrate basic playback
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "NPAWListViewController.h"
#import "NPAWDefaultPlayerViewController.h"
#import "NPAWOptionalMetadataPlayerViewController.h"
#import "SampleAppPlayerViewController.h"

#import "PlayerSelectionOption.h"

@interface NPAWListViewController ()
@property NSMutableArray *options;
@property BOOL qaLogEnabled;
@property NSMutableArray *optionList;
@property NSMutableArray *optionEmbedCodes;
@end

@implementation NPAWListViewController

- (id)init {
  self = [super init];
  self.title = @"NPAW Youbora Integration";
  return self;
}

- (void)addAllPlayerSelectionOptions {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Basic NPAW Youbura Integration"
                                                            embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                               domain:@"http://www.ooyala.com"
                                                       viewController: [NPAWDefaultPlayerViewController class]]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"NPAW with Optional Metadata"
                                                            embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                               domain:@"http://www.ooyala.com"
                                                       viewController: [NPAWOptionalMetadataPlayerViewController class]]];

}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
    UISwitch *swtLog = [[UISwitch alloc] init];
    [swtLog addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    UILabel *lblLog = [[UILabel alloc]  initWithFrame:CGRectMake(0,0,44,44)];
    [lblLog setText:@"QA"];
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc] initWithCustomView:swtLog];
    UIBarButtonItem * lbl = [[UIBarButtonItem alloc] initWithCustomView:lblLog];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:btn,lbl, nil] ;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]forCellReuseIdentifier:@"TableCell"];

  [self addAllPlayerSelectionOptions];
}

- (void)changeSwitch:(id)sender{
    if([sender isOn]){
        NSLog(@"Switch is ON");
        self.qaLogEnabled=YES;
    }else{
        NSLog(@"Switch is OFF");
        self.qaLogEnabled=NO;
    }
    //  self.qaLogEnabled = [sender isOn];
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
  SampleAppPlayerViewController *controller = [(NPAWDefaultPlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection qaModeEnabled:self.qaLogEnabled];
  [self.navigationController pushViewController:controller animated:YES];
}
@end
