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

@property (nonatomic) NSMutableArray *options;
@property (nonatomic) NSMutableArray *optionList;
@property (nonatomic) NSMutableArray *optionEmbedCodes;
@property (nonatomic) BOOL qaLogEnabled;

@end

@implementation OoyalaSkinListViewController

#pragma mark - Initialization
- (id)init {
  self = [super init];
  self.title = @"Ooyala Skin Sample App";
  return self;
}

#pragma mark - View Controller Lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  
  UISwitch *swtLog = [UISwitch new];
  [swtLog addTarget:self
             action:@selector(changeSwitch:)
   forControlEvents:UIControlEventValueChanged];
  UILabel *lblLog = [[UILabel alloc] initWithFrame:CGRectMake(0,0,44,44)];
  lblLog.text = @"QA";
  
  UIBarButtonItem * btn = [[UIBarButtonItem alloc] initWithCustomView:swtLog];
  UIBarButtonItem * lbl = [[UIBarButtonItem alloc] initWithCustomView:lblLog];
  self.navigationItem.rightBarButtonItems = @[btn, lbl] ;
  
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]forCellReuseIdentifier:@"TableCell"];

  [self addTestCases];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)insertNewObject:(PlayerSelectionOption *)selectionObject {
  if (!self.options) {
    self.options = [[NSMutableArray alloc] init];
  }
  [self.options addObject:selectionObject];
}

-(void)addCommonWithTitle:(NSString*)title embedCode:(NSString*)embedCode pcode:(NSString *)pcode {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:title
                                                            embedCode:embedCode
                                                                pcode:pcode
                                                         playerDomain:@"http://www.ooyala.com"
                                                       viewController: [DefaultSkinPlayerViewController class]
                                                                  nib:@"PlayerSingleButton"]];
}

#pragma mark - Custom Selectors
- (void)changeSwitch:(id)sender{
  if ([sender isOn]){
    NSLog(@"Switch is ON");
    self.qaLogEnabled = YES;
  } else{
    NSLog(@"Switch is OFF");
    self.qaLogEnabled = NO;
  }
}

- (void)addTestCases {
  // subclasses need to override this to add test cases.
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
  SampleAppPlayerViewController *controller = [(SampleAppPlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection qaModeEnabled:self.qaLogEnabled];
  [self.navigationController pushViewController:controller animated:YES];
}
@end
