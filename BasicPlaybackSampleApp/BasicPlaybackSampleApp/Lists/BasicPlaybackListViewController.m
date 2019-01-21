/**
 * @class      BasicPlaybackListViewController BasicPlaybackListViewController.m "BasicPlaybackListViewController.m"
 * @brief      A list of playback examples that demonstrate basic playback
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "BasicPlaybackListViewController.h"
#import "BasicSimplePlayerViewController.h"
#import "SampleAppPlayerViewController.h"
#import "QRScannerViewController.h"

#import "PlayerSelectionOption.h"

@interface BasicPlaybackListViewController ()

@property (nonatomic) NSArray *options;
@property BOOL qaLogEnabled;

@end

@implementation BasicPlaybackListViewController

- (NSArray *)basicPlayerSelectionOptions {
  return @[
           [[PlayerSelectionOption alloc] initWithTitle:@"audio long"
                                              embedCode:@"I4cDBmZzE6GRYVnZyNOBhmeVUEi_DluP"
                                                  pcode:@"Q1bW0yOsRxnrzAjzXI2wUlZp9h53"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class
                                            isAudioOnly:YES],
           [[PlayerSelectionOption alloc] initWithTitle:@"audio_hls delivery"
                                              embedCode:@"NybzBmZzE6n6LYZgsxJNthUnAn1_xrcV"
                                                  pcode:@"Q1bW0yOsRxnrzAjzXI2wUlZp9h53"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class
                                            isAudioOnly:YES],
           [[PlayerSelectionOption alloc] initWithTitle:@"HLS Video"
                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"MP4 Video"
                                              embedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"VOD with CCs"
                                              embedCode:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"2.0 and 5.1 HLS Video"
                                              embedCode:@"oza2pxODE6Vm_TTHPKJ68gBD8JQ7oTuj"
                                                  pcode:@"B3MDExOuTldXc1CiXbzAauYN7Iui"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"4:3 Aspect Ratio"
                                              embedCode:@"FwaXZjcjrkydIftLal2cq9ymQMuvjvD8"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Vertical 16:9"
                                              embedCode:@"9od3M3MDE6-WRg_DRbpCzRyjtK-NTLMp"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"VAST Ad Pre-roll"
                                              embedCode:@"Zlcmp0ZDrpHlAFWFsOBsgEXFepeSXY4c"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"VAST Ad Mid-roll"
                                              embedCode:@"pncmp0ZDp7OKlwTPJlMZzrI59j8Imefa"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"VAST Ad Post-roll"
                                              embedCode:@"Zpcmp0ZDpaB-90xK8MIV9QF973r1ZdUf"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"VAST Ad Wrapper"
                                              embedCode:@"pqaWp0ZDqo17Z-Dn_5YiVhjcbQYs5lhq"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Ad Pre-roll"
                                              embedCode:@"M4cmp0ZDpYdy8kiL4UD910Rw_DWwaSnU"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Ad Mid-roll"
                                              embedCode:@"xhcmp0ZDpnDB2-hXvH7TsYVQKEk_89di"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Ad Post-roll"
                                              embedCode:@"Rjcmp0ZDr5yFbZPEfLZKUveR_2JzZjMO"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Multi Ad combination"
                                              embedCode:@"Ftcmp0ZDoz8tALmhPcN2vMzCdg7YU9lc"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Scan Code"
                                              embedCode:@""
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:BasicSimplePlayerViewController.class]
           ];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  self.title = @"Basic Playback";

  _options = self.basicPlayerSelectionOptions;

  UISwitch *swtLog = [UISwitch new];
  [swtLog addTarget:self
             action:@selector(changeSwitch:)
   forControlEvents:UIControlEventValueChanged];
  UILabel *lblLog = [[UILabel alloc] initWithFrame:CGRectMake(0,0,44,44)];
  lblLog.text = @"QA";
  
  UIBarButtonItem * btn = [[UIBarButtonItem alloc] initWithCustomView:swtLog];
  UIBarButtonItem * lbl = [[UIBarButtonItem alloc] initWithCustomView:lblLog];
  self.navigationItem.rightBarButtonItems = @[btn, lbl] ;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]
       forCellReuseIdentifier:@"TableCell"];
}

- (void)changeSwitch:(id)sender{
  if ([sender isOn]){
    NSLog(@"Switch is ON");
    self.qaLogEnabled = YES;
  } else{
    NSLog(@"Switch is OFF");
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
  SampleAppPlayerViewController *controller;
  if (selection.embedCode.length > 0) {
    controller = [(BasicSimplePlayerViewController *)[selection.viewController alloc] initWithPlayerSelectionOption:selection qaModeEnabled:self.qaLogEnabled];
  } else {
    controller = [[QRScannerViewController alloc] initWithPlayerSelectionOption:selection qaModeEnabled:self.qaLogEnabled];
  }
  [self.navigationController pushViewController:controller animated:YES];
}

@end
