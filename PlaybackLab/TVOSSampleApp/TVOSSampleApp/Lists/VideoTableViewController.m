//
//  VideoTableViewController.m
//  TVOSSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "VideoTableViewController.h"
#import "AbstractPlayerViewController.h"
#import "FullscreenPlayerViewController.h"
#import "PulseLibraryViewController.h"
#import "FairplayPlayerViewController.h"
#import "PlayerSelectionOption.h"
#import "OoyalaPlayerTokenPlayerViewController.h"

@interface VideoTableViewController ()

@property (nonatomic) NSArray *options; // of Video.h

@end

@implementation VideoTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _options = [NSArray arrayWithArray:self.playerSelectionOptions];
}

- (NSArray *)playerSelectionOptions {
  return @[
           [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Pulse Integration"
                                              embedCode:nil
                                                  pcode:nil
                                                 domain:nil
                                              segueName:@"pulseSegue"],
           [[PlayerSelectionOption alloc] initWithTitle:@"Fullscreen Player"
                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                              segueName:@"fullscreenSegue"],
           [[PlayerSelectionOption alloc] initWithTitle:@"5.1 Audio, Single HLS Rendition"
                                              embedCode:@"04bnlxNzE6ZoNIUuEwvnso0Q5u2jOx_M"
                                                  pcode:@"B3MDExOuTldXc1CiXbzAauYN7Iui"
                                                 domain:@"http://www.ooyala.com"
                                              segueName:@"fullscreenSegue"],
           [[PlayerSelectionOption alloc] initWithTitle:@"5.1 Audio E-AC3"
                                              embedCode:@"kyeHR5ODE6FDXOC9eZ5DTKuiJGVo0jnh"
                                                  pcode:@"B3MDExOuTldXc1CiXbzAauYN7Iui"
                                                 domain:@"http://www.ooyala.com"
                                              segueName:@"fullscreenSegue"],
           [[PlayerSelectionOption alloc] initWithTitle:@"Player Token (Unconfigured)"
                                              embedCode:@"0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                              segueName:@"playerTokenSegue"],
           [[PlayerSelectionOption alloc] initWithTitle:@"Fairplay Baseline Profile (Unconfigured)"
                                              embedCode:@"V3NDdnMzE6tPCchL9wYTFZY8jAE8_Y21"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                              segueName:@"fairplaySegue"],
           [[PlayerSelectionOption alloc] initWithTitle:@"Fairplay Main Profile (Unconfigured)"
                                              embedCode:@"cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                              segueName:@"fairplaySegue"],
           [[PlayerSelectionOption alloc] initWithTitle:@"Fairplay High Profile (Unconfigured)"
                                              embedCode:@"d2dzhnMzE6h-LTaIavPD5k2eqLeCTMC5"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"
                                              segueName:@"fairplaySegue"]];
  // Read the comments in ChildPlayerViewController.h to know what this example is for
//           [[PlayerSelectionOption alloc] initWithTitle:@"Inline Player"
//                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
//                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
//                                                 domain:@"http://www.ooyala.com"
//                                              segueName:@"childSegue"]
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell"
                                                          forIndexPath:indexPath];
  PlayerSelectionOption *option = self.options[indexPath.row];
  cell.textLabel.text = option.title;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  PlayerSelectionOption *option = self.options[indexPath.row];
  [self performSegueWithIdentifier:option.segueName
                            sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
  if ([segue.identifier isEqualToString:@"fullscreenSegue"]) {
    FullscreenPlayerViewController *destinationVC = segue.destinationViewController;
    destinationVC.option = self.options[indexPath.row];
  } else if ([segue.identifier isEqualToString:@"pulseSegue"]) {
    // no options passed here as the Pulse integration sample has its own content library
  } else if ([segue.identifier isEqualToString:@"childSegue"]){
    AbstractPlayerViewController *destinationVC = segue.destinationViewController;
    destinationVC.option = self.options[indexPath.row];
  } else if ([segue.identifier isEqualToString:@"playerTokenSegue"]) {
    OoyalaPlayerTokenPlayerViewController *destinationVC = segue.destinationViewController;
    destinationVC.option = self.options[indexPath.row];
  } else {
    FairplayPlayerViewController *destinationVC = segue.destinationViewController;
    destinationVC.option = self.options[indexPath.row];
  }
}

@end
