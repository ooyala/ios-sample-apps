//
//  VideosTableViewController.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "VideosTableViewController.h"
#import "PlayerSelectionOption.h"
#import "VideoViewController.h"
#import "IMAVideoViewController.h"


@interface VideosTableViewController ()

  @property (nonatomic) NSMutableArray *playerNoAdSelectionOptions;
  @property (nonatomic) NSMutableArray *playerOoyalaSelectionOptions;
	@property (nonatomic) NSMutableArray *playerIMASelectionOptions;
  @property (nonatomic) NSMutableArray *playerVASTSelectionOptions;
  @property(nonatomic) BOOL qaModeEnabled;

@end


@implementation VideosTableViewController
  
#pragma mark - Constants
  
  static NSString *kDefaultPCode = @"BzY2syOq6kIK6PTXN7mmrGVSJEFj";
  static NSString *kDefaultDomain = @"http://www.ooyala.com";
  static NSString *kTableViewCellReuseID = @"VideosTableViewControllerTableViewCellReuseID";

#pragma mark - View controller life cycle

- (void)viewDidLoad {
	[super viewDidLoad];
  
  [self configureObjects];
  [self configureData];
}
  
#pragma mark - Private functions
  
- (void)configureObjects {
  
  // Table view
  self.tableView.tableFooterView = [UIView new];
  
  // Add switch to navigation bar
  UISwitch *qaSwitch = [[UISwitch alloc] init];
  [qaSwitch addTarget:self action:@selector(qaSwitchAction:) forControlEvents:UIControlEventValueChanged];
  
  UILabel *qaLabel = [[UILabel alloc]  initWithFrame:CGRectMake(0,0,44,44)];
  qaLabel.textAlignment = NSTextAlignmentRight;
  [qaLabel setText:@"QA"];
  
  UIBarButtonItem *qaSwithBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:qaSwitch];
  UIBarButtonItem *qaLabelBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:qaLabel];
  
  self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:qaSwithBarButtonItem, qaLabelBarButtonItem, nil];
}

- (void)configureData {
  
  // Set QA mode enabled/disabled
  _qaModeEnabled = NO;
  
  // Add player selection objects
  
  if (!_playerNoAdSelectionOptions) {
    _playerNoAdSelectionOptions = [NSMutableArray new];
  }
  
  if (!_playerOoyalaSelectionOptions) {
    _playerOoyalaSelectionOptions = [NSMutableArray new];
  }
  
  if (!_playerIMASelectionOptions) {
    _playerIMASelectionOptions = [NSMutableArray new];
  }
  
  if (!_playerVASTSelectionOptions) {
    _playerVASTSelectionOptions = [NSMutableArray new];
  }
  
  // No Ad
  [_playerNoAdSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Beach"
                                                                            embedCode:@"ZwdTE5YzE69c3U3cXy2CCzfnCkzMMqUP"
                                                                                pcode:kDefaultPCode
                                                                               domain:kDefaultDomain]];
  
  [_playerNoAdSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Crystal Showers watermark"
                                                                             embedCode:@"tvaTluYzE6gfZg5nhqlqxPV7YbEukBCj"
                                                                                 pcode:kDefaultPCode
                                                                                domain:kDefaultDomain]];
  
  [_playerNoAdSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Park long description"
                                                                             embedCode:@"syazl0YzE6sGVc6vA5sPUZK6RWp5aplu"
                                                                                 pcode:kDefaultPCode
                                                                                domain:kDefaultDomain]];

  // IMA
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Podded Pre-Mid-Post"
                                                                            embedCode:@"UyZGUyZDE6ht1KgaWXgoWhw2P2Kp8_Nb"
                                                                                pcode:kDefaultPCode
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Podded Mid"
                                                                            embedCode:@"B0Y2UyZDE6pvNJDlxvB8dEEbHCqJth0p"
                                                                                pcode:kDefaultPCode
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Pre-Roll"
                                                                            embedCode:@"Izbm1rYzE6Hr19rd1wK74qeraVA7xSLx"
                                                                                pcode:kDefaultPCode
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"In-Stream"
                                                                            embedCode:@"Q0dWFtYzE6RFRGuFP0WzuPE5dvBzJ8_R"
                                                                                pcode:kDefaultPCode
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Post-Roll"
                                                                            embedCode:@"N4bmNtYzE63wuc3QizkmmkA0HDZou83_"
                                                                                pcode:kDefaultPCode
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Pre-Mid-Post"
                                                                            embedCode:@"Z4Y2UyZDE6bi5ZhPJE860W8GcE3z6WkE"
                                                                                pcode:kDefaultPCode
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Beach Podded Pre-Mid-Post"
                                                                            embedCode:@"0wd2FtYzE6b3_hyeGPsLYUKzOIqXHKFi"
                                                                                pcode:kDefaultPCode
                                                                               domain:kDefaultDomain]];
  
  // VAST
  [_playerVASTSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Pre-Roll"
                                                                            embedCode:@"o5bm1rYzE6Iv00WKa3Wd67QUuulRGtTb"
                                                                                pcode:kDefaultPCode
                                                                               domain:kDefaultDomain]];
  
  [_playerVASTSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Beach In-Stream"
                                                                             embedCode:@"F3bW1rYzE6gd0C5kJ8ETeB-0yeawf2Cd"
                                                                                 pcode:kDefaultPCode
                                                                                domain:kDefaultDomain]];
  
  [_playerVASTSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"London Post-Roll"
                                                                             embedCode:@"h4dGFtYzE6pjfgMHC5ioFOiaq5BywAL6"
                                                                                 pcode:kDefaultPCode
                                                                                domain:kDefaultDomain]];
  
  [_playerVASTSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Pre-Mid-Post"
                                                                             embedCode:@"Z4Y2UyZDE6bi5ZhPJE860W8GcE3z6WkE"
                                                                                 pcode:kDefaultPCode
                                                                                domain:kDefaultDomain]];
  
  [_playerVASTSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Beach Podded Pre-Mid-Post"
                                                                             embedCode:@"ZpZGxoYzE6oThg4Hapb2gwUC-HBDJy8T"
                                                                                 pcode:kDefaultPCode
                                                                                domain:kDefaultDomain]];
  
  // Ooyala
  [_playerOoyalaSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ayutthaya Pre-Roll"
                                                                             embedCode:@"NibG1rYzE6B7m54kL380ZXwEsUUy4bIe"
                                                                                 pcode:kDefaultPCode
                                                                                domain:kDefaultDomain]];
  

}

- (PlayerSelectionOption *)playerSelectionOptionAtArray:(NSArray *)array andIndex:(NSInteger)index {
  
  if (index <= array.count - 1) {
    return array[index];
  }
  
  return  NULL;
}

- (void)openDefaultVideoViewControllerWith:(PlayerSelectionOption *)playerOption {
  
  if (playerOption) {
    
    VideoViewController *videoViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"VideoViewController"];
    
    [videoViewController configureWithPlayerSelectionOption:playerOption qaModeEnabled:_qaModeEnabled];
    
    [self.navigationController pushViewController:videoViewController animated:YES];
  }
}

- (void)openIMAVideoViewControllerWith:(PlayerSelectionOption *)playerOption {
  
  if (playerOption) {

    IMAVideoViewController *videoViewController = [[IMAVideoViewController alloc] initWithNibName:@"IMAVideoViewController" bundle:NULL];
    
    [videoViewController configureWithPlayerSelectionOption:playerOption qaModeEnabled:_qaModeEnabled];
    
    [self.navigationController pushViewController:videoViewController animated:YES];
  }
}

#pragma mark - Actions

- (void)qaSwitchAction:(id)sender {
  if ([sender isOn]) {
    _qaModeEnabled = YES;
  } else {
    _qaModeEnabled = NO;
  }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return _playerNoAdSelectionOptions.count;
      break;
      
    case 1:
      return _playerOoyalaSelectionOptions.count;
      break;
      
    case 2:
      return _playerIMASelectionOptions.count;
      break;
      
    case 3:
      return _playerVASTSelectionOptions.count;
      break;
      
    default:
      return 0;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseID];
  PlayerSelectionOption *playerOption;
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewCellReuseID];
  }
  
  cell.textLabel.text = @"";
  
  switch (indexPath.section) {
    case 0:
      playerOption = [self playerSelectionOptionAtArray:_playerNoAdSelectionOptions andIndex:indexPath.row];
      break;
      
    case 1:
      playerOption = [self playerSelectionOptionAtArray:_playerOoyalaSelectionOptions andIndex:indexPath.row];
      
    case 2:
      playerOption = [self playerSelectionOptionAtArray:_playerIMASelectionOptions andIndex:indexPath.row];
      break;
      
    case 3:
      playerOption = [self playerSelectionOptionAtArray:_playerVASTSelectionOptions andIndex:indexPath.row];
      break;
      
    default:
      break;
  }
  
  if (playerOption) {
    cell.textLabel.text = playerOption.title;
  } else {
    cell.textLabel.text = @"Error, can't load player option";
  }
  
  return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return @"No Ad";
      break;
      
    case 1:
      return @"Ooyala";
      break;
      
    case 2:
      return @"IMA";
      break;
      
    case 3:
      return @"VAST";
      break;
      
    default:
      break;
  }
  
  return @"Error, can't load section title";
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  PlayerSelectionOption *playerOption;
  
  switch (indexPath.section) {
    case 0: // No Ad
      playerOption = [self playerSelectionOptionAtArray:_playerNoAdSelectionOptions andIndex:indexPath.row];
      [self openDefaultVideoViewControllerWith:playerOption];
      break;
      
    case 1: // Ooyala
      playerOption = [self playerSelectionOptionAtArray:_playerOoyalaSelectionOptions andIndex:indexPath.row];
      [self openDefaultVideoViewControllerWith:playerOption];
      break;
      
    case 2: // IMA
      playerOption = [self playerSelectionOptionAtArray:_playerIMASelectionOptions andIndex:indexPath.row];
      [self openIMAVideoViewControllerWith:playerOption];
      break;
      
    case 3: // VAST
      playerOption = [self playerSelectionOptionAtArray:_playerVASTSelectionOptions andIndex:indexPath.row];
      [self openDefaultVideoViewControllerWith:playerOption];
      break;
      
    default:
      [self openDefaultVideoViewControllerWith:playerOption];
      break;
  }
}

@end
