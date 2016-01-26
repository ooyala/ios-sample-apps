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
@property NSMutableArray *options;
@property NSMutableArray *optionList;
@property NSMutableArray *optionEmbedCodes;
@end

@implementation OoyalaSkinListViewController

- (id)init {
  self = [super init];
  self.title = @"Ooyala Skin Sample App";
  return self;
}

-(void)addCommonWithTitle:(NSString*)title embedCode:(NSString*)embedCode {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:title
                                                            embedCode:embedCode
                                                                pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                         playerDomain:@"http://www.ooyala.com"
                                                       viewController: [DefaultSkinPlayerViewController class]
                                                                  nib:@"DefaultSkinPlayerView"]];
}

- (void)addTestCases {
  // subclasses need to override this to add test cases.
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]forCellReuseIdentifier:@"TableCell"];

  [self addTestCases];
}

- (void)insertNewObject:(PlayerSelectionOption *)selectionObject {
  if (!self.options) {
    self.options = [[NSMutableArray alloc] init];
  }
  [self.options addObject:selectionObject];
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
  SampleAppPlayerViewController *controller = [(SampleAppPlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection];
  [self.navigationController pushViewController:controller animated:YES];
}
@end
