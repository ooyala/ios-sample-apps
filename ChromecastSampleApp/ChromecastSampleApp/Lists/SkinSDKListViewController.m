//
//  SkinSDKListViewController.m
//  ChromecastSampleApp
//
//  Created on 4/2/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import "SkinSDKListViewController.h"
#import "OptionsDataSource.h"
#import "ChromecastPlayerSelectionOption.h"
#import "SkinPlayerViewController.h"

@interface SkinSDKListViewController ()

@property (nonatomic) NSIndexPath *lastSelected;

@end

@implementation SkinSDKListViewController

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return OptionsDataSource.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ChromecastPlayerSelectionOption *mediaInfo = OptionsDataSource.options[indexPath.row];

  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.text = mediaInfo.title;

  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Display the media details view.
  self.lastSelected = indexPath;
  [self performSegueWithIdentifier:@"play" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  SkinPlayerViewController *controller = segue.destinationViewController;
  ChromecastPlayerSelectionOption *selection = OptionsDataSource.options[self.lastSelected.row];
  controller.mediaInfo = selection;
}

@end
