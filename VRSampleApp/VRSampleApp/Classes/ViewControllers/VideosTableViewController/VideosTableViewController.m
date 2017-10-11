//
//  VideosTableViewController.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "VideosTableViewController.h"
#import "PlayerSelectionOption.h"
#import "VideoViewController.h"


@interface VideosTableViewController ()

  @property (nonatomic) NSMutableArray *playerNoAdSelectionOptions;
  @property (nonatomic) NSMutableArray *playerOoyalaSelectionOptions;
	@property (nonatomic) NSMutableArray *playerIMASelectionOptions;
  @property (nonatomic) NSMutableArray *playerVASTSelectionOptions;
  @property(nonatomic) BOOL qaModeEnabled;

@end


@implementation VideosTableViewController
  
#pragma mark - Constants
  
  static NSString *kDefaultPCode = @"NsaGsyOsKcRsCFZkHnYdKEw7vFn-";
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
                                                                                pcode:@"570d91bf920b42cbae587bb1447e6fd8"
                                                                               domain:kDefaultDomain]];
  
  [_playerNoAdSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Crystal Showers watermark"
                                                                             embedCode:@"tvaTluYzE6gfZg5nhqlqxPV7YbEukBCj"
                                                                                 pcode:@"087d2ef5-9d39-43ed-a57a-16a312c87c0b"
                                                                                domain:kDefaultDomain]];
  
  [_playerNoAdSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Park long description"
                                                                             embedCode:@"syazl0YzE6sGVc6vA5sPUZK6RWp5aplu"
                                                                                 pcode:@"570d91bf920b42cbae587bb1447e6fd8"
                                                                                domain:kDefaultDomain]];

  // IMA
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Bridge Pre-Roll"
                                                                         embedCode:@"84NGJqYzE6147F1LN5EYgD3Sx7yi02nw"
                                                                                pcode:@"NsaGsyOsKcRsCFZkHnYdKEw7vFn-"
                                                                            domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Park Pre-Roll"
                                                                            embedCode:@"4yZ2tkYzE6fzd6n0mesHpSZuCjo7Vr4H"
                                                                                pcode:@"3e961eabae664aad9e3c788b638da096"
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"London Pre-Roll"
                                                                            embedCode:@"Izbm1rYzE6Hr19rd1wK74qeraVA7xSLx"
                                                                                pcode:@"bb4c1914044a40c2af381c5ac4c98618"
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Beach_1 In-Stream"
                                                                            embedCode:@"wzZGRnYzE61sAU0_gD0qYH-zAzA-uyZX"
                                                                                pcode:@"3e961eabae664aad9e3c788b638da096"
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Beach_2 In-Stream"
                                                                            embedCode:@"Q0dWFtYzE6RFRGuFP0WzuPE5dvBzJ8_R"
                                                                                pcode:@"bb4c1914044a40c2af381c5ac4c98618"
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Beach Post-Roll"
                                                                            embedCode:@"N4bmNtYzE63wuc3QizkmmkA0HDZou83_"
                                                                                pcode:@"bb4c1914044a40c2af381c5ac4c98618"
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Beach Pre-Mid-Post"
                                                                            embedCode:@"J0dmFtYzE675zb3G_f6UsvggJYTXVsF4"
                                                                                pcode:@"bb4c1914044a40c2af381c5ac4c98618"
                                                                               domain:kDefaultDomain]];
  
  [_playerIMASelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Beach Podded Pre-Mid-Post"
                                                                            embedCode:@"0wd2FtYzE6b3_hyeGPsLYUKzOIqXHKFi"
                                                                                pcode:@"bb4c1914044a40c2af381c5ac4c98618"
                                                                               domain:kDefaultDomain]];
  
  // VAST
  [_playerVASTSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Pre-Roll"
                                                                            embedCode:@"o5bm1rYzE6Iv00WKa3Wd67QUuulRGtTb"
                                                                                pcode:@"570d91bf920b42cbae587bb1447e6fd8"
                                                                               domain:kDefaultDomain]];
  
  [_playerVASTSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Beach In-Stream"
                                                                             embedCode:@"F3bW1rYzE6gd0C5kJ8ETeB-0yeawf2Cd"
                                                                                 pcode:@"570d91bf920b42cbae587bb1447e6fd8"
                                                                                domain:kDefaultDomain]];
  
  [_playerVASTSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"London Post-Roll"
                                                                             embedCode:@"h4dGFtYzE6pjfgMHC5ioFOiaq5BywAL6"
                                                                                 pcode:@"570d91bf920b42cbae587bb1447e6fd8"
                                                                                domain:kDefaultDomain]];
  
  [_playerVASTSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Pre-Mid-Post"
                                                                             embedCode:@"g4YmNsYzE6zLuWf3eCAtcOdi0--i081X"
                                                                                 pcode:@"570d91bf920b42cbae587bb1447e6fd8"
                                                                                domain:kDefaultDomain]];
  
  [_playerVASTSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Beach Podded Pre-Mid-Post"
                                                                             embedCode:@"ZpZGxoYzE6oThg4Hapb2gwUC-HBDJy8T"
                                                                                 pcode:@"087d2ef5-9d39-43ed-a57a-16a312c87c0b"
                                                                                domain:kDefaultDomain]];
  
  // Ooyala
  [_playerOoyalaSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Ayutthaya Pre-Roll"
                                                                             embedCode:@"NibG1rYzE6B7m54kL380ZXwEsUUy4bIe"
                                                                                 pcode:@"570d91bf920b42cbae587bb1447e6fd8"
                                                                                domain:kDefaultDomain]];
  

}

- (PlayerSelectionOption *)playerSelectionOptionAtArray:(NSArray *)array andIndex:(NSInteger)index {
  if (index <= array.count - 1) {
    return array[index];
  }
  
  return  NULL;
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
    case 0:
      playerOption = [self playerSelectionOptionAtArray:_playerNoAdSelectionOptions andIndex:indexPath.row];
      break;
      
    case 1:
      playerOption = [self playerSelectionOptionAtArray:_playerOoyalaSelectionOptions andIndex:indexPath.row];
      break;
      
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
    
    VideoViewController *videoViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"VideoViewController"];
    
    [videoViewController configureWithPlayerSelectionOption:playerOption qaModeEnabled:_qaModeEnabled];
    
    [self.navigationController pushViewController:videoViewController animated:YES];
  }
}

@end
