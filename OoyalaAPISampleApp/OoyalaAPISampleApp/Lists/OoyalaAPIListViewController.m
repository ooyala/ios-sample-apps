/**
 * @class      OoyalaAPIListViewController OoyalaAPIListViewController.m "OoyalaAPIListViewController.m"
 * @brief      A list of playback examples that demonstrate usage of the Ooyala APIs
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "OoyalaAPIListViewController.h"
#import "ChannelContentTreePlayerViewController.h"
#import "PlaylistListViewController.h"
#import "DiscoveryListViewController.h"
#import "PlayerSelectionOption.h"

@interface OoyalaAPIListViewController ()

@property NSArray *channelList;
@property (nonatomic) NSMutableArray *options;
@property (nonatomic) BOOL qaLogEnabled;

@end

@implementation OoyalaAPIListViewController

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
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];

  if (_channelList == nil) {
    PlayerSelectionOption *option1 =
      [[PlayerSelectionOption alloc] initWithTitle:@"Content Tree for Channel"
                                         embedCode:@"txaGRiMzqQZSmFpMML92QczdIYUrcYVe"
                                             pcode:@"R2d3I6s06RyB712DN0_2GsQS-R-Y"
                                            domain:@"http://www.ooyala.com"
                                    viewController:[ChannelContentTreePlayerViewController class]];
    PlayerSelectionOption *option2 =
      [[PlayerSelectionOption alloc] initWithTitle:@"Discovery Results"
                                         embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                             pcode:@""
                                            domain:@""
                                    viewController:[DiscoveryListViewController class]];
    PlayerSelectionOption *option3 =
    [[PlayerSelectionOption alloc] initWithTitle:@"Playlists API"
                                       embedCode:@""
                                           pcode:@""
                                          domain:@"http://www.ooyala.com"
                                  viewController:[PlaylistListViewController class]];
    _channelList = [NSArray arrayWithObjects:option3, option1, option2,   nil];
  }
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.channelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];

  PlayerSelectionOption *selection = self.channelList[indexPath.row];
  cell.textLabel.text = [selection title];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // When a row is selected, load its desired PlayerViewController
  PlayerSelectionOption *selection = self.channelList[indexPath.row];
   UIViewController *controller = (UIViewController *)[[selection viewController] new];
    
  if ([controller isKindOfClass:[ChannelContentTreePlayerViewController class]]) {
    ((ChannelContentTreePlayerViewController *)controller).option = selection;
  } else if ([controller isKindOfClass:[DiscoveryListViewController class]]) {
    ((DiscoveryListViewController *)controller).embedCode = selection.embedCode;
  } else if ([controller isKindOfClass:[PlaylistListViewController class]]) {
    ((PlaylistListViewController *)controller).option = selection;
  }
  [self.navigationController pushViewController:controller animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */


@end
