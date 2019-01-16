/**
 * @class      IMAPlaybackListViewcontroller IMAPlaybackListViewcontroller.m
 "IMAPlaybackListViewcontroller.m"
 * @brief      A list of playback examples that demonstrate IMA Ad playback
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "IMAPlaybackListViewcontroller.h"
#import "IMAPlayerViewController.h"
#import "IMACustomConfiguredPlayerViewController.h"
#import "PlayerSelectionOption.h"

@interface IMAPlaybackListViewcontroller ()
@property (nonatomic) NSArray *options;
@property (nonatomic) BOOL qaLogEnabled;
@end

@implementation IMAPlaybackListViewcontroller

- (NSArray *)playerSelectionOptions {
  return @[
//           TODO: Replace with a new ad rules preroll asset, this embed code is broken
//           [[PlayerSelectionOption alloc] initWithTitle:@"Ad-Rules Preroll"
//                                              embedCode:@"EzZ29lcTq49IswgZYkMknnU4Ukb9PQMH"
//                                                  pcode:@"R2NDYyOhSRhYj0UrUVgcdWlFVP-H"
//                                                 domain:@"http://www.ooyala.com"
//                                         viewController:IMAPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Ad-Rules Midroll"
                                              embedCode:@"VlaG9lcTqeUU18adfd1DVeQ8YekP3H4l"
                                                  pcode:@"R2NDYyOhSRhYj0UrUVgcdWlFVP-H"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:IMAPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Ad-Rules Postroll"
                                              embedCode:@"BnaG9lcTqLXQNyod7ON8Yv3eDas2Oog6"
                                                  pcode:@"R2NDYyOhSRhYj0UrUVgcdWlFVP-H"
                                                domain:@"http://www.ooyala.com"
                                        viewController:IMAPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Podded Preroll"
                                              embedCode:@"1wNjE3cDox0G3hQIWxTjsZ8MPUDLSkDY"
                                                  pcode:@"R2NDYyOhSRhYj0UrUVgcdWlFVP-H"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:IMAPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Podded Midroll"
                                              embedCode:@"1yNjE3cDodUEfUfp2WNzHkCZCMb47MUP"
                                                  pcode:@"R2NDYyOhSRhYj0UrUVgcdWlFVP-H"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:IMAPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Podded Postroll"
                                              embedCode:@"1sNjE3cDoN3ZewFm1238ce730J4BMrEJ"
                                                  pcode:@"R2NDYyOhSRhYj0UrUVgcdWlFVP-H"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:IMAPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Podded Pre-Mid-Post"
                                              embedCode:@"ZrOTE3cDoXo2sLOWzQPxjS__M-Qk32Co"
                                                  pcode:@"R2NDYyOhSRhYj0UrUVgcdWlFVP-H"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:IMAPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Skippable"
                                              embedCode:@"FhbGRjbzq8tfaoA3dhfxc2Qs0-RURJfO"
                                                  pcode:@"R2NDYyOhSRhYj0UrUVgcdWlFVP-H"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:IMAPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Pre, Mid and Post Skippable"
                                              embedCode:@"10NjE3cDpj8nUzYiV1PnFsjC6nEvPQAE"
                                                  pcode:@"R2NDYyOhSRhYj0UrUVgcdWlFVP-H"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:IMAPlayerViewController.class],
           [[PlayerSelectionOption alloc] initWithTitle:@"Client-side configured IMA Ads"
                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:IMACustomConfiguredPlayerViewController.class]
           ];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  self.title = @"IMA Playback";

  _options = [NSArray array];
  _options = self.playerSelectionOptions;

  UISwitch *swtLog = [UISwitch new];
  [swtLog addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
  UILabel *lblLog = [[UILabel alloc] initWithFrame:CGRectMake(0,0,44,44)];
  lblLog.text = @"QA";
  
  UIBarButtonItem * btn = [[UIBarButtonItem alloc] initWithCustomView:swtLog];
  UIBarButtonItem * lbl = [[UIBarButtonItem alloc] initWithCustomView:lblLog];
  self.navigationItem.rightBarButtonItems = @[btn, lbl];
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]
       forCellReuseIdentifier:@"TableCell"];
}

- (void)changeSwitch:(id)sender{
  if ([sender isOn]){
    NSLog(@"Switch is ON");
    self.qaLogEnabled=YES;
  } else {
    NSLog(@"Switch is OFF");
    self.qaLogEnabled=NO;
  }
  //  self.qaLogEnabled = [sender isOn];
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
  SampleAppPlayerViewController *controller = [(SampleAppPlayerViewController *)[selection.viewController alloc] initWithPlayerSelectionOption:selection qaModeEnabled:self.qaLogEnabled];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
