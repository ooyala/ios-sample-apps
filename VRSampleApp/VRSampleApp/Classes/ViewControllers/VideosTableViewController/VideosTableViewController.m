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
  @property (nonatomic) NSMutableArray *playerIMA360SelectionOptions;
  @property (nonatomic) NSMutableArray *playerOoyalaADS360SelectionOptions;
  @property (nonatomic) NSMutableArray *playerVAST360SelectionOptions;
  @property (nonatomic) NSMutableArray *playerIMA2DSelectionOptions;
  @property (nonatomic) NSMutableArray *playerOoyalaADS2DSelectionsOptions;
  @property (nonatomic) NSMutableArray *playerVAST2DSelectionOptions;
  @property (nonatomic) NSMutableArray *playerDiscoverySelectionOptions;
  @property(nonatomic) BOOL qaModeEnabled;

@end


@implementation VideosTableViewController
  
#pragma mark - Constants

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
  
  if (!_playerIMA360SelectionOptions) {
    _playerIMA360SelectionOptions = [NSMutableArray new];
  }
  
  if (!_playerOoyalaADS360SelectionOptions) {
    _playerOoyalaADS360SelectionOptions = [NSMutableArray new];
  }
  
  if (!_playerVAST360SelectionOptions) {
    _playerVAST360SelectionOptions = [NSMutableArray new];
  }
  
  if (!_playerIMA2DSelectionOptions) {
    _playerIMA2DSelectionOptions = [NSMutableArray new];
  }
  
  if (!_playerOoyalaADS2DSelectionsOptions) {
    _playerOoyalaADS2DSelectionsOptions = [NSMutableArray new];
  }
  
  if (!_playerVAST2DSelectionOptions) {
    _playerVAST2DSelectionOptions = [NSMutableArray new];
  }
  
  if (!_playerDiscoverySelectionOptions) {
    _playerDiscoverySelectionOptions = [NSMutableArray new];
  }
  
  // No Ad
  [_playerNoAdSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"2D Video"
                                                                            embedCode:@"VzZHd2YzE612sYDbk2UyuurOXrLgsVx9"]];
  
  [_playerNoAdSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Video 360"
                                                                             embedCode:@"ZwdTE5YzE69c3U3cXy2CCzfnCkzMMqUP"]];
  
  [_playerNoAdSelectionOptions addObject: [[PlayerSelectionOption alloc] initWithTitle:@"Video 360 long description"
                                                                             embedCode:@"syazl0YzE6sGVc6vA5sPUZK6RWp5aplu"]];
  
  [_playerNoAdSelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Video 360 watermark"
                                                                            embedCode:@"tvaTluYzE6gfZg5nhqlqxPV7YbEukBCj"]];
  
  [_playerNoAdSelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Video 360 High quality"
                                                                            embedCode:@"N5N2c2ZDE6DCsvCvSrgPHE5zerJ0oJYe"
                                                                                pcode:@"15OGsyOs7wTVvirAtV0F611vIpKH"]];

  // IMA 360
  [_playerIMA360SelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Pre-roll"
                                                                              embedCode:@"Izbm1rYzE6Hr19rd1wK74qeraVA7xSLx"]];
  
  [_playerIMA360SelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Mid-roll skippable"
                                                                              embedCode:@"Q0dWFtYzE6RFRGuFP0WzuPE5dvBzJ8_R"]];
  
  [_playerIMA360SelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Post-roll"
                                                                              embedCode:@"N4bmNtYzE63wuc3QizkmmkA0HDZou83_"]];
  
  [_playerIMA360SelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Pre-Mid-Post skippable"
                                                                              embedCode:@"Z4Y2UyZDE6bi5ZhPJE860W8GcE3z6WkE"]];
  
  [_playerIMA360SelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Podded 3Pre-3Mid-3Post"
                                                                              embedCode:@"UyZGUyZDE6ht1KgaWXgoWhw2P2Kp8_Nb"]];
  
  //Ooyala ADS 360
  
  [_playerOoyalaADS360SelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Pre-roll"
                                                                                    embedCode:@"NibG1rYzE6B7m54kL380ZXwEsUUy4bIe"]];
  
   //VAST 360
   
   [_playerVAST360SelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Pre-roll"
                                                                                embedCode:@"o5bm1rYzE6Iv00WKa3Wd67QUuulRGtTb"]];
   
   [_playerVAST360SelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Mid-roll skippable"
                                                                                embedCode:@"F3bW1rYzE6gd0C5kJ8ETeB-0yeawf2Cd"]];
   
   [_playerVAST360SelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Post-roll"
                                                                                embedCode:@"h4dGFtYzE6pjfgMHC5ioFOiaq5BywAL6"]];
   
   [_playerVAST360SelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Pre-Mid-Post"
                                                                                embedCode:@"g4YmNsYzE6zLuWf3eCAtcOdi0--i081X"]];
   
   [_playerVAST360SelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Podded 2Pre-2Mid-2Post"
                                                                                embedCode:@"ZpZGxoYzE6oThg4Hapb2gwUC-HBDJy8T"]];
   
   //IMA 2D
   
   [_playerIMA2DSelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Pre-roll"
                                                                              embedCode:@"tqd282ZDE6bX2evvxui_wI5HezO6oLZ1"]];
   
   [_playerIMA2DSelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Mid-roll skippable"
                                                                              embedCode:@"dyeW82ZDE6cFE2fW4sWqaOSmRHVWj8yp"]];
   
   [_playerIMA2DSelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Post-roll skippable"
                                                                              embedCode:@"tod282ZDE6wCNaEqZYcSaYPHVNX4_mSX"]];
   
   [_playerIMA2DSelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Pre-Mid-Post skippable"
                                                                              embedCode:@"tsd282ZDE6ntnpHkMcWP4MnuBQXR2PAw"]];
   
   //Ooyala 2D
  
  [_playerOoyalaADS2DSelectionsOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Pre-roll"
                                                                                    embedCode:@"dmNXA2ZDE636pnqwBZiB0askbt9JHYwQ"]];
   
   //VAST 2D
  
  [_playerVAST2DSelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Pre-roll skippable"
                                                                              embedCode:@"ltNHA2ZDE6utNFZtF3-nH9-3otMkG_Eq"]];
  
  [_playerVAST2DSelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Mid-roll skippable"
                                                                              embedCode:@"wwNnA2ZDE6SIhAkXssgiR6svHXAGBq-P"]];
  
  [_playerVAST2DSelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Post-roll skippable"
                                                                              embedCode:@"lxNHA2ZDE6uRDirY6LZsJRRGh2aBC6ZR"]];
  
  [_playerVAST2DSelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Pre-Mid-Post skippable"
                                                                              embedCode:@"lvNHA2ZDE6Zc-4j2o0-CmHAj6lJOKnSN"]];
  
  [_playerVAST2DSelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Podded 2Pre-2Mid-2Post skippable"
                                                                              embedCode:@"lzNHA2ZDE6_oDV04VtY7sg4Pr7jGErfG"]];
   
   //Discovery
  
  [_playerDiscoverySelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Video 360"
                                                                                 embedCode:@"hwZnUxZDE6CyfgVaLAOw4HlCzVUZGPnB"]];
  
  [_playerDiscoverySelectionOptions addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Video 2D"
                                                                                 embedCode:@"N2eG42ZDE6Zq5lNIARlre7Lp0wzglOvA"]];
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
	return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return _playerNoAdSelectionOptions.count;
      break;
      
    case 1:
      return _playerIMA360SelectionOptions.count;
      break;
      
    case 2:
      return _playerOoyalaADS360SelectionOptions.count;
      break;
      
    case 3:
      return _playerVAST360SelectionOptions.count;
      break;
    
    case 4:
      return _playerIMA2DSelectionOptions.count;
      break;
    
    case 5:
      return _playerOoyalaADS2DSelectionsOptions.count;
      break;
    
    case 6:
      return _playerVAST2DSelectionOptions.count;
      break;
    
    case 7:
      return _playerDiscoverySelectionOptions.count;
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
      playerOption = [self playerSelectionOptionAtArray:_playerIMA360SelectionOptions andIndex:indexPath.row];
      break;
      
    case 2:
      playerOption = [self playerSelectionOptionAtArray:_playerOoyalaADS360SelectionOptions andIndex:indexPath.row];
      break;
      
    case 3:
      playerOption = [self playerSelectionOptionAtArray:_playerVAST360SelectionOptions andIndex:indexPath.row];
      break;
    
    case 4:
      playerOption = [self playerSelectionOptionAtArray:_playerIMA2DSelectionOptions andIndex:indexPath.row];
      break;
    
    case 5:
      playerOption = [self playerSelectionOptionAtArray:_playerOoyalaADS2DSelectionsOptions andIndex:indexPath.row];
      break;
    
    case 6:
      playerOption = [self playerSelectionOptionAtArray:_playerVAST2DSelectionOptions andIndex:indexPath.row];
      break;
    
    case 7:
      playerOption = [self playerSelectionOptionAtArray:_playerDiscoverySelectionOptions andIndex:indexPath.row];
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
      return @"No ADS";
      
    case 1:
      return @"IMA ADS Video 360";
      
    case 2:
      return @"Ooyala ADS Video 360";
      
    case 3:
      return @"VAST ADS Video 360";
    
    case 4:
      return @"IMA ADS Video 2D";
    
    case 5:
      return @"Ooyala ADS Video 2D";
    
    case 6:
      return @"VAST ADS Video 2D";
    
    case 7:
      return @"Discovery";
    
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
      
    case 1: // IMA 360
      playerOption = [self playerSelectionOptionAtArray:_playerIMA360SelectionOptions andIndex:indexPath.row];
      [self openIMAVideoViewControllerWith:playerOption];
      break;
      
    case 2: // Ooyala 360
      playerOption = [self playerSelectionOptionAtArray:_playerOoyalaADS360SelectionOptions andIndex:indexPath.row];
      [self openDefaultVideoViewControllerWith:playerOption];
      break;
      
    case 3: // VAST 360
      playerOption = [self playerSelectionOptionAtArray:_playerVAST360SelectionOptions andIndex:indexPath.row];
      [self openDefaultVideoViewControllerWith:playerOption];
      break;
    
    case 4: // IMA 2D
      playerOption = [self playerSelectionOptionAtArray:_playerIMA2DSelectionOptions andIndex:indexPath.row];
      [self openIMAVideoViewControllerWith:playerOption];
      break;
    
    case 5: // Ooyala 2D
      playerOption = [self playerSelectionOptionAtArray:_playerOoyalaADS2DSelectionsOptions andIndex:indexPath.row];
      [self openDefaultVideoViewControllerWith:playerOption];
      break;
    
    case 6: // VAST 2D
      playerOption = [self playerSelectionOptionAtArray:_playerVAST2DSelectionOptions andIndex:indexPath.row];
      [self openDefaultVideoViewControllerWith:playerOption];
      break;
    
    case 7: // Discovery
      playerOption = [self playerSelectionOptionAtArray:_playerDiscoverySelectionOptions andIndex:indexPath.row];
      [self openDefaultVideoViewControllerWith:playerOption];
      break;
      
    default:
      [self openDefaultVideoViewControllerWith:playerOption];
      break;
  }
}

@end
